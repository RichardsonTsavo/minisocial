// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../enums/post_type.dart';

class FileMetadataModel {
  double? lat;
  double? lng;
  String? contentType;
  PostType? type;
  DateTime? createdAt;
  FileMetadataModel({this.lat, this.lng, this.contentType, this.type, this.createdAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
      'contentType': contentType,
      'type': type?.name,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory FileMetadataModel.fromMap(Map<String, dynamic> map) {
    return FileMetadataModel(
      lat: map['lat'] != null ? double.parse(map['lat'].toString()) : null,
      lng: map['lng'] != null ? double.parse(map['lng'].toString()) : null,
      contentType: map['contentType'] != null ? map['contentType'] as String : null,
      type: map['type'] != null ? PostType.values.byName(map['type']) : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FileMetadataModel.fromJson(String source) =>
      FileMetadataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FileMetadataModel copyWith({
    double? lat,
    double? lng,
    String? contentType,
    PostType? type,
    DateTime? createdAt,
  }) {
    return FileMetadataModel(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      contentType: contentType ?? this.contentType,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
