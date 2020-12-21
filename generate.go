package main

// ============================================================================
// GO
// ============================================================================
// GRPC & Protobuf
//go:generate /usr/bin/env bash -c "echo 'Generating protobuf and grpc services golang'"
//go:generate protoc -I. --go_out=./rpc --go_opt=paths=source_relative ./tksh.proto
//go:generate protoc -I. --go-grpc_out=./rpc --cobra_out=./rpc --go-grpc_opt=paths=source_relative --cobra_opt=paths=source_relative ./tksh.proto
//go:generate protoc-go-inject-tag -input ./rpc/tksh.pb.go

// ============================================================================
// Flutter
// ============================================================================
//go:generate /usr/bin/env bash -c "echo 'generating protobuf and grpc services for flutter/dart'"
//go:generate protoc -I. --dart_out=grpc:./frontend/lib/rpc/ ./tksh.proto
//go:generate protoc -I. --dart_out=./frontend/lib/rpc/ google/protobuf/timestamp.proto
