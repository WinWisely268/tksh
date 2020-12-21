import * as jspb from 'google-protobuf'

import * as google_protobuf_timestamp_pb from 'google-protobuf/google/protobuf/timestamp_pb';


export class FileUploadRequest extends jspb.Message {
  getFileInfo(): FileInfo | undefined;
  setFileInfo(value?: FileInfo): FileUploadRequest;
  hasFileInfo(): boolean;
  clearFileInfo(): FileUploadRequest;

  getChunk(): Uint8Array | string;
  getChunk_asU8(): Uint8Array;
  getChunk_asB64(): string;
  setChunk(value: Uint8Array | string): FileUploadRequest;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): FileUploadRequest.AsObject;
  static toObject(includeInstance: boolean, msg: FileUploadRequest): FileUploadRequest.AsObject;
  static serializeBinaryToWriter(message: FileUploadRequest, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): FileUploadRequest;
  static deserializeBinaryFromReader(message: FileUploadRequest, reader: jspb.BinaryReader): FileUploadRequest;
}

export namespace FileUploadRequest {
  export type AsObject = {
    fileInfo?: FileInfo.AsObject,
    chunk: Uint8Array | string,
  }
}

export class FileInfo extends jspb.Message {
  getMimeType(): string;
  setMimeType(value: string): FileInfo;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): FileInfo.AsObject;
  static toObject(includeInstance: boolean, msg: FileInfo): FileInfo.AsObject;
  static serializeBinaryToWriter(message: FileInfo, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): FileInfo;
  static deserializeBinaryFromReader(message: FileInfo, reader: jspb.BinaryReader): FileInfo;
}

export namespace FileInfo {
  export type AsObject = {
    mimeType: string,
  }
}

export class NewTransferRecord extends jspb.Message {
  getTanggal(): google_protobuf_timestamp_pb.Timestamp | undefined;
  setTanggal(value?: google_protobuf_timestamp_pb.Timestamp): NewTransferRecord;
  hasTanggal(): boolean;
  clearTanggal(): NewTransferRecord;

  getTransfer(): number;
  setTransfer(value: number): NewTransferRecord;

  getBuktiFilepath(): string;
  setBuktiFilepath(value: string): NewTransferRecord;

  getUploadRequest(): FileUploadRequest | undefined;
  setUploadRequest(value?: FileUploadRequest): NewTransferRecord;
  hasUploadRequest(): boolean;
  clearUploadRequest(): NewTransferRecord;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): NewTransferRecord.AsObject;
  static toObject(includeInstance: boolean, msg: NewTransferRecord): NewTransferRecord.AsObject;
  static serializeBinaryToWriter(message: NewTransferRecord, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): NewTransferRecord;
  static deserializeBinaryFromReader(message: NewTransferRecord, reader: jspb.BinaryReader): NewTransferRecord;
}

export namespace NewTransferRecord {
  export type AsObject = {
    tanggal?: google_protobuf_timestamp_pb.Timestamp.AsObject,
    transfer: number,
    buktiFilepath: string,
    uploadRequest?: FileUploadRequest.AsObject,
  }
}

export class UpdateTransferRecord extends jspb.Message {
  getId(): string;
  setId(value: string): UpdateTransferRecord;

  getTransfer(): number;
  setTransfer(value: number): UpdateTransferRecord;

  getBuktiFilepath(): string;
  setBuktiFilepath(value: string): UpdateTransferRecord;

  getUploadRequest(): FileUploadRequest | undefined;
  setUploadRequest(value?: FileUploadRequest): UpdateTransferRecord;
  hasUploadRequest(): boolean;
  clearUploadRequest(): UpdateTransferRecord;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): UpdateTransferRecord.AsObject;
  static toObject(includeInstance: boolean, msg: UpdateTransferRecord): UpdateTransferRecord.AsObject;
  static serializeBinaryToWriter(message: UpdateTransferRecord, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): UpdateTransferRecord;
  static deserializeBinaryFromReader(message: UpdateTransferRecord, reader: jspb.BinaryReader): UpdateTransferRecord;
}

export namespace UpdateTransferRecord {
  export type AsObject = {
    id: string,
    transfer: number,
    buktiFilepath: string,
    uploadRequest?: FileUploadRequest.AsObject,
  }
}

export class TransferRecord extends jspb.Message {
  getId(): string;
  setId(value: string): TransferRecord;

  getTanggal(): google_protobuf_timestamp_pb.Timestamp | undefined;
  setTanggal(value?: google_protobuf_timestamp_pb.Timestamp): TransferRecord;
  hasTanggal(): boolean;
  clearTanggal(): TransferRecord;

  getTransfer(): number;
  setTransfer(value: number): TransferRecord;

  getBukti(): Uint8Array | string;
  getBukti_asU8(): Uint8Array;
  getBukti_asB64(): string;
  setBukti(value: Uint8Array | string): TransferRecord;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): TransferRecord.AsObject;
  static toObject(includeInstance: boolean, msg: TransferRecord): TransferRecord.AsObject;
  static serializeBinaryToWriter(message: TransferRecord, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): TransferRecord;
  static deserializeBinaryFromReader(message: TransferRecord, reader: jspb.BinaryReader): TransferRecord;
}

export namespace TransferRecord {
  export type AsObject = {
    id: string,
    tanggal?: google_protobuf_timestamp_pb.Timestamp.AsObject,
    transfer: number,
    bukti: Uint8Array | string,
  }
}

export class ReportAll extends jspb.Message {
  getReportItemsList(): Array<TransferRecord>;
  setReportItemsList(value: Array<TransferRecord>): ReportAll;
  clearReportItemsList(): ReportAll;
  addReportItems(value?: TransferRecord, index?: number): TransferRecord;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): ReportAll.AsObject;
  static toObject(includeInstance: boolean, msg: ReportAll): ReportAll.AsObject;
  static serializeBinaryToWriter(message: ReportAll, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): ReportAll;
  static deserializeBinaryFromReader(message: ReportAll, reader: jspb.BinaryReader): ReportAll;
}

export namespace ReportAll {
  export type AsObject = {
    reportItemsList: Array<TransferRecord.AsObject>,
  }
}

export class ReportRequest extends jspb.Message {
  getSortBy(): string;
  setSortBy(value: string): ReportRequest;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): ReportRequest.AsObject;
  static toObject(includeInstance: boolean, msg: ReportRequest): ReportRequest.AsObject;
  static serializeBinaryToWriter(message: ReportRequest, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): ReportRequest;
  static deserializeBinaryFromReader(message: ReportRequest, reader: jspb.BinaryReader): ReportRequest;
}

export namespace ReportRequest {
  export type AsObject = {
    sortBy: string,
  }
}

