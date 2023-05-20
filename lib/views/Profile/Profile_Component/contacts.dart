import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

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
          margin: EdgeInsets.fromLTRB(100, 10, 0, 0),
          child:Text("Liên hệ", style: TextStyle(color: Colors.black),),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.grey,),
            SizedBox(height: 10,),
            getBody("CÔNG TY TNHH CÔNG NGHỆ MẠNG THÔNG TIN VIỆT NAM"),
            getBody("Địa chỉ: Tòa nhà H2, số 196 Hoàng Diệu, Phường 08, Quận 4, TP.HCM, Việt Nam."),
            getBody("Email: contact@vngaynay.vn"),
            getBody("Điện thoại: 02836362391"),
            getBody("Zalo: 0932728536"),
            getBody("Mã số doanh nghiệp: 0314505650"),
            getBody("Ngày cấp: 10/07/2017"),
            getBody("Nơi cấp: Sở Kế hoạch và Đầu tư Tp. Hồ Chí Minh"),
            getBody("Giấy phép thiết lập trang thông tin điện tử tổng hợp trên mạng Số 44/GP – STTTT do Sở Thông tin và Truyền thông Thành phố Hồ Chí Minh cấp ngày 13/9/2017"),
            getBody("Chịu trách nhiệm nội dung: Lê Phạm Huyền Nhung"),
            getBody("Giấy chứng nhận đăng ký cung cấp dịch vụ trò chơi điện tử trên mạng số 175/GCN-PTTH&TTĐT do Cục Phát thanh truyền hình và Thông tin điện tử cấp ngày 11 tháng 09 năm 2019"),
          ],
        ),
      )
    );
  }

  Widget getBody(String title){
    return Text(title,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 15),
    );
  }
}
