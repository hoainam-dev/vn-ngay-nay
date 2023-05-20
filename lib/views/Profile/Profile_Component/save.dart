import 'package:do_an_cuoi_ki/helper/NewsTile.dart';
import 'package:do_an_cuoi_ki/models/article_model.dart';
import 'package:do_an_cuoi_ki/service/article_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Saves extends StatefulWidget {
  const Saves({Key? key}) : super(key: key);

  @override
  State<Saves> createState() => _SavesState();
}

class _SavesState extends State<Saves> {
  List<Article> articles = [];

  late bool _loading;

  final User? _user = FirebaseAuth.instance.currentUser;

  void getArticle() async{
    ArticleService articleService = ArticleService();

    await articleService.getArticleSaveById(_user!.uid);
    articles = articleService.listArticleSave;
    setState(() {
      _loading = false;
    });
  }

  //Init
  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();
    getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffff4f4f4),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey, //change your color here
          ),
          backgroundColor: Colors.white,
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Container(
            margin: EdgeInsets.fromLTRB(110, 0, 0, 0),
            child:Text("Lưu", style: TextStyle(color: Colors.black),),
          ),
        ),
        body: SingleChildScrollView(
          child: _loading?
          Column(
                children: [
                  Container()
                ],
              )
              :
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 16),
                child: articles.length==0?
                Text("Hiện chưa có bài viết nào được lưu", style: TextStyle(color: Colors.grey, fontSize: 16))
                    :
                ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NewsTile(
                        articleId: articles[index].articleId ?? "",
                        newsCategory: articles,
                        author: articles[index].author ?? "",
                        imgUrl: articles[index].urlToImage ?? "",
                        desc: articles[index].description ?? "",
                        title: articles[index].title ?? "",
                        content: articles[index].content ?? "",
                        publshedAt: DateTime.now(),
                        posturl: articles[index].articleUrl ?? "",
                        imgWidth: 125,
                      );
                    }),
              )
            ],
          ),
        )
    );
  }
}
