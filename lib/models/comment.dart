import 'package:tux_data_f/models/distribution.dart';

class Comment {
  final int id;
  final String text;
  final String userName;
  final int distributionId;
  final int userId;

  Comment(
      {required this.id,
      required this.text,
      required this.userName,
      required this.distributionId,
      required this.userId});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'] ?? 0,
        text: json['text'] ?? '',
        userName: json['username'] ?? '',
        distributionId: json['distributionId'] ?? 0,
        userId: json['userId'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'username': userName,
      'distributionId': distributionId,
      'userId': userId,
    };
  }
}
