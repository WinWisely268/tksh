import 'package:file_picker/file_picker.dart';
import 'package:perbaikankaca/rpc/google/protobuf/timestamp.pb.dart';
import 'package:perbaikankaca/shared/repo/repo.dart';
import 'package:perbaikankaca/rpc/tksh.pbgrpc.dart' as rpc;
import 'package:meta/meta.dart';

class TkshRepo {
  Stream<rpc.NewTransferRecord> createNewTransferStream(
      {@required PlatformFile file,
      @required double jumlah,
      @required DateTime tanggal}) async* {
    final ts = Timestamp.fromDateTime(tanggal);
    final extension = file.extension;
    final fileBytes = file.bytes;
    final fileInfo = rpc.FileInfo()..mimeType = "." + extension;
    final uploadRequest = rpc.FileUploadRequest()..fileInfo = fileInfo;
    final req = rpc.NewTransferRecord()
      ..tanggal = ts
      ..transfer = jumlah
      ..uploadRequest = uploadRequest;
    yield req;
    int size = 1024;
    for (var i = 0; i < fileBytes.length; i += size) {
      uploadRequest
        ..chunk = fileBytes.sublist(
            i, i + size > fileBytes.length ? fileBytes.length : i + size);
      final dataRequest = rpc.NewTransferRecord()
        ..tanggal = ts
        ..transfer = jumlah
        ..uploadRequest = uploadRequest;
      yield dataRequest;
    }
  }

  static Future<rpc.TransferRecord> newTransfer(
      {@required Stream<rpc.NewTransferRecord> trStream}) async {
    try {
      final client = await rpcClient();
      final resp = client.newTransfer(trStream);
      return resp;
    } catch (e) {
      throw e;
    }
  }

  Stream<rpc.UpdateTransferRecord> createUpdateTransferStream(
      {@required PlatformFile file,
      @required String id,
      @required double jumlah}) async* {
    final extension = file.extension;
    final fileBytes = file.bytes;
    final fileInfo = rpc.FileInfo()..mimeType = "." + extension;
    final uploadRequest = rpc.FileUploadRequest()..fileInfo = fileInfo;
    final req = rpc.UpdateTransferRecord()
      ..transfer = jumlah
      ..uploadRequest = uploadRequest;
    yield req;
    int size = 1024;
    for (var i = 0; i < fileBytes.length; i += size) {
      uploadRequest
        ..chunk = fileBytes.sublist(
            i, i + size > fileBytes.length ? fileBytes.length : i + size);
      final dataRequest = rpc.UpdateTransferRecord()
        ..id = id
        ..transfer = jumlah
        ..uploadRequest = uploadRequest;
      yield dataRequest;
    }
  }

  static Future<rpc.TransferRecord> update(
      {@required Stream<rpc.UpdateTransferRecord> trStream}) async {
    try {
      final client = await rpcClient();
      final resp = client.updateTransfer(trStream);
      return resp;
    } catch (e) {
      throw e;
    }
  }

  static Future<rpc.ReportAll> getReport({@required String sortBy}) async {
    try {
      final client = await rpcClient();
      final req = rpc.ReportRequest()..sortBy = sortBy;
      final resp = client.getReport(req);
      return resp;
    } catch (e) {
      throw e;
    }
  }

  static Future<rpc.TkshServiceClient> rpcClient() async {
    return rpc.TkshServiceClient(await BaseRepo.grpcWebClientChannel());
  }
}
