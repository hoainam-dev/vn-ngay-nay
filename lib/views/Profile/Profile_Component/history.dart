import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

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
            margin: EdgeInsets.fromLTRB(90, 0, 0, 0),
            child:Text("Lịch sử", style: TextStyle(color: Colors.black),),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        )
    );
  }
}
