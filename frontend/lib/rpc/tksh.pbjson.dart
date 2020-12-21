///
//  Generated code. Do not modify.
//  source: tksh.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const FileUploadRequest$json = const {
  '1': 'FileUploadRequest',
  '2': const [
    const {'1': 'file_info', '3': 1, '4': 1, '5': 11, '6': '.FileInfo', '10': 'fileInfo'},
    const {'1': 'chunk', '3': 2, '4': 1, '5': 12, '10': 'chunk'},
  ],
};

const FileInfo$json = const {
  '1': 'FileInfo',
  '2': const [
    const {'1': 'mime_type', '3': 1, '4': 1, '5': 9, '10': 'mimeType'},
  ],
};

const NewTransferRecord$json = const {
  '1': 'NewTransferRecord',
  '2': const [
    const {'1': 'tanggal', '3': 1, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'tanggal'},
    const {'1': 'transfer', '3': 2, '4': 1, '5': 1, '10': 'transfer'},
    const {'1': 'bukti_filepath', '3': 3, '4': 1, '5': 9, '10': 'buktiFilepath'},
    const {'1': 'upload_request', '3': 4, '4': 1, '5': 11, '6': '.FileUploadRequest', '10': 'uploadRequest'},
  ],
};

const UpdateTransferRecord$json = const {
  '1': 'UpdateTransferRecord',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'transfer', '3': 2, '4': 1, '5': 1, '10': 'transfer'},
    const {'1': 'bukti_filepath', '3': 3, '4': 1, '5': 9, '10': 'buktiFilepath'},
    const {'1': 'upload_request', '3': 4, '4': 1, '5': 11, '6': '.FileUploadRequest', '10': 'uploadRequest'},
  ],
};

const TransferRecord$json = const {
  '1': 'TransferRecord',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'tanggal', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'tanggal'},
    const {'1': 'transfer', '3': 3, '4': 1, '5': 1, '10': 'transfer'},
    const {'1': 'bukti', '3': 4, '4': 1, '5': 12, '10': 'bukti'},
  ],
};

const ReportAll$json = const {
  '1': 'ReportAll',
  '2': const [
    const {'1': 'report_items', '3': 1, '4': 3, '5': 11, '6': '.TransferRecord', '10': 'reportItems'},
  ],
};

const ReportRequest$json = const {
  '1': 'ReportRequest',
  '2': const [
    const {'1': 'sort_by', '3': 1, '4': 1, '5': 9, '10': 'sortBy'},
  ],
};

