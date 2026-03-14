import 'dart:convert';

import 'package:minisocial/app/shared/models/file/file_data_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int? id;
  String? name;
  String? email;
  String? username;
  FileDataModel? avatar;
  String? bio;
  int? postsCount;
  int? followersCount;
  int? followingCount;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.avatar,
    this.bio,
    this.postsCount,
    this.followersCount,
    this.followingCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'avatar': avatar?.toMap(),
      'bio': bio ?? "",
      'postsCount': postsCount,
      'followersCount': followersCount,
      'followingCount': followingCount,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      avatar: map['avatar'] != null
          ? FileDataModel.fromJson(map['avatar'].toString())
          : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      postsCount: map['postsCount'] != null ? map['postsCount'] as int : null,
      followersCount: map['followersCount'] != null ? map['followersCount'] as int : null,
      followingCount: map['followingCount'] != null ? map['followingCount'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? username,
    FileDataModel? avatar,
    String? bio,
    int? postsCount,
    int? followersCount,
    int? followingCount,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      postsCount: postsCount ?? this.postsCount,
      followingCount: followersCount ?? this.followingCount,
      followersCount: followersCount ?? this.followersCount,
    );
  }
}
