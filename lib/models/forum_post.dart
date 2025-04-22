import 'package:cloud_firestore/cloud_firestore.dart';

class ForumPost {
  String? postId;
  String? userId;
  String? content;
  DateTime? timestamp;

  ForumPost({this.postId, this.userId, this.content, this.timestamp});

  ForumPost.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    userId = json['userId'];
    content = json['content'];
    timestamp = json['timestamp'] != null ? (json['timestamp'] as Timestamp).toDate() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['userId'] = userId;
    data['content'] = content;
    data['timestamp'] = timestamp;
    return data;
  }
}