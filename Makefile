VERSION_GITHASH = $(shell git rev-parse HEAD)
GO_LDFLAGS = CGO_ENABLED=0 go build -ldflags "-X main.build=${VERSION_GITHASH}" -a -tags netgo
OUTPUT_DIR = bin-all

.PHONY: all

all: gen build-clean build

gen:
	@go generate

build:
	$(GO_LDFLAGS) -o $(OUTPUT_DIR)/server .
	$(GO_LDFLAGS) -o $(OUTPUT_DIR)/client client/main.go

build-clean:
	@rm -rf bin-all