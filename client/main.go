package main

import (
	"bufio"
	"bytes"
	"context"
	"crypto/tls"
	"crypto/x509"
	"encoding/pem"
	"fmt"
	"github.com/getcouragenow/protoc-gen-cobra/client"
	"github.com/getcouragenow/protoc-gen-cobra/flag"
	"github.com/getcouragenow/protoc-gen-cobra/iocodec"
	"github.com/getcouragenow/protoc-gen-cobra/naming"
	log "github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	"github.com/spf13/pflag"
	"github.com/winwisely268/tksh/helper"
	"github.com/winwisely268/tksh/rpc"
	"golang.org/x/oauth2"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	"google.golang.org/grpc/credentials/oauth"
	"google.golang.org/protobuf/types/known/timestamppb"
	"io"
	"io/ioutil"
	"net/http"
	"path/filepath"
	"time"
)

const (
	chunkSize = 1 << 20 // chunk to 1MB

	errUpload = "cannot upload file: %s, reason: %v"
	addr      = "perbaikankaca.fly.dev:443"
)

type tkshClient struct{}

func (t *tkshClient) NewTransferRecord(cfg *client.Config) *cobra.Command {
	var fileName string
	var jumlah float64
	var tgl int64
	cmd := &cobra.Command{
		Use:   "new",
		Short: "New transfer RPC client",
		Long:  "New transfer RPC client",
		RunE: func(cmd *cobra.Command, args []string) error {
			if cfg.UseEnvVars {
				if err := flag.SetFlagsFromEnv(cmd.Parent().PersistentFlags(), true, cfg.EnvVarNamer, cfg.EnvVarPrefix, "BSService"); err != nil {
					return err
				}
				if err := flag.SetFlagsFromEnv(cmd.PersistentFlags(), false, cfg.EnvVarNamer, cfg.EnvVarPrefix, "BSService", "NewBootstrap"); err != nil {
					return err
				}
			}
			return client.RoundTrip(cmd.Context(), cfg, func(cc grpc.ClientConnInterface, in iocodec.Decoder, out iocodec.Encoder) error {
				cli := rpc.NewTkshServiceClient(cc)
				tanggal := time.Unix(tgl, 0)
				log.Infof("tanggal: %v", tanggal)
				abspath, err := filepath.Abs(fileName)
				if err != nil {
					log.Errorf("error getting absolute path: %v", err)
					return err
				}
				fileContent, err := ioutil.ReadFile(abspath)
				if err != nil {
					log.Errorf("cannot read file: %s", abspath)
					return err
				}
				mimeType := http.DetectContentType(fileContent)

				v := &rpc.NewTransferRecord{
					Transfer:      jumlah,
					Tanggal:       timestamppb.New(tanggal),
					BuktiFilepath: fileName,
					UploadRequest: &rpc.FileUploadRequest{
						FileInfo: &rpc.FileInfo{
							MimeType: mimeType,
						},
					},
				}

				stm, err := cli.NewTransfer(cmd.Context())
				if err != nil {
					return err
				}
				err = stm.Send(v)
				if err != nil {
					return err
				}
				reader := bufio.NewReader(bytes.NewBuffer(fileContent))
				buffer := make([]byte, chunkSize)
				for {
					var n int
					n, err = reader.Read(buffer)
					if err != nil {
						if err == io.EOF {
							break
						}
						return fmt.Errorf("cannot read chunk to buffer: %v", err)
					}
					v.UploadRequest.Chunk = buffer[:n]
					err = stm.Send(v)
					if err != nil {
						return fmt.Errorf("cannot send chunk to server: %v %v", err, stm.RecvMsg(nil))
					}
				}
				res, err := stm.CloseAndRecv()
				if err != nil {
					log.Errorf("unable to close server: %v", err)
					return err
				}
				return out(res)
			})
		},
	}
	cmd.PersistentFlags().StringVar(&fileName, cfg.FlagNamer("File"), "newuploadbootstrap.png", "png / jpg path")
	cmd.PersistentFlags().Float64Var(&jumlah, cfg.FlagNamer("Jumlah"), 0.0, "jumlah transfer")
	cmd.PersistentFlags().Int64Var(&tgl, cfg.FlagNamer("Tgl"), 1608537273, "tanggal transfer dalam unix second format")
	return cmd
}

func (t *tkshClient) UpdateTransferRecord(cfg *client.Config) *cobra.Command {
	var fileName string
	var jumlah float64
	var id string
	cmd := &cobra.Command{
		Use:   "update",
		Short: "Update transfer RPC client",
		Long:  "Update transfer RPC client",
		RunE: func(cmd *cobra.Command, args []string) error {
			if cfg.UseEnvVars {
				if err := flag.SetFlagsFromEnv(cmd.Parent().PersistentFlags(), true, cfg.EnvVarNamer, cfg.EnvVarPrefix, "BSService"); err != nil {
					return err
				}
				if err := flag.SetFlagsFromEnv(cmd.PersistentFlags(), false, cfg.EnvVarNamer, cfg.EnvVarPrefix, "BSService", "NewBootstrap"); err != nil {
					return err
				}
			}
			return client.RoundTrip(cmd.Context(), cfg, func(cc grpc.ClientConnInterface, in iocodec.Decoder, out iocodec.Encoder) error {
				cli := rpc.NewTkshServiceClient(cc)
				v := &rpc.UpdateTransferRecord{
					Id:            id,
					Transfer:      jumlah,
					BuktiFilepath: fileName,
				}
				abspath, err := filepath.Abs(fileName)
				if err != nil {
					return err
				}
				fileContent, err := ioutil.ReadFile(abspath)
				if err != nil {
					return err
				}

				stm, err := cli.UpdateTransfer(cmd.Context())
				if err != nil {
					return err
				}
				err = stm.Send(v)
				if err != nil {
					return err
				}
				reader := bufio.NewReader(bytes.NewBuffer(fileContent))
				buffer := make([]byte, chunkSize)
				for {
					var n int
					n, err = reader.Read(buffer)
					if err != nil {
						if err == io.EOF {
							break
						}
						return fmt.Errorf("cannot read chunk to buffer: %v", err)
					}
					v.UploadRequest.Chunk = buffer[:n]
					err = stm.Send(v)
					if err != nil {
						return fmt.Errorf("cannot send chunk to server: %v %v", err, stm.RecvMsg(nil))
					}
				}
				res, err := stm.CloseAndRecv()
				if err != nil {
					return err
				}
				return out(res)
			})
		},
	}
	cmd.PersistentFlags().StringVar(&fileName, cfg.FlagNamer("FilePath"), "newuploadbootstrap.png", "png / jpg path")
	cmd.PersistentFlags().Float64Var(&jumlah, cfg.FlagNamer("Jumlah"), 0.0, "jumlah transfer")
	cmd.PersistentFlags().StringVar(&id, cfg.FlagNamer("Id"), "1lxTCQQDSBRu0Dn7Iy5VtYbMGbE", "id (ksuid)")
	return cmd
}

func NewCLI(option ...client.Option) *cobra.Command {
	t := tkshClient{}
	rootCmd := rpc.TkshServiceClientCommand(option...)
	cfg := client.NewConfig(option...)
	rootCmd.AddCommand(t.NewTransferRecord(cfg), t.UpdateTransferRecord(cfg))
	return rootCmd
}

const (
	defaultTimeout = 5 * time.Second
)

func main() {
	srvCfg := client.WithServerAddr(addr)
	encoder := iocodec.JSONEncoderMaker(true)
	jsonCfg := client.WithOutputEncoder("json", encoder)
	flagBinder := func(fs *pflag.FlagSet, namer naming.Namer) {
		fs.StringVarP(&MainProxyCLIConfig.AccessKey, namer("JWT Access Token"), "j", MainProxyCLIConfig.AccessKey, "JWT Access Token")
	}
	preDialer := func(_ context.Context, opts *[]grpc.DialOption) error {
		cfg := MainProxyCLIConfig
		tkn := &oauth2.Token{
			TokenType: "Bearer",
		}
		if cfg.AccessKey != "" {
			tkn.AccessToken = cfg.AccessKey
			cred := oauth.NewOauthAccess(tkn)
			*opts = append(*opts, grpc.WithPerRPCCredentials(cred))
		}
		return nil
	}
	client.RegisterFlagBinder(flagBinder)
	client.RegisterPreDialer(preDialer)
	helper.CreateDir("certs")
	if err := getRemoteCACert(addr); err != nil {
		log.Fatalf("can't get certificate: %v", err)
	}
	caCfg := client.WithTLSCACertFile("certs/cacert.pem")
	clientOptions := []client.Option{
		srvCfg, jsonCfg, caCfg,
	}
	// clientOptions := []client.Option{
	// 	srvCfg, jsonCfg,
	// }
	cliCmd := NewCLI(clientOptions...)
	if err := cliCmd.Execute(); err != nil {
		log.Fatal(err)
	}
}

func clientLoadCA(cacertPath string) (credentials.TransportCredentials, error) {
	pemServerCA, err := ioutil.ReadFile(cacertPath)
	if err != nil {
		return nil, err
	}
	certPool := x509.NewCertPool()
	if !certPool.AppendCertsFromPEM(pemServerCA) {
		return nil, fmt.Errorf("failed to add server CA's certificate")
	}
	config := &tls.Config{
		RootCAs: certPool,
	}
	return credentials.NewTLS(config), nil
}

// func getRemoteCACert(domain string) (credentials.TransportCredentials, error) {
func getRemoteCACert(domain string) error {
	conf := &tls.Config{
		InsecureSkipVerify: true,
	}
	log.Printf(domain)
	conn, err := tls.Dial("tcp", domain, conf)
	if err != nil {
		return err
	}
	defer conn.Close()
	certs := conn.ConnectionState().PeerCertificates
	for _, cert := range certs {
		if cert.IsCA {
			publicKeyBlock := pem.Block{
				Type:  "CERTIFICATE",
				Bytes: cert.Raw,
			}
			publicKeyPem := pem.EncodeToMemory(&publicKeyBlock)
			err = ioutil.WriteFile("certs/cacert.pem", publicKeyPem, 0644)
			if err != nil {
				return err
			}
		}
	}
	return nil
}

type mainProxyCliConfig struct {
	AccessKey string
}

var MainProxyCLIConfig = &mainProxyCliConfig{}
