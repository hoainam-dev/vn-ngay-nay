import 'package:do_an_cuoi_ki/views/Article/detail_article.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  final String articleId, author, title, desc, content, posturl;
  final String? imgUrl;
  final newsCategory;
  final DateTime publshedAt;
  final double imgWidth;
  NewsTile({required this.articleId,
    required this.newsCategory,
    required this.author,
    this.imgUrl,
    required this.desc,
    required this.title,
    required this.publshedAt,
    required this.content,
    required this.posturl,
    required this.imgWidth});

  @override
  Widget build(BuildContext context) {
    var urlNews = posturl.split('/')[2].split('.');
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailArticle(
                  articleId: articleId,
                  newsCategory: newsCategory,
                  author: author,
                  imgUrl: imgUrl,
                  desc: desc,
                  title: title,
                  content: content,
                  publshedAt: publshedAt,
                  posturl: posturl,
                )));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    // width: 215,
                      width: (MediaQuery
                          .of(context)
                          .size
                          .width)-165,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                title,
                                maxLines: 3,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Text(urlNews.length==2?urlNews[0]+'.'+urlNews[1]:urlNews[1]+'.'+urlNews[2],
                                style: TextStyle(fontSize: 12, color: Color(0xff7e7e7e)),),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                height: 7,
                                width: 1,
                                color: Color(0xffdedede),
                              )
                            ],
                          ),
                        ],
                      )),
                  SizedBox(
                    width: 4,
                  ),
                  imgUrl!=null?Image.network(
                    imgUrl??"",
                    height: 90,
                    // width: 110,
                    width: imgWidth,
                    fit: BoxFit.cover,
                  ):Image.asset("assets/images/errorimg.jpg")
                ],
              ),
            ),
          )),
    );
  }
}