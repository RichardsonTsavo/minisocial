// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'file_metadata_model.dart';

class FileDataModel {
  String? fileName;
  Uint8List? bytes;
  String? url;
  FileMetadataModel? metadata;
  FileDataModel({this.fileName, this.bytes, this.url, this.metadata});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fileName': fileName,
      'bytes': bytes?.toList(),
      'url': url,
      'metadata': metadata?.toMap(),
    };
  }

  factory FileDataModel.fromMap(Map<String, dynamic> map) {
    return FileDataModel(
      fileName: map['fileName'] != null ? map['fileName'] as String : null,
      bytes: map['bytes'] != null ? Uint8List.fromList(map['bytes']) : null,
      url: map['url'] != null ? map['url'] as String : null,
      metadata: map['metadata'] != null
          ? FileMetadataModel.fromMap(map['metadata'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileDataModel.fromJson(String source) {
    return FileDataModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  FileDataModel copyWith({
    String? fileName,
    Uint8List? bytes,
    String? url,
    FileMetadataModel? metadata,
  }) {
    return FileDataModel(
      fileName: fileName ?? this.fileName,
      bytes: bytes ?? this.bytes,
      url: url ?? this.url,
      metadata: metadata ?? this.metadata,
    );
  }
}
