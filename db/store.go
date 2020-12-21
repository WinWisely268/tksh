package db

import (
	"fmt"
	"github.com/segmentio/ksuid"
	log "github.com/sirupsen/logrus"
	"github.com/timshannon/badgerhold/v2"
	"github.com/winwisely268/tksh/rpc"
	"google.golang.org/protobuf/types/known/timestamppb"
	"time"
)

type Storage struct {
	logger *log.Entry
	store  *badgerhold.Store
}

func InitStorage(dirpath, encryptionKey string, logger *log.Entry) (*Storage, error) {
	options := badgerhold.DefaultOptions
	options.EncryptionKey = []byte(encryptionKey)
	options.Dir = dirpath
	options.ValueDir = dirpath
	store, err := badgerhold.Open(options)
	if err != nil {
		return nil, err
	}
	return &Storage{
		logger: logger,
		store:  store,
	}, nil
}

type TRecord struct {
	Id      string `badgerholdIndex:"Id"`
	Tanggal time.Time
	Jumlah  float64
	Bukti   []byte
}

func fromRpcNewRecord(id string, bukti []byte, in *rpc.NewTransferRecord) *TRecord {
	var tgl time.Time
	juml := 0.0
	if in.GetTanggal() != nil {
		tgl = in.GetTanggal().AsTime()
	}
	juml = in.GetTransfer()
	return &TRecord{
		Id:      id,
		Tanggal: tgl,
		Jumlah:  juml,
		Bukti:   bukti,
	}
}

func fromRpcUpdRecord(pastRecord *TRecord, bukti []byte, in *rpc.UpdateTransferRecord) *TRecord {
	if in.GetTransfer() != 0.0 {
		pastRecord.Jumlah = in.GetTransfer()
	}
	if bukti != nil && len(bukti) > 0 {
		pastRecord.Bukti = bukti
	}
	return pastRecord
}

func (t *TRecord) toRpc() *rpc.TransferRecord {
	return &rpc.TransferRecord{
		Id:       t.Id,
		Tanggal:  timestamppb.New(t.Tanggal),
		Transfer: t.Jumlah,
		Bukti:    t.Bukti,
	}
}

func (s *Storage) InsertRecord(in *rpc.NewTransferRecord, bukti []byte) (*rpc.TransferRecord, error) {
	key := ksuid.New().String()
	err := s.store.Insert(key, fromRpcNewRecord(key, bukti, in))
	if err != nil {
		return nil, err
	}
	res := &TRecord{}
	if err = s.store.FindOne(res, badgerhold.Where("Id").Eq(key)); err != nil {
		return nil, err
	}
	return res.toRpc(), nil
}

func (s *Storage) UpdateRecord(in *rpc.UpdateTransferRecord, bukti []byte) (*rpc.TransferRecord, error) {
	if in.GetId() == "" {
		return nil, fmt.Errorf("key cannot be empty")
	}
	res := &TRecord{}
	if err := s.store.FindOne(res, badgerhold.Where("Id").Eq(in.GetId())); err != nil {
		return nil, err
	}
	updatedRequest := fromRpcUpdRecord(res, bukti, in)
	if err := s.store.Update(updatedRequest.Id, res); err != nil {
		return nil, err
	}
	if err := s.store.FindOne(res, badgerhold.Where("Id").Eq(res.Id)); err != nil {
		return nil, err
	}
	return res.toRpc(), nil
}

func (s *Storage) ListRecords(sortBy string) (*rpc.ReportAll, error) {
	if sortBy == "" {
		sortBy = "Tanggal"
	}
	reports := []*TRecord{}
	err := s.store.Find(&reports, nil)
	if err != nil {
		return nil, err
	}
	rpcReports := []*rpc.TransferRecord{}
	for _, rep := range reports {
		rpcReport := rep.toRpc()
		rpcReports = append(rpcReports, rpcReport)
	}
	return &rpc.ReportAll{ReportItems: rpcReports}, nil
}
