import 'package:cloud_firestore/cloud_firestore.dart';

class SaveArticle{
  final String? saveArticleId;
  final String? userId;
  final String? articleId;

  SaveArticle({this.saveArticleId, this.userId, this.articleId});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'articleId': articleId,
    };
  }

  SaveArticle.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : saveArticleId = doc.id,
        userId = doc.data()!["userId"],
        articleId = doc.data()!["articleId"];
}