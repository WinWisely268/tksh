///
//  Generated code. Do not modify.
//  source: tksh.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'tksh.pb.dart' as $0;
export 'tksh.pb.dart';

class TkshServiceClient extends $grpc.Client {
  static final _$newTransfer =
      $grpc.ClientMethod<$0.NewTransferRecord, $0.TransferRecord>(
          '/TkshService/NewTransfer',
          ($0.NewTransferRecord value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.TransferRecord.fromBuffer(value));
  static final _$updateTransfer =
      $grpc.ClientMethod<$0.UpdateTransferRecord, $0.TransferRecord>(
          '/TkshService/UpdateTransfer',
          ($0.UpdateTransferRecord value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.TransferRecord.fromBuffer(value));
  static final _$getReport = $grpc.ClientMethod<$0.ReportRequest, $0.ReportAll>(
      '/TkshService/GetReport',
      ($0.ReportRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ReportAll.fromBuffer(value));

  TkshServiceClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.TransferRecord> newTransfer(
      $async.Stream<$0.NewTransferRecord> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$newTransfer, request, options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.TransferRecord> updateTransfer(
      $async.Stream<$0.UpdateTransferRecord> request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$updateTransfer, request, options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.ReportAll> getReport($0.ReportRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(_$getReport, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class TkshServiceBase extends $grpc.Service {
  $core.String get $name => 'TkshService';

  TkshServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.NewTransferRecord, $0.TransferRecord>(
        'NewTransfer',
        newTransfer,
        true,
        false,
        ($core.List<$core.int> value) => $0.NewTransferRecord.fromBuffer(value),
        ($0.TransferRecord value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateTransferRecord, $0.TransferRecord>(
        'UpdateTransfer',
        updateTransfer,
        true,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateTransferRecord.fromBuffer(value),
        ($0.TransferRecord value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ReportRequest, $0.ReportAll>(
        'GetReport',
        getReport_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ReportRequest.fromBuffer(value),
        ($0.ReportAll value) => value.writeToBuffer()));
  }

  $async.Future<$0.ReportAll> getReport_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ReportRequest> request) async {
    return getReport(call, await request);
  }

  $async.Future<$0.TransferRecord> newTransfer(
      $grpc.ServiceCall call, $async.Stream<$0.NewTransferRecord> request);
  $async.Future<$0.TransferRecord> updateTransfer(
      $grpc.ServiceCall call, $async.Stream<$0.UpdateTransferRecord> request);
  $async.Future<$0.ReportAll> getReport(
      $grpc.ServiceCall call, $0.ReportRequest request);
}
