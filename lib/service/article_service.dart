import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_cuoi_ki/service/save_article_service.dart';

import '../models/article_model.dart';

class ArticleService{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Article> news = [];
  List<Article> categoryNews = [];
  Article? article;
  List<Article> listArticleSave = [];

  //
  Future<List<Article>> retrieveArticle() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("article").get();
    return snapshot.docs
        .map((docSnapshot) => Article.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  //get article
  Future<void> getNews() async {
    var retrievedArticleList = await retrieveArticle();
    retrievedArticleList.forEach((element) {
      if(element.newsCategory==""){
        Article article = Article(
          articleId: element.articleId,
          title: element.title,
          author: element.author,
          description: element.description,
          urlToImage: element.urlToImage,
          publshedAt: element.publshedAt,
          content: element.content,
          articleUrl: element.articleUrl,
        );
        news.add(article);
      }
    });
    print("get News oke!");
  }

  //get article from category
  Future<void> getNewsForCategory(String category) async {
    var retrievedArticleList = await retrieveArticle();
    retrievedArticleList.forEach((element) {
      if(element.newsCategory!=null && element.newsCategory==category){
        Article article = Article(
          articleId: element.articleId,
          title: element.title,
          author: element.author,
          description: element.description,
          urlToImage: element.urlToImage,
          publshedAt: element.publshedAt,
          content: element.content,
          articleUrl: element.articleUrl,
        );
        categoryNews.add(article);
      }
    });
    print("get categoryNews oke!");
  }

  //get article by id
  Future<void> getArticleById(String? id) async {
    var retrieveArticleList = await retrieveArticle();
    retrieveArticleList.forEach((element) {
      if(id==element.articleId){
        article = Article(
          articleId: element.articleId,
          title: element.title,
          author: element.author,
          description: element.description,
          urlToImage: element.urlToImage,
          publshedAt: element.publshedAt,
          content: element.content,
          articleUrl: element.articleUrl,
        );
      }
    });
  }

  //get article by id
  Future<void> getArticleSaveById(String? userId) async {
    var retrieveArticleList = await retrieveArticle();
    SaveArticleService saveArticleService = SaveArticleService();
    await saveArticleService.getAllSaveArticle();
    retrieveArticleList.forEach((element) {
        saveArticleService.saves.forEach((save) {
          if(save.articleId==element.articleId&&userId==save.userId){
            Article article = Article(
              articleId: element.articleId,
              title: element.title,
              author: element.author,
              description: element.description,
              urlToImage: element.urlToImage,
              publshedAt: element.publshedAt,
              content: element.content,
              articleUrl: element.articleUrl,
            );
            listArticleSave.add(article);
          }
        });
      });
  }

}