/**
 * @fileoverview gRPC-Web generated client stub for 
 * @enhanceable
 * @public
 */

// GENERATED CODE -- DO NOT EDIT!


/* eslint-disable */
// @ts-nocheck


import * as grpcWeb from 'grpc-web';

import * as tksh_pb from './tksh_pb';


export class TkshServiceClient {
  client_: grpcWeb.AbstractClientBase;
  hostname_: string;
  credentials_: null | { [index: string]: string; };
  options_: null | { [index: string]: any; };

  constructor (hostname: string,
               credentials?: null | { [index: string]: string; },
               options?: null | { [index: string]: any; }) {
    if (!options) options = {};
    if (!credentials) credentials = {};
    options['format'] = 'text';

    this.client_ = new grpcWeb.GrpcWebClientBase(options);
    this.hostname_ = hostname;
    this.credentials_ = credentials;
    this.options_ = options;
  }

  methodInfoGetReport = new grpcWeb.AbstractClientBase.MethodInfo(
    tksh_pb.ReportAll,
    (request: tksh_pb.ReportRequest) => {
      return request.serializeBinary();
    },
    tksh_pb.ReportAll.deserializeBinary
  );

  getReport(
    request: tksh_pb.ReportRequest,
    metadata: grpcWeb.Metadata | null): Promise<tksh_pb.ReportAll>;

  getReport(
    request: tksh_pb.ReportRequest,
    metadata: grpcWeb.Metadata | null,
    callback: (err: grpcWeb.Error,
               response: tksh_pb.ReportAll) => void): grpcWeb.ClientReadableStream<tksh_pb.ReportAll>;

  getReport(
    request: tksh_pb.ReportRequest,
    metadata: grpcWeb.Metadata | null,
    callback?: (err: grpcWeb.Error,
               response: tksh_pb.ReportAll) => void) {
    if (callback !== undefined) {
      return this.client_.rpcCall(
        this.hostname_ +
          '/TkshService/GetReport',
        request,
        metadata || {},
        this.methodInfoGetReport,
        callback);
    }
    return this.client_.unaryCall(
    this.hostname_ +
      '/TkshService/GetReport',
    request,
    metadata || {},
    this.methodInfoGetReport);
  }

}

