import 'package:do_an_cuoi_ki/models/user.dart';
import 'package:do_an_cuoi_ki/service/user_service.dart';
import 'package:do_an_cuoi_ki/views/Authentication/Login_With_Google.dart';
import 'package:do_an_cuoi_ki/views/Profile/Profile_Component/history.dart';
import 'package:do_an_cuoi_ki/views/Profile/Profile_Component/save.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Category/create_category.dart';
import 'Profile_Component/feedbacks.dart';
import 'package:do_an_cuoi_ki/views/Profile/Profile_Component/setting.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final User? user = FirebaseAuth.instance.currentUser;
  Users? _user = new Users();

  void getUser() async{
    final UserService _userService = UserService();
    await _userService.getUserByEmail(user!.email.toString());
    _user = _userService.user;
  }

  //Init
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          if(snapshot.data!.email=="admin@gmail.com"){
            return getBody(user: _user,
              inforWidget: Container(
              margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(_user!.photoURL!=null?_user!.photoURL.toString()
                            :"https://i.pinimg.com/564x/69/ed/a6/69eda630979ffd1a1259bed45c5f5df5.jpg"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Wellcome ${_user!.userName}", ),
                    Text("${_user!.email}", ),
                  ],
                )
              ]),),
              createWidget: ProfileMenuWidget(
                icon: Icons.create,
                title: 'Category',
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>
                          CreateCategories()));
                },),
              levelWidget: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () => {print("aaa")},
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Cấp 2",
                              style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                          Text("Tiến Sĩ Khoa Học >",
                              style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () => {print("aaa")},
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("0cs", style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w400)),
                          Text("Điểm tín dụng >",
                              style: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
            }else{
              return getBody(user: _user,
                inforWidget: Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child:
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(_user!.photoURL!=null?_user!.photoURL.toString()
                              :"https://i.pinimg.com/564x/69/ed/a6/69eda630979ffd1a1259bed45c5f5df5.jpg"),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Wellcome ${_user!.userName}", ),
                      Text("${_user?.email??""}", ),
                    ],
                  )
                ]),),
                createWidget: Container(),
                levelWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () => {print("aaa")},
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Cấp 2",
                                style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                            Text("Tiến Sĩ Khoa Học >",
                                style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () => {print("aaa")},
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("0cs", style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w400)),
                            Text("Điểm tín dụng >",
                                style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }else{
          return getBody(user: _user,
            inforWidget: Container(
            margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginWithGoogle()))
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  child: Column(
                    children: [
                      Text("Đăng nhập", style: TextStyle(color: Colors.black))
                    ],
                  ),
                )
              ],
            ),
          ),
              createWidget: Container(),
              levelWidget: Container(),
          );
        }
      },
    );
  }
}

class getBody extends StatefulWidget {
  const getBody({Key? key, required this.inforWidget, required this.createWidget, required this.levelWidget, required this.user}) : super(key: key);
  final Widget inforWidget,createWidget, levelWidget;
  final Users? user;

  @override
  State<getBody> createState() => _getBodyState();
}

