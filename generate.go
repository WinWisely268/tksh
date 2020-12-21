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

// ============================================================================
// Typescript / JS
// ============================================================================
//go:generate /usr/bin/env bash -c "echo 'generating protobuf and grpc service for typescript'"
//go:generate protoc -I. -I./react-frontend/node_modules ./tksh.proto --js_out=import_style=commonjs,binary:./react-frontend/src/rpc --grpc-web_out=import_style=typescript,mode=grpcwebtext:./react-frontend/src/rpc