import 'dart:convert';

import 'package:minisocial/app/shared/models/file/file_data_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int? id;
  String? name;
  String? email;
  String? nickName;
  FileDataModel? userImage;
  List<String>? faviorites;
  String? bio;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.nickName,
    this.userImage,
    this.faviorites,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'nickName': nickName,
      'userImage': userImage?.toMap(),
      'faviorites': faviorites ?? [],
      'bio': bio ?? "",
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      nickName: map['nickName'] != null ? map['nickName'] as String : null,
      userImage: map['userImage'] != null
          ? FileDataModel.fromMap(map['userImage'])
          : null,
      faviorites: map['faviorites'] != null
          ? List<String>.from((map['faviorites']))
          : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? nickName,
    FileDataModel? userImage,
    List<String>? faviorites,
    String? bio,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      nickName: nickName ?? this.nickName,
      userImage: userImage ?? this.userImage,
      faviorites: faviorites ?? this.faviorites,
      bio: bio ?? this.bio,
    );
  }
}
