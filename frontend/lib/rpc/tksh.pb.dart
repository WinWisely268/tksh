///
//  Generated code. Do not modify.
//  source: tksh.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

class FileUploadRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FileUploadRequest', createEmptyInstance: create)
    ..aOM<FileInfo>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileInfo', subBuilder: FileInfo.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chunk', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  FileUploadRequest._() : super();
  factory FileUploadRequest() => create();
  factory FileUploadRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileUploadRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileUploadRequest clone() => FileUploadRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileUploadRequest copyWith(void Function(FileUploadRequest) updates) => super.copyWith((message) => updates(message as FileUploadRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FileUploadRequest create() => FileUploadRequest._();
  FileUploadRequest createEmptyInstance() => create();
  static $pb.PbList<FileUploadRequest> createRepeated() => $pb.PbList<FileUploadRequest>();
  @$core.pragma('dart2js:noInline')
  static FileUploadRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileUploadRequest>(create);
  static FileUploadRequest _defaultInstance;

  @$pb.TagNumber(1)
  FileInfo get fileInfo => $_getN(0);
  @$pb.TagNumber(1)
  set fileInfo(FileInfo v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFileInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileInfo() => clearField(1);
  @$pb.TagNumber(1)
  FileInfo ensureFileInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get chunk => $_getN(1);
  @$pb.TagNumber(2)
  set chunk($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChunk() => $_has(1);
  @$pb.TagNumber(2)
  void clearChunk() => clearField(2);
}

class FileInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FileInfo', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mimeType')
    ..hasRequiredFields = false
  ;

  FileInfo._() : super();
  factory FileInfo() => create();
  factory FileInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileInfo clone() => FileInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileInfo copyWith(void Function(FileInfo) updates) => super.copyWith((message) => updates(message as FileInfo)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FileInfo create() => FileInfo._();
  FileInfo createEmptyInstance() => create();
  static $pb.PbList<FileInfo> createRepeated() => $pb.PbList<FileInfo>();
  @$core.pragma('dart2js:noInline')
  static FileInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileInfo>(create);
  static FileInfo _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get mimeType => $_getSZ(0);
  @$pb.TagNumber(1)
  set mimeType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMimeType() => $_has(0);
  @$pb.TagNumber(1)
  void clearMimeType() => clearField(1);
}

class NewTransferRecord extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NewTransferRecord', createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tanggal', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transfer', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buktiFilepath')
    ..aOM<FileUploadRequest>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uploadRequest', subBuilder: FileUploadRequest.create)
    ..hasRequiredFields = false
  ;

  NewTransferRecord._() : super();
  factory NewTransferRecord() => create();
  factory NewTransferRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NewTransferRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NewTransferRecord clone() => NewTransferRecord()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NewTransferRecord copyWith(void Function(NewTransferRecord) updates) => super.copyWith((message) => updates(message as NewTransferRecord)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NewTransferRecord create() => NewTransferRecord._();
  NewTransferRecord createEmptyInstance() => create();
  static $pb.PbList<NewTransferRecord> createRepeated() => $pb.PbList<NewTransferRecord>();
  @$core.pragma('dart2js:noInline')
  static NewTransferRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NewTransferRecord>(create);
  static NewTransferRecord _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get tanggal => $_getN(0);
  @$pb.TagNumber(1)
  set tanggal($1.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTanggal() => $_has(0);
  @$pb.TagNumber(1)
  void clearTanggal() => clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureTanggal() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get transfer => $_getN(1);
  @$pb.TagNumber(2)
  set transfer($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransfer() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransfer() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get buktiFilepath => $_getSZ(2);
  @$pb.TagNumber(3)
  set buktiFilepath($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBuktiFilepath() => $_has(2);
  @$pb.TagNumber(3)
  void clearBuktiFilepath() => clearField(3);

  @$pb.TagNumber(4)
  FileUploadRequest get uploadRequest => $_getN(3);
  @$pb.TagNumber(4)
  set uploadRequest(FileUploadRequest v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUploadRequest() => $_has(3);
  @$pb.TagNumber(4)
  void clearUploadRequest() => clearField(4);
  @$pb.TagNumber(4)
  FileUploadRequest ensureUploadRequest() => $_ensure(3);
}

class UpdateTransferRecord extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateTransferRecord', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transfer', $pb.PbFieldType.OD)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'buktiFilepath')
    ..aOM<FileUploadRequest>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uploadRequest', subBuilder: FileUploadRequest.create)
    ..hasRequiredFields = false
  ;

  UpdateTransferRecord._() : super();
  factory UpdateTransferRecord() => create();
  factory UpdateTransferRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateTransferRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateTransferRecord clone() => UpdateTransferRecord()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateTransferRecord copyWith(void Function(UpdateTransferRecord) updates) => super.copyWith((message) => updates(message as UpdateTransferRecord)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateTransferRecord create() => UpdateTransferRecord._();
  UpdateTransferRecord createEmptyInstance() => create();
  static $pb.PbList<UpdateTransferRecord> createRepeated() => $pb.PbList<UpdateTransferRecord>();
  @$core.pragma('dart2js:noInline')
  static UpdateTransferRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateTransferRecord>(create);
  static UpdateTransferRecord _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.double get transfer => $_getN(1);
  @$pb.TagNumber(2)
  set transfer($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransfer() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransfer() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get buktiFilepath => $_getSZ(2);
  @$pb.TagNumber(3)
  set buktiFilepath($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBuktiFilepath() => $_has(2);
  @$pb.TagNumber(3)
  void clearBuktiFilepath() => clearField(3);

  @$pb.TagNumber(4)
  FileUploadRequest get uploadRequest => $_getN(3);
  @$pb.TagNumber(4)
  set uploadRequest(FileUploadRequest v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasUploadRequest() => $_has(3);
  @$pb.TagNumber(4)
  void clearUploadRequest() => clearField(4);
  @$pb.TagNumber(4)
  FileUploadRequest ensureUploadRequest() => $_ensure(3);
}

class TransferRecord extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TransferRecord', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<$1.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tanggal', subBuilder: $1.Timestamp.create)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transfer', $pb.PbFieldType.OD)
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bukti', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  TransferRecord._() : super();
  factory TransferRecord() => create();
  factory TransferRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransferRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransferRecord clone() => TransferRecord()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransferRecord copyWith(void Function(TransferRecord) updates) => super.copyWith((message) => updates(message as TransferRecord)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TransferRecord create() => TransferRecord._();
  TransferRecord createEmptyInstance() => create();
  static $pb.PbList<TransferRecord> createRepeated() => $pb.PbList<TransferRecord>();
  @$core.pragma('dart2js:noInline')
  static TransferRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransferRecord>(create);
  static TransferRecord _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $1.Timestamp get tanggal => $_getN(1);
  @$pb.TagNumber(2)
  set tanggal($1.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTanggal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTanggal() => clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureTanggal() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.double get transfer => $_getN(2);
  @$pb.TagNumber(3)
  set transfer($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTransfer() => $_has(2);
  @$pb.TagNumber(3)
  void clearTransfer() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get bukti => $_getN(3);
  @$pb.TagNumber(4)
  set bukti($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBukti() => $_has(3);
  @$pb.TagNumber(4)
  void clearBukti() => clearField(4);
}

class ReportAll extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReportAll', createEmptyInstance: create)
    ..pc<TransferRecord>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reportItems', $pb.PbFieldType.PM, subBuilder: TransferRecord.create)
    ..hasRequiredFields = false
  ;

  ReportAll._() : super();
  factory ReportAll() => create();
  factory ReportAll.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReportAll.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReportAll clone() => ReportAll()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReportAll copyWith(void Function(ReportAll) updates) => super.copyWith((message) => updates(message as ReportAll)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReportAll create() => ReportAll._();
  ReportAll createEmptyInstance() => create();
  static $pb.PbList<ReportAll> createRepeated() => $pb.PbList<ReportAll>();
  @$core.pragma('dart2js:noInline')
  static ReportAll getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReportAll>(create);
  static ReportAll _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<TransferRecord> get reportItems => $_getList(0);
}

class ReportRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ReportRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sortBy')
    ..hasRequiredFields = false
  ;

  ReportRequest._() : super();
  factory ReportRequest() => create();
  factory ReportRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReportRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReportRequest clone() => ReportRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReportRequest copyWith(void Function(ReportRequest) updates) => super.copyWith((message) => updates(message as ReportRequest)); // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ReportRequest create() => ReportRequest._();
  ReportRequest createEmptyInstance() => create();
  static $pb.PbList<ReportRequest> createRepeated() => $pb.PbList<ReportRequest>();
  @$core.pragma('dart2js:noInline')
  static ReportRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReportRequest>(create);
  static ReportRequest _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sortBy => $_getSZ(0);
  @$pb.TagNumber(1)
  set sortBy($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSortBy() => $_has(0);
  @$pb.TagNumber(1)
  void clearSortBy() => clearField(1);
}

