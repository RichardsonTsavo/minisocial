import 'dart:convert';

import 'package:minisocial/app/shared/models/file/file_data_model.dart';

import '../../enums/post_type.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  int? id;
  int? userId;
  String? userName;
  FileDataModel? userAvatar;
  FileDataModel? media;
  String? caption;
  PostType? type;
  int? likesCount;
  int? commentsCount;
  DateTime? createdAt;
  bool? likedByMe;
  bool? savedByMe;
  PostModel({
    this.id,
    this.userId,
    this.userName,
    this.userAvatar,
    this.media,
    this.caption,
    this.type,
    this.likesCount,
    this.commentsCount,
    this.createdAt,
    this.likedByMe,
    this.savedByMe,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatar': userAvatar,
      'media': media,
      'caption': caption,
      'type': type?.name,
      'likesCount': likesCount ?? 0,
      'commentsCount': commentsCount ?? 0,
      'createdAt': createdAt?.toIso8601String(),
      'likedByMe': likedByMe ?? false,
      'savedByMe': savedByMe ?? false,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      userAvatar: map['userAvatar'] != null
          ? FileDataModel.fromJson(map['userAvatar'])
          : null,
      media: map['media'] != null ? FileDataModel.fromJson(map['media']) : null,
      caption: map['caption'] != null ? map['caption'] as String : null,
      type: map['type'] != null ? PostType.values.byName(map['type']) : null,
      likesCount: map['likesCount'] != null ? map['likesCount'] as int : 0,
      commentsCount: map['commentsCount'] != null ? map['commentsCount'] as int : 0,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      likedByMe: map['likedByMe'] != null ? map['likedByMe'] as bool : false,
      savedByMe: map['savedByMe'] != null ? map['savedByMe'] as bool : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PostModel copyWith({
    int? id,
    int? userId,
    String? userName,
    FileDataModel? userAvatar,
    FileDataModel? media,
    String? caption,
    PostType? type,
    int? likesCount,
    int? commentsCount,
    DateTime? createdAt,
    bool? likedByMe,
    bool? savedByMe,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      media: media ?? this.media,
      caption: caption ?? this.caption,
      type: type ?? this.type,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      createdAt: createdAt ?? this.createdAt,
      likedByMe: likedByMe ?? this.likedByMe,
      savedByMe: savedByMe ?? this.savedByMe,
    );
  }
}
