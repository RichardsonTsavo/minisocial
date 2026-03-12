import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentModel {
  String? id;
  String? userName;
  String? userAvatar;
  String? comment;
  DateTime? createdAt;
  CommentModel({this.id, this.userName, this.userAvatar, this.comment, this.createdAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'userAvatar': userAvatar,
      'comment': comment,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] != null ? map['id'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      userAvatar: map['userAvatar'] != null ? map['userAvatar'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CommentModel copyWith({
    String? id,
    String? userName,
    String? userAvatar,
    String? comment,
    DateTime? createdAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