class _getBodyState extends State<getBody> {
  @override
  Widget build(BuildContext context) {
    var titleInforText = [
      "CÔNG TY TNHH CÔNG NGHỆ MẠNG THÔNG TIN VIỆT NAM",
      "Giấy phép:",
      "Thông tin liên hệ:"];
    var inforText = ["Mã số doanh nghiệp: 0314505650",
      "Ngày cấp: 10/07/2017",
      "Nơi cấp: Sở Kế hoạch và Đầu tư Tp. Hồ Chí Minh",
      "Giấy phép thiết lập trang thông tin điện tử tổng hợp trên mạng Số 44/ GP – STTTT do Sở Thông tin và Truyền thông Thành phố Hồ Chí Minh cấp ngày 13/9/2017",
      "Chịu trách nhiệm nội dung: Lê Phạm Huyền Nhung",
      "Giấy chứng nhận đăng ký cung cấp dịch vụ trò chơi điện tử trên mạng số 175/GCNPTTH&TTĐT do Cục Phát thanh truyền hình và Thông tin điện tử cấp ngày 11 tháng 09 năm 2019",
      "Địa chỉ: Tòa nhà H2, số 196 Hoàng Diệu, Phường 08, Quận 4, TP.HCM, Việt Nam.",
      "Email: contact@vngaynay.vn",
      "Điện thoại: 02836362391",
      "Zalo: 0932728536"
    ];
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
              child: Stack(
                children: [
                  Container(
                    child: Image.asset("assets/images/background.jpg"),
                  ),
                  widget.inforWidget,

                  Container(
                    padding: EdgeInsets.only(top: 30),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(260, 30),
                          topRight: Radius.elliptical(260, 30)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.group,
                                  size: 25,
                                  color: Colors.deepOrange,
                                ),
                                Text("Theo dõi")
                              ],
                            ),
                            SizedBox(width: 40),
                            Column(
                              children: [
                                Icon(
                                  Icons.doorbell,
                                  size: 25,
                                  color: Colors.purple,
                                ),
                                Text("Thông báo")
                              ],
                            ),
                            SizedBox(width: 40),
                            Column(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 25,
                                  color: Colors.lightBlue,
                                ),
                                Text("Ban đêm")
                              ],
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey),
                        Column(
                          children: [
                            ProfileMenuWidget(
                              onPress: () => {
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                              Saves()))
                              },
                              title: "Lưu",
                              icon: Icons.save,
                              Iconcolor: Colors.red,
                            ),
                            ProfileMenuWidget(
                              onPress: () => {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                        History()))
                              },
                              title: "Lịch sử",
                              icon: Icons.query_builder_sharp,
                              Iconcolor: Colors.yellow,
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey),
                        Column(
                          children: [
                            ProfileMenuWidget(
                              onPress: () =>
                              {Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => Feedbacks()))
                              },
                              title: "Tôi muốn phản hồi",
                              icon: Icons.quiz,
                            ),
                            ProfileMenuWidget(
                              onPress: () =>
                              {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => Setting(user: widget.user)))
                              },
                              title: "Cài đặt",
                              icon: Icons.settings,
                              textColor: Colors.red,
                              endIcon: false,
                            ),
                            widget.createWidget,
                          ],
                        ),
                        const Divider(color: Colors.grey),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          // height: 340,
                          height: 365,
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleInfoText(titleInforText[0] + "     "),
                                  SizedBox(height: 5),
                                  infoText(inforText[0]),
                                  SizedBox(height: 5),
                                  infoText(inforText[1]),
                                  SizedBox(height: 5),
                                  infoText(inforText[2]),
                                ],
                              ),
                              SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleInfoText(titleInforText[1]),
                                  SizedBox(height: 5),
                                  infoText(inforText[3]),
                                  SizedBox(height: 5),
                                  infoText(inforText[4]),
                                  SizedBox(height: 5),
                                  infoText(inforText[5]),
                                ],
                              ),
                              SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleInfoText(titleInforText[2]),
                                  SizedBox(height: 5),
                                  infoText(inforText[6]),
                                  SizedBox(height: 5),
                                  infoText(inforText[7]),
                                  SizedBox(height: 5),
                                  infoText(inforText[8]),
                                  SizedBox(height: 5),
                                  infoText(inforText[9]),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 165, 0, 0),
                    child: widget.levelWidget
                  ),
                ],
              )),
        ));
  }
  Widget infoText(String text){
    return Text(text,style: TextStyle(color: Colors.grey, fontSize: 13));
  }
  Widget titleInfoText(String text){
    return Text(text);
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
    this.Iconcolor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  final Color? Iconcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPress,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            icon,
            color: Iconcolor,
            size: 25,
          ),
        ),
        title: Text(this.title,
            style: TextStyle(fontSize: 15)
        ));
  }
}

