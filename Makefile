VERSION_GITHASH = $(shell git rev-parse HEAD)
GO_LDFLAGS = CGO_ENABLED=0 go build -ldflags "-X main.build=${VERSION_GITHASH}" -a -tags netgo
GO_CROSS = GOOS=linux GOARCH=amd64
OUTPUT_DIR = bin-all

DB_PASSWORD = $(shell echo "$$DB_PASSWORD" | tr -d '\n')

APP_NAME = perbaikankaca
APP_ORG = personal
APP_PORT = 8080

IMAGE_BASE := alpine:3.12
IMAGE_NAME = $(APP_NAME)
IMAGE_AUTHOR = $(shell basename $(dir $(shell git rev-parse --show-toplevel)))
IMAGE_DATE = $(shell date -u +%Y%m%d%H%M%S)
IMAGE_PORT = $(APP_PORT)
IMAGE_ORG = $(APP_ORG)
IMAGE_EXECUTABLE = server
IMAGE_REF = $(shell git rev-parse HEAD)
IMAGE_FLAGS = ""

EMBED_OUTPUT_DIR = embed
FRONTEND_PREFIX = pwa-frontend/build/
FRONTEND_WEB_PREFIX = $(FRONTEND_PREFIX)
FRONTEND_ABS_PREFIX = $(PWD)/$(FRONTEND_WEB_PREFIX)

.PHONY: all

all: gen build-clean build

gen:
	@go generate
# 	cd frontend && flutter build web
	cd pwa-frontend && yarn run build

embed-frontend:
	go-bindata -fs -nomemcopy -o assets.go -prefix "$(FRONTEND_WEB_PREFIX)" $(FRONTEND_ABS_PREFIX)...

build: embed-frontend
	$(GO_CROSS) $(GO_LDFLAGS) -o $(OUTPUT_DIR)/server .
	$(GO_LDFLAGS) -o $(OUTPUT_DIR)/client client/main.go

build-clean:
	@rm -rf bin-all

# docker recipe for local testing
docker:
	$(MAKE) all
	docker build . -t "${APP_NAME}:${IMAGE_REF}" \
		--build-arg IMAGE_REF=$(IMAGE_REF) \
		--build-arg IMAGE_BASE=$(IMAGE_BASE) \
		--build-arg IMAGE_DATE=$(IMAGE_DATE) \
		--build-arg IMAGE_EXECUTABLE=$(IMAGE_EXECUTABLE) \
		--build-arg IMAGE_PORT=$(IMAGE_PORT) \
		--build-arg IMAGE_AUTHOR=$(IMAGE_AUTHOR) \
		--build-arg IMAGE_ORG=$(IMAGE_ORG) \
		--build-arg IMAGE_FLAGS=$(IMAGE_FLAGS) \
		--build-arg IMAGE_NAME=$(IMAGE_NAME) \
		--build-arg DB_PASSWORD=$(DB_PASSWORD)
	docker system prune --volumes -f

fly:
	$(MAKE) all
	flyctl deploy \
			--build-arg IMAGE_REF=$(IMAGE_REF) \
        	--build-arg IMAGE_BASE=$(IMAGE_BASE) \
        	--build-arg IMAGE_DATE=$(IMAGE_DATE) \
        	--build-arg IMAGE_EXECUTABLE=$(IMAGE_EXECUTABLE) \
        	--build-arg IMAGE_PORT=$(IMAGE_PORT) \
        	--build-arg IMAGE_AUTHOR=$(IMAGE_AUTHOR) \
        	--build-arg IMAGE_ORG=$(IMAGE_ORG) \
        	--build-arg IMAGE_FLAGS=$(IMAGE_FLAGS) \
			--build-arg DB_PASSWORD=$(DB_PASSWORD) \
        	--build-arg IMAGE_NAME=$(IMAGE_NAME)

fly-create:
	flyctl init --dockerfile --name $(APP_NAME) --org $(APP_ORG) --port $(APP_PORT) --overwrite
	flyctl scale vm shared-cpu-1x --memory=1024 # 1GB
	flyctl volumes create tkshdata --region sin --app $(APP_NAME)
	flyctl secrets --app $(APP_NAME) set DB_PASSWORD=$(DB_PASSWORD)
	cp fly.template.toml fly.toml

fly-nuke:
	flyctl apps destroy -y $(APP_NAME)
