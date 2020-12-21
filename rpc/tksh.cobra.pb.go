// Code generated by protoc-gen-cobra. DO NOT EDIT.

package rpc

import (
	client "github.com/getcouragenow/protoc-gen-cobra/client"
	flag "github.com/getcouragenow/protoc-gen-cobra/flag"
	iocodec "github.com/getcouragenow/protoc-gen-cobra/iocodec"
	timestamp "github.com/golang/protobuf/ptypes/timestamp"
	cobra "github.com/spf13/cobra"
	grpc "google.golang.org/grpc"
	proto "google.golang.org/protobuf/proto"
	io "io"
)

func TkshServiceClientCommand(options ...client.Option) *cobra.Command {
	cfg := client.NewConfig(options...)
	cmd := &cobra.Command{
		Use:   cfg.CommandNamer("TkshService"),
		Short: "TkshService service client",
		Long:  "",
	}
	cfg.BindFlags(cmd.PersistentFlags())
	cmd.AddCommand(
		_TkshServiceNewTransferCommand(cfg),
		_TkshServiceUpdateTransferCommand(cfg),
		_TkshServiceGetReportCommand(cfg),
	)
	return cmd
}

func _TkshServiceNewTransferCommand(cfg *client.Config) *cobra.Command {
	req := &NewTransferRecord{
		Tanggal: &timestamp.Timestamp{},
		UploadRequest: &FileUploadRequest{
			FileInfo: &FileInfo{},
		},
	}

	cmd := &cobra.Command{
		Use:   cfg.CommandNamer("NewTransfer"),
		Short: "NewTransfer RPC client",
		Long:  "hide",
		RunE: func(cmd *cobra.Command, args []string) error {
			if cfg.UseEnvVars {
				if err := flag.SetFlagsFromEnv(cmd.Parent().PersistentFlags(), true, cfg.EnvVarNamer, cfg.EnvVarPrefix, "TkshService"); err != nil {
					return err
				}
				if err := flag.SetFlagsFromEnv(cmd.PersistentFlags(), false, cfg.EnvVarNamer, cfg.EnvVarPrefix, "TkshService", "NewTransfer"); err != nil {
					return err
				}
			}
			return client.RoundTrip(cmd.Context(), cfg, func(cc grpc.ClientConnInterface, in iocodec.Decoder, out iocodec.Encoder) error {
				cli := NewTkshServiceClient(cc)
				v := &NewTransferRecord{}

				stm, err := cli.NewTransfer(cmd.Context())
				if err != nil {
					return err
				}
				for {
					if err := in(v); err != nil {
						if err == io.EOF {
							_ = stm.CloseSend()
							break
						}
						return err
					}
					proto.Merge(v, req)
					if err = stm.Send(v); err != nil {
						return err
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

	cmd.PersistentFlags().Int64Var(&req.Tanggal.Seconds, cfg.FlagNamer("Tanggal Seconds"), 0, "Represents seconds of UTC time since Unix epoch\n 1970-01-01T00:00:00Z. Must be from 0001-01-01T00:00:00Z to\n 9999-12-31T23:59:59Z inclusive.")
	cmd.PersistentFlags().Int32Var(&req.Tanggal.Nanos, cfg.FlagNamer("Tanggal Nanos"), 0, "Non-negative fractions of a second at nanosecond resolution. Negative\n second values with fractions must still have non-negative nanos values\n that count forward in time. Must be from 0 to 999,999,999\n inclusive.")
	cmd.PersistentFlags().Float64Var(&req.Transfer, cfg.FlagNamer("Transfer"), 0, "")
	cmd.PersistentFlags().StringVar(&req.BuktiFilepath, cfg.FlagNamer("BuktiFilepath"), "", "")
	cmd.PersistentFlags().StringVar(&req.UploadRequest.FileInfo.MimeType, cfg.FlagNamer("UploadRequest FileInfo MimeType"), "", "")
	flag.BytesBase64Var(cmd.PersistentFlags(), &req.UploadRequest.Chunk, cfg.FlagNamer("UploadRequest Chunk"), "")

	return cmd
}

func _TkshServiceUpdateTransferCommand(cfg *client.Config) *cobra.Command {
	req := &UpdateTransferRecord{
		UploadRequest: &FileUploadRequest{
			FileInfo: &FileInfo{},
		},
	}

	cmd := &cobra.Command{
		Use:   cfg.CommandNamer("UpdateTransfer"),
		Short: "UpdateTransfer RPC client",
		Long:  "hide",
		RunE: func(cmd *cobra.Command, args []string) error {
			if cfg.UseEnvVars {
				if err := flag.SetFlagsFromEnv(cmd.Parent().PersistentFlags(), true, cfg.EnvVarNamer, cfg.EnvVarPrefix, "TkshService"); err != nil {
					return err
				}
				if err := flag.SetFlagsFromEnv(cmd.PersistentFlags(), false, cfg.EnvVarNamer, cfg.EnvVarPrefix, "TkshService", "UpdateTransfer"); err != nil {
					return err
				}
			}
			return client.RoundTrip(cmd.Context(), cfg, func(cc grpc.ClientConnInterface, in iocodec.Decoder, out iocodec.Encoder) error {
				cli := NewTkshServiceClient(cc)
				v := &UpdateTransferRecord{}

				stm, err := cli.UpdateTransfer(cmd.Context())
				if err != nil {
					return err
				}
				for {
					if err := in(v); err != nil {
						if err == io.EOF {
							_ = stm.CloseSend()
							break
						}
						return err
					}
					proto.Merge(v, req)
					if err = stm.Send(v); err != nil {
						return err
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

	cmd.PersistentFlags().StringVar(&req.Id, cfg.FlagNamer("Id"), "", "")
	cmd.PersistentFlags().Float64Var(&req.Transfer, cfg.FlagNamer("Transfer"), 0, "")
	cmd.PersistentFlags().StringVar(&req.BuktiFilepath, cfg.FlagNamer("BuktiFilepath"), "", "")
	cmd.PersistentFlags().StringVar(&req.UploadRequest.FileInfo.MimeType, cfg.FlagNamer("UploadRequest FileInfo MimeType"), "", "")
	flag.BytesBase64Var(cmd.PersistentFlags(), &req.UploadRequest.Chunk, cfg.FlagNamer("UploadRequest Chunk"), "")

	return cmd
}

func _TkshServiceGetReportCommand(cfg *client.Config) *cobra.Command {
	req := &ReportRequest{}

	cmd := &cobra.Command{
		Use:   cfg.CommandNamer("GetReport"),
		Short: "GetReport RPC client",
		Long:  "",
		RunE: func(cmd *cobra.Command, args []string) error {
			if cfg.UseEnvVars {
				if err := flag.SetFlagsFromEnv(cmd.Parent().PersistentFlags(), true, cfg.EnvVarNamer, cfg.EnvVarPrefix, "TkshService"); err != nil {
					return err
				}
				if err := flag.SetFlagsFromEnv(cmd.PersistentFlags(), false, cfg.EnvVarNamer, cfg.EnvVarPrefix, "TkshService", "GetReport"); err != nil {
					return err
				}
			}
			return client.RoundTrip(cmd.Context(), cfg, func(cc grpc.ClientConnInterface, in iocodec.Decoder, out iocodec.Encoder) error {
				cli := NewTkshServiceClient(cc)
				v := &ReportRequest{}

				if err := in(v); err != nil {
					return err
				}
				proto.Merge(v, req)

				res, err := cli.GetReport(cmd.Context(), v)

				if err != nil {
					return err
				}

				return out(res)

			})
		},
	}

	cmd.PersistentFlags().StringVar(&req.SortBy, cfg.FlagNamer("SortBy"), "", "")

	return cmd
}