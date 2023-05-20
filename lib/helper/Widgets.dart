import 'package:do_an_cuoi_ki/helper/NewsTile.dart';
import 'package:flutter/material.dart';

//Get Article
class getArticle extends StatefulWidget {
  const getArticle({Key? key, this.activeTab, this.newslist, this.newscategorielist}) : super(key: key);
  final activeTab, newslist, newscategorielist;

  @override
  State<getArticle> createState() => _getArticleState();
}

class _getArticleState extends State<getArticle> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
            children: <Widget>[
              /// News Article
             widget.activeTab == 0
                  ? Container(
                margin: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: widget.newslist.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NewsTile(
                        articleId: widget.newslist[index].articleId ?? "",
                        newsCategory: widget.newslist,
                        author: widget.newslist[index].author ?? "",
                        imgUrl: widget.newslist[index].urlToImage ?? "",
                        desc: widget.newslist[index].description ?? "",
                        title: widget.newslist[index].title ?? "",
                        content: widget.newslist[index].content ?? "",
                        publshedAt: widget.newslist[index].publshedAt ?? "",
                        posturl: widget.newslist[index].articleUrl ?? "",
                        imgWidth: 125,
                      );
                    }),
              )
                  : Container(
                margin: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: widget.newscategorielist.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return
                        NewsTile(
                          articleId: widget.newscategorielist[index].articleId ?? "",
                          newsCategory: widget.newscategorielist,
                          author: widget.newscategorielist[index].author ?? "",
                          imgUrl: widget.newscategorielist[index].urlToImage ?? "",
                          desc: widget.newscategorielist[index].description ?? "",
                          title: widget.newscategorielist[index].title ?? "",
                          content: widget.newscategorielist[index].content ?? "",
                          publshedAt: widget.newscategorielist[index].publshedAt ?? "",
                          posturl: widget.newscategorielist[index].articleUrl ?? "",
                          imgWidth: 125,
                        );
                    }),
              ),
            ],
          )
      ),
    );
  }
}
