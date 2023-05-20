import 'package:flutter/material.dart';
import '../../../models/categorie_model.dart';

class RightNavigationBar extends StatefulWidget {
  final category, activeTab;
  RightNavigationBar({required this.category, this.activeTab});
  @override
  State<RightNavigationBar> createState() => _RightNavigationBarState();
}

class _RightNavigationBarState extends State<RightNavigationBar> {
  bool _isPress = false;

  //Init
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => {Navigator.pop(context)},
                icon: Icon(
                  Icons.cancel_outlined,
                  size: 25,
                  color: Colors.black,
                ),
              )
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kênh của tôi"),
                      OutlinedButton(
                        onPressed: () => {
                          setState(() {
                            _isPress = !_isPress;
                          })
                        },
                        child: Text(_isPress ? "Hoàn thành" : "Chỉnh sửa", style: TextStyle(color: Colors.black),),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                  )
                              )
                          )
                      )
                    ],
                  ),
                  Text(
                    "Nhấn và giữ để di chuyển hoặc xóa kênh",
                    style: TextStyle(color: Color(0xff7e7e7e)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 115,
                                childAspectRatio:2.6,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: widget.category.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return ElevatedButton(
                              onPressed: () {
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xfff1f1f1),
                                primary: index==0?Color(0xff7e7e7e):Colors.black,
                                elevation: 0.0,
                                shadowColor: Colors.transparent,
                              ),
                              child: Text(
                                "${widget.category[index].categorieName}",
                                style: TextStyle(fontSize: 10.5, color: widget.activeTab==index?Color(0xffd43c3b):null),
                              ));
                        }),
                  ),
                  Text("Kênh đề xuất"),
                  Text(
                    "Nhấn để thêm vào Kênh của tôi",
                    style: TextStyle(color: Color(0xff7e7e7e)),
                  ),
                ],
              )),
        ));
  }
}
