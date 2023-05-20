import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_cuoi_ki/models/save_article_model.dart';

class SaveArticleService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<SaveArticle> saves = [];
  SaveArticle? save;

  //
  Future<List<SaveArticle>> retrieveSaveArticle() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("save").get();
    return snapshot.docs
        .map((docSnapshot) => SaveArticle.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  //get article
  Future<void> getSaveArticlebyArticleId(String articleId) async {
    var retrievedSaveArticleList = await retrieveSaveArticle();
    retrievedSaveArticleList.forEach((element) {
      if(articleId==element.articleId){
        save = SaveArticle(
            saveArticleId: element.saveArticleId,
            userId: element.userId,
            articleId: element.articleId
        );
      }
    });
  }

  //get article
  Future<void> getAllSaveArticle() async {
    var retrievedSaveArticleList = await retrieveSaveArticle();
    retrievedSaveArticleList.forEach((element) async{
      SaveArticle saveArticle = SaveArticle(
          saveArticleId: element.saveArticleId,
          userId: element.userId,
          articleId: element.articleId
      );
      saves.add(saveArticle);
    });
  }

  //add article to save
  addSaveArticle(SaveArticle saveArticle) async {
    await _db.collection("save").add(saveArticle.toMap());
  }

  //update article to save
  Future<void> updateSaveArticle(String id, bool isSave) async {
    await _db.collection("save").doc(id).update({"isSave": isSave});
  }

  Future<void> deleteSaveArticle(String? saveArticleId) async {
    await _db.collection("save").doc(saveArticleId).delete();

  }
}