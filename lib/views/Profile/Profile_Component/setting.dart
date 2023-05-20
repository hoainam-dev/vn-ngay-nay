import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_cuoi_ki/models/user.dart';
import 'package:do_an_cuoi_ki/service/auth_service.dart';
import 'package:do_an_cuoi_ki/views/Profile/Profile_Component/contacts.dart';
import 'package:do_an_cuoi_ki/views/Profile/Profile_Component/update_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Setting extends StatefulWidget {
  final Users? user;
  const Setting({Key? key, this.user}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final User? curentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void confirmLogout(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Xác nhận đăng xuất'),
            actions: [
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('HỦY', style: TextStyle(color: Colors.green),)),
              // The "Yes" button
              TextButton(
                  onPressed: () async{
                    await AuthService.signOut(context: context);
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('XÁC NHẬN', style: TextStyle(color: Colors.green),)),
            ],
          );
        });
  }

  void confirmDeleteUser(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Nếu xóa tài khoản, tất cả thông tin của bạn sẽ bị xóa khỏi hệ thống và không thể tìm lại, bạn chắc chắn muốn tiếp tục?',
              style: TextStyle(fontSize: 16),),
            actions: [
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('HỦY', style: TextStyle(color: Colors.green),)),
              // The "Yes" button
              TextButton(
                  onPressed: () async{
                    final GoogleSignIn googleSignIn = GoogleSignIn();
                    if (!kIsWeb) {
                      await googleSignIn.signOut();
                    }
                    await _firestore.collection("users").doc(curentUser!.uid).delete();
                    await curentUser!.delete();
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('TIẾP TỤC', style: TextStyle(color: Colors.green),)),
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey, //change your color here
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Container(
          margin: EdgeInsets.fromLTRB(85, 10, 0, 0),
          child:Text("Cài đặt", style: TextStyle(color: Colors.black),),
        ),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return getSettingBody(infor: Column(
              children: [
                SettingMenuWidget(
                  onPress: ()=>{},
                  title: "Số điện thoại",
                  des: "Nhấp vào để liên kết  >",
                ),
                SettingMenuWidget(
                  onPress: ()=>{},
                  title: "email",
                  des: "${curentUser!.email}",
                ),
                SettingMenuWidget(
                  onPress: ()=>{Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UpdateProfile()))},
                  title: "Sửa đổi thông tin",
                  des: "",
                ),
                Divider(color: Colors.grey),
              ],
            ), help: Column(
              children: [
                SettingMenuWidget(
                  onPress: ()=>{
                    confirmDeleteUser(context)
                  },
                  title: "Xóa tài khoản",
                  des: "",
                ),
                SettingMenuWidget(
                  onPress: ()=>{
                    confirmLogout(context)
                  },
                  title: "Đăng xuất",
                  des: "",
                ),
              ],
            ));
          }else{
            return getSettingBody(infor: Container(), help: Container());
          }
        },
      ),
    );
  }
}

class getSettingBody extends StatelessWidget {
  const getSettingBody({Key? key, required this.infor, required this.help}) : super(key: key);
  final Widget infor, help;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(color: Colors.grey),
          infor,
          SettingMenuWidget(
            onPress: ()=>{},
            title: "Tôi cần trợ giúp",
            des: "",
          ),
          SettingMenuWidget(
            onPress: ()=>{},
            title: "Xóa dữ liệu tạm lưu",
            des: "6,7 MB",
          ),
          SettingMenuWidget(
            onPress: ()=>{},
            title: "Dữ liệu di động",
            des: "Tiết kiệm lưu lượng",
          ),
          SettingMenuWidget(
            onPress: ()=>{},
            title: "Kích thước chữ",
            des: "Vừa",
          ),
          Divider(color: Colors.grey),
          SettingMenuWidget(
            onPress: ()=>{},
            title: "Phiên bản",
            des: "4.4.25",
          ),
          help,
          SettingMenuWidget(
            onPress: ()=>{Navigator.push(context,
                MaterialPageRoute(builder: (context) => Contact()))},
            title: "Liên hệ",
            des: "",
          ),
        ],
      ),
    );
  }
}


class SettingMenuWidget extends StatelessWidget {
  const SettingMenuWidget({Key? key,
    required this.title,
    required this.des,
    required this.onPress}) : super(key: key);

  final String title;
  final String des;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return
        Container(
          height: 40,
          child:
          ElevatedButton(
              onPressed: onPress,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyle(color: Colors.black),),
                  Text(des, style: TextStyle(color: Color(0xff7e7e7e)),),
                ],
              ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shadowColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(0.0),
            ),
          )
        );
  }
}
