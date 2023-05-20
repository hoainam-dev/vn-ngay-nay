import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_cuoi_ki/views/Article/detail_article.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String title = "";
  List<Map<String, dynamic>> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 55,
        backgroundColor: Color(0xffd43c3b),
        title: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.0), color: Colors.white),
            height: 35,
            child: TextField(
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Color(0xffe0e0e0)),
                  suffixIcon: IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(
                      Icons.cancel,
                      color: Color(0xffe0e0e0),
                    ),
                  ),
                  hintText: 'Nhập từ khóa'),
              textAlignVertical: TextAlignVertical.center,
              onChanged: ((value) {
                setState(() {
                  title = value;
                });
              }),
            )),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('article').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: ((context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (data['title']
                          .toString()
                          .toLowerCase()
                          .startsWith(title.toLowerCase())) {
                        return ListTile(
                          title: Text(
                            data['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(data['urlToImage'] ?? ""),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailArticle(
                                          articleId: data['articleId'] ?? "",
                                          newsCategory: data['newsCategory'] ?? "",
                                          author: data['author'] ?? "",
                                          imgUrl: data['urlToImage'] ?? "",
                                          desc: data['desc'] ?? "",
                                          title: data['title'] ?? "",
                                          content: data['content'] ?? "",
                                          publshedAt: DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  data['publshedAt']
                                                      .microsecondsSinceEpoch),
                                          posturl: data['articleUrl'] ?? "",
                                        )));
                          },
                        );
                      }
                      return Container();
                    }),
                  );
          }),
    );
  }
}
