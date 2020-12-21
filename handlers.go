package main

import (
	"bytes"
	"context"
	"fmt"
	"github.com/disintegration/imaging"
	log "github.com/sirupsen/logrus"
	"github.com/winwisely268/tksh/db"
	"github.com/winwisely268/tksh/rpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"image"
	"image/png"
	"io"
	"io/ioutil"
	"net/http"
	"path/filepath"
	"strings"
)

const (
	maxFileSize       = 4 << 20 // max file upload is 4 MB
	defaultJpgQuality = 80
	downloadChunkSize = 1 << 20 / 2
)

type tkshService struct {
	logger *log.Entry
	store  *db.Storage
}

func (t *tkshService) NewTransfer(stream rpc.TkshService_NewTransferServer) error {
	req, err := stream.Recv()
	if err != nil {
		return status.Errorf(codes.InvalidArgument, "cannot upload file: %v", err)
	}
	var bukti []byte
	initialReq := req
	fileBuf := bytes.Buffer{}
	fileSize := 0
	for {
		req, err = stream.Recv()
		if err != nil {
			if err == io.EOF {
				break
			}
			return status.Errorf(codes.Unknown, "cannot receive stream chunk: %v", err)
		}
		chunk := req.GetUploadRequest().GetChunk()
		chunkSize := len(chunk)
		fileSize += chunkSize
		if fileSize > maxFileSize {
			return status.Error(codes.Aborted, "file size exceeds maximum file size, aborting")
		}
		_, err = fileBuf.Write(chunk)
		if err != nil {
			return status.Errorf(codes.Internal, "cannot write file data to buffer: %v", err)
		}
	}
	bukti, err = imgEncode("", fileBuf.Bytes())
	if err != nil {
		return err
	}
	tr, err := t.store.InsertRecord(initialReq, bukti)
	if err != nil {
		return err
	}
	if err = stream.SendAndClose(tr); err != nil {
		return status.Errorf(codes.Internal, "cannot encode upload resp: %v", err)
	}
	t.logger.Infof("Saved resource: %s, %f", tr.Id, tr.Transfer)
	return nil
}

func (t *tkshService) GetReport(ctx context.Context, req *rpc.ReportRequest) (*rpc.ReportAll, error) {
	f, err := t.store.ListRecords(req.GetSortBy())
	if err != nil {
		return nil, err
	}
	return f, nil
}

func (t *tkshService) UpdateTransfer(stream rpc.TkshService_UpdateTransferServer) error {
	req, err := stream.Recv()
	if err != nil {
		return status.Errorf(codes.InvalidArgument, "cannot upload file: %v", err)
	}
	initialReq := req
	var bukti []byte
	if req.GetUploadRequest().GetChunk() != nil && len(req.GetUploadRequest().GetChunk()) > 0 {
		fileBuf := bytes.Buffer{}
		fileSize := 0
		for {
			req, err = stream.Recv()
			if err != nil {
				if err == io.EOF {
					break
				}
				return status.Errorf(codes.Unknown, "cannot receive stream chunk: %v", err)
			}
			chunk := req.GetUploadRequest().GetChunk()
			chunkSize := len(chunk)
			fileSize += chunkSize
			if fileSize > maxFileSize {
				return status.Error(codes.Aborted, "file size exceeds maximum file size, aborting")
			}
			_, err = fileBuf.Write(chunk)
			if err != nil {
				return status.Errorf(codes.Internal, "cannot write file data to buffer: %v", err)
			}
		}
		b, err := imgEncode("", fileBuf.Bytes())
		if err != nil {
			return status.Errorf(codes.Internal, "cannot encode image: %v", err)
		}
		bukti = b
	}
	tr, err := t.store.UpdateRecord(initialReq, bukti)
	if err != nil {
		return err
	}
	if err = stream.SendAndClose(tr); err != nil {
		return status.Errorf(codes.Internal, "cannot encode upload resp: %v", err)
	}
	t.logger.Infof("Saved resource: %s, %f", tr.Id, tr.Transfer)
	return nil
}

func imgEncode(fpath string, content []byte) ([]byte, error) {
	var ext string
	if fpath != "" {
		ext = filepath.Ext(fpath)
	} else {
		ext = fmt.Sprintf(".%s", strings.Split(http.DetectContentType(content), "/")[1])
	}
	b := bytes.Buffer{}
	var img image.Image
	var fmtExt imaging.Format
	var f []byte
	var err error
	if ext[1:] == "png" || ext[1:] == "jpg" || ext[1:] == "jpeg" {
		fmtExt, err = imaging.FormatFromExtension(ext)
		if fpath != "" && content == nil {
			img, err = imaging.Open(fpath)
			if err != nil {
				return nil, err
			}
		} else {
			buf := bytes.NewBuffer(content)
			img, err = imaging.Decode(buf)
			if err != nil {
				return nil, err
			}
		}
	} else {
		if fpath != "" && content == nil {
			f, err = ioutil.ReadFile(fpath)
			if err != nil {
				return nil, err
			}
			b.Write(f)
		} else if content != nil {
			b.Write(content)
		}
	}
	if fmtExt.String() != "" {
		switch fmtExt {
		case imaging.JPEG:
			err = imaging.Encode(&b, img, fmtExt, imaging.JPEGQuality(defaultJpgQuality))
		case imaging.PNG:
			err = imaging.Encode(&b, img, fmtExt, imaging.PNGCompressionLevel(png.BestSpeed))
		default:
			err = fmt.Errorf("invalid image format, only supports jp(e)g and png currently, got: %s", fmtExt.String())
		}
		if err != nil {
			return nil, err
		}
	}
	return b.Bytes(), nil
}
