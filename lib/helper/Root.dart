import 'package:flutter/material.dart';
import 'package:do_an_cuoi_ki/views/Profile/profile.dart';
import 'package:do_an_cuoi_ki/views/Home/homepage.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int? activeTab = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getFooter() {
    List icons1 = [Icons.home_filled, Icons.account_circle];
    List icons2 = [Icons.refresh, Icons.account_circle];
    List texts = ["Trang chủ", "Tôi"];

    return Container(
      padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
      height: 50,
      decoration: BoxDecoration(color: Color(0xfffafafa)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(2, (index) {
            return GestureDetector(
                onTap: () {
                  setState(() {
                    activeTab = index;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      activeTab==1 ? icons1[index] : icons2[index],
                      color: activeTab == index
                          ? Color(0xffd43c3b)
                          : Color(0xff7e7e7e),
                      size: 25,
                    ),
                    Text(texts[index],
                        style: TextStyle(color: Color(0xff7e7e7e), fontSize: 12))
                  ],
                ));
          } // 1 mang chua items.length phan tu icon
              ),
        ),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: [
        //index 0: return home page
        HomePage(),
        //index 1: return profile page
        ProfileWidget()
      ],
    );
  }
}
