package main

import (
	"fmt"
	"github.com/NYTimes/gziphandler"
	"github.com/improbable-eng/grpc-web/go/grpcweb"
	log "github.com/sirupsen/logrus"
	"github.com/winwisely268/tksh/db"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
	"google.golang.org/grpc/reflection"
	"net"
	"net/http"
	"os"
	"strings"

	"github.com/winwisely268/tksh/rpc"
	"google.golang.org/grpc"
)

const (
	defaultCorsHeaders = "Accept, Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization, X-User-Agent, X-Grpc-Web"
	flyHeaders         = "Fly-Client-IP, Fly-Forwarded-Port, Fly-Region, Via, X-Forwarded-For, X-Forwarded-Proto, X-Forwarded-SSL, X-Forwarded-Port"
)

// create a handler struct
type HttpHandler struct{} // implement `ServeHTTP` method on `HttpHandler` struct
func (h HttpHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) { // create response binary data
	data := []byte("Hello World!") // slice of bytes    // write `data` to response
	_, _ = w.Write(data)
}

func main() {
	listener, err := net.Listen("tcp", ":8080")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	l := log.New()
	l.WithField("app", "tksh")
	logger := log.NewEntry(l)
	store, err := db.InitStorage("./data", os.Getenv("DB_PASSWORD"), logger)
	if err != nil {
		logger.Fatalf("unable to create data store: %v", err)
	}
	server := grpc.NewServer()
	service := tkshService{
		logger: logger,
		store:  store,
	}
	rpc.RegisterTkshServiceService(server, &rpc.TkshServiceService{
		NewTransfer:    service.NewTransfer,
		UpdateTransfer: service.UpdateTransfer,
		GetReport:      service.GetReport,
	})
	reflection.Register(server)
	grpcWebServer := registerGrpcWebServer(server)
	handler := HttpHandler{}
	httpServer := createHttpHandler(logger, true, handler, grpcWebServer)

	log.Fatal(httpServer.Serve(listener))
}

func createHttpHandler(logger *log.Entry, isGzipped bool, fileServer http.Handler, grpcWebServer *grpcweb.WrappedGrpcServer) *http.Server {
	return &http.Server{
		Handler: h2c.NewHandler(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			w.Header().Set("Access-Control-Allow-Origin", "*")
			w.Header().Set("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
			w.Header().Set("Access-Control-Allow-Headers", fmt.Sprintf("%s,%s", defaultCorsHeaders, flyHeaders))
			logger.Printf("Serving Endpoint: %s", r.URL.Path)
			ct := r.Header.Get("content-type")
			if r.ProtoMajor == 2 && (strings.Contains(ct, "application/grpc") || strings.Contains(ct, "application/grpc-web")) {
				grpcWebServer.ServeHTTP(w, r)
			} else {
				if isGzipped {
					fileServer = gziphandler.GzipHandler(fileServer)
					fileServer.ServeHTTP(w, r)
				} else {
					fileServer.ServeHTTP(w, r)
				}
			}
		}), &http2.Server{}),
	}
}

func registerGrpcWebServer(srv *grpc.Server) *grpcweb.WrappedGrpcServer {
	return grpcweb.WrapServer(
		srv,
		grpcweb.WithCorsForRegisteredEndpointsOnly(false),
		grpcweb.WithAllowedRequestHeaders([]string{"Accept", "Cache-Control", "Keep-Alive", "Content-Type", "Content-Length", "Accept-Encoding", "X-CSRF-Token", "Authorization", "X-User-Agent", "X-Grpc-Web"}),
		grpcweb.WithOriginFunc(func(origin string) bool {
			return true
		}),
		grpcweb.WithWebsocketOriginFunc(func(req *http.Request) bool {
			return true
		}),
		grpcweb.WithWebsockets(true),
	)
}
