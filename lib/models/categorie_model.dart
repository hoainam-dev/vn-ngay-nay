import 'package:cloud_firestore/cloud_firestore.dart';

class Category{
  String? categoryId;
  String? categorieSlug;
  String? categorieName;

  Category({this.categoryId, this.categorieName, this.categorieSlug});

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categorieName': categorieName,
      'categorieSlug': categorieSlug,
    };
  }

  Category.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : categoryId = doc.id,
        categorieName = doc.data()!["categorieName"],
        categorieSlug = doc.data()!["categorieSlug"];
}
