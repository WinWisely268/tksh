package db

import (
	"fmt"
	"github.com/dgraph-io/badger/v2"
	"github.com/segmentio/ksuid"
	log "github.com/sirupsen/logrus"
	"github.com/timshannon/badgerhold"
	"github.com/winwisely268/tksh/helper"
	"github.com/winwisely268/tksh/rpc"
)

type Storage struct {
	logger *log.Entry
	store  *badgerhold.Store
}

func createBadgerOpts(path, encKey string) badger.Options {
	return badger.DefaultOptions(path).
		WithEncryptionKey(helper.MD5(encKey))
}

func InitStorage(dirpath string, logger *log.Entry) (*Storage, error) {
	options := badgerhold.DefaultOptions
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

func (s *Storage) InsertRecord(in *rpc.NewTransferRecord, bukti []byte) (*rpc.TransferRecord, error) {
	key := ksuid.New().String()
	err := s.store.Insert(key, &rpc.TransferRecord{
		Id:       key,
		Tanggal:  in.GetTanggal(),
		Transfer: in.GetTransfer(),
		Bukti:    bukti,
	})
	if err != nil {
		return nil, err
	}
	res := &rpc.TransferRecord{}
	if err = s.store.Find(res, badgerhold.Where("Id").Eq(key)); err != nil {
		return nil, err
	}
	return res, nil
}

func (s *Storage) UpdateRecord(in *rpc.UpdateTransferRecord, bukti []byte) (*rpc.TransferRecord, error) {
	if in.GetId() == "" {
		return nil, fmt.Errorf("key cannot be empty")
	}
	res := &rpc.TransferRecord{}
	if err := s.store.Find(res, badgerhold.Where("Id").Eq(in.GetId())); err != nil {
		return nil, err
	}
	if bukti != nil && len(bukti) > 0 {
		res.Bukti = bukti
	}
	if in.GetTransfer() > 0 {
		res.Transfer = in.GetTransfer()
	}
	if err := s.store.Update(res.GetId(), res); err != nil {
		return nil, err
	}
	if err := s.store.Find(res, badgerhold.Where("Id").Eq(res.Id)); err != nil {
		return nil, err
	}
	return res, nil
}

func (s *Storage) ListRecords(sortBy string) (*rpc.ReportAll, error) {
	if sortBy == "" {
		sortBy = "Tanggal"
	}
	reports := []*rpc.TransferRecord{}
	err := s.store.Find(&reports, badgerhold.Where("1").Eq(1).SortBy(sortBy))
	if err != nil {
		return nil, err
	}
	return &rpc.ReportAll{ReportItems: reports}, nil
}
