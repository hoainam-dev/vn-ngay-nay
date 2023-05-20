import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_cuoi_ki/service/category_service.dart';
import 'package:do_an_cuoi_ki/views/Home/Home_conponent/search.dart';
import 'package:flutter/material.dart';
import '../../helper/Widgets.dart';
import '../../service/article_service.dart';
import 'Home_conponent/rightNavigationBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _loading;
  var newslist=[]; //List News
  var newsCategorielist=[]; //List Categorie News
  var categoryList=[];

  TextEditingController searchController = new TextEditingController();
  String? category;
  int activeTab = 0;


  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Get All News
  void getNews() async {
    ArticleService articleService = ArticleService();
    await articleService.getNews();
    newslist = articleService.news;
    print("news: ${newslist}");
    setState(() {
      _loading = false;
    });
    print("this is home!");
  }

  //Get Categorie News
  void getCategorieNews() async {
    ArticleService articleService = ArticleService();
    if (activeTab == 0) {
      newsCategorielist = [];
    } else {
      await articleService.getNewsForCategory(category!.toLowerCase());
      newsCategorielist = articleService.categoryNews;
      setState(() {
        _loading = false;
      });
    }
  }

   void getCategory() async{
    CategoryService categoryService = CategoryService();
    await categoryService.getCategories();
    categoryList = categoryService.categories;
    setState(() {
      _loading = false;
    });
  }

  void onTap(int index){
    setState((){
      category = categoryList[index].categorieSlug ?? "";
      activeTab = index;
    });
    getCategorieNews();
  }

  //Init
  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();
    getCategory();
    getNews();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              :
              getArticle(
                  activeTab: activeTab,
                  newslist: newslist,
                  newscategorielist: newsCategorielist),
        ));
  }

  //App bar
  PreferredSizeWidget CustomAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0), color: Colors.white),
        child: TextField(
          controller: searchController,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Search()));
          },
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xffe0e0e0),
              ),
              hintText: 'Nhập từ khóa',
              hintStyle: TextStyle(color: Color(0xffe0e0e0)),
              suffixIcon: Icon(Icons.area_chart, color: Color(0xffd43c3b))),
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(color: Colors.black87, fontSize: 16),
        ),
      ),
      bottom: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 40,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: SingleChildScrollView(
            child: Container(
                child: Row(
                    children: <Widget>[
                  /// Categories
                  Container(
                    height: 30,
                    // width: 345,
                    width: (MediaQuery
                        .of(context)
                        .size
                        .width)-70,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: (){
                                setState((){
                                  category = categoryList[index].categorieSlug ?? "";
                                  activeTab = index;
                                });
                                getCategorieNews();
                              },
                              child: Container(
                                  margin: EdgeInsets.only(top: 5, right: 14),
                                  child: Stack(children: <Widget>[
                                    Column(
                                      children: [
                                        Text(
                                          '${categoryList[index].categorieName}',
                                          style: TextStyle(fontSize: 14, color: activeTab==index?Color(0xffd43c3b):Colors.black),
                                        ),
                                        SizedBox(height: 3),
                                        activeTab==index?Container(
                                          height: 2,
                                          width: 40,
                                          color: Color(0xffd43c3b),
                                        ):Container()
                                      ],
                                    )
                                  ])));
                        }),
                  ),
                  Container(
                    width: 35,
                    child: IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RightNavigationBar(category: categoryList, activeTab: activeTab,)));
                    },
                      icon: Icon(
                        Icons.menu,
                        size: 17,
                        color: Colors.black,
                      ),),
                  ),
                ]))),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Color(0xffd43c3b),
      elevation: 0.0,
    );
  }
}
