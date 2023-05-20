import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class Feedbacks extends StatelessWidget {
  const Feedbacks({Key? key}) : super(key: key);

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
            margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
            child:Text("Trợ giúp & Phản hồi", style: TextStyle(color: Colors.black),),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                      child: Text("Người dùng mới", style: TextStyle(color: Colors.red),),
                    ),
                  ],
                ),
              ),
              getBody(context, 'Ứng dụng VNNN là gì?', 'Là ứng dụng tổng hợp thông tin, đọc báo, đọc thông tin, có thể tích hợp trên tất cả các dòng điện thoại, tablet thông minh, đem đến cho bạn nhiều thông tin mới, hữu ích từ các nguồn đa dạng.'),
              Container(
                padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text("Tài khoản VN Ngày nay", style: TextStyle(color: Colors.red),),
                    ),
                  ],
                ),
              ),
              getBody(context,'Mã xác minh đăng nhập chính xác nhưng vẫn báo sai?', 'Sau khi bạn nhận mã xác minh, bạn cần phải nhập mã đó ngay, trong vòng 60 giây kể từ sau khi nhấn Gửi để nhận mã xác minh. Nếu quá thời gian thì mã xác minh sẽ không còn hiệu lực, bạn phải yêu cầu mã mới.\n'
                  +'Nếu bạn đã nhập trong thời gian yêu cầu mà vẫn không được, vui lòng thử lại sau, hoặc liên hệ với VN Ngày Nay để được trợ giúp.'),
              getBody(context,'Làm sao để liên kết/sửa số điện thoại?', 'Để liên kết tài khoản với số điện thoại của bạn, bạn có thể tìm đến Cài Đặt => Số điện thoại => Nhập số điện thoại và nhấn Gửi để lấy mã xác minh => Nhập mã xác minh => Hoàn thành. Để thay đổi số điện thoại, bạn làm theo các bước như trên = Nhập số điện thoại hiện tại và nhận mã xác minh => Chuyển tiếp nhập số điện thoại mới và mã xác minh => Hoàn thành.'),
              getBody(context,'Làm sao để thay đổi NickName và hình đại diện?', 'Để thay đổi nickname trên VN Ngày Nay, bạn có thể tìm đến Cài Đặt => chọn Sửa đổi thông tin => Nickname => Nhập nickname mới của bạn và chọn Xác nhận.\n'
                  +'Hoặc bạn có thể nhấn vào avatar cá nhân để đến trang cá nhân của bạn và chọn Chỉnh sửa để lựa chọn thay đổi nickname của bạn.\n'
                  +'Hiện VN Ngày Nay chưa hỗ trợ việc thay đổi hình đại diện vì hình đại diện của bạn chính là hình đại diện trên tài khoản Facebook của bạn. Để thay đổi hình đại diện này, bạn có thể thay đổi hình đại diện trên Facebook.'),
              getBody(context,'Làm sao để thay đổi tài khoản Facebook đã liên kết?', 'Mỗi tài khoản Facebook của bạn chỉ có thể đăng ký được một tài khoản VN Ngày Nay, vì thế bạn không thể thay đổi tài khoản Facebook đã liên kết với VN Ngày Nay.'),
              getBody(context,'Liên kết số điện thoại mà không nhận được mã xác minh?', 'Khi bạn liên kết số điện thoại với tài khoản VN Ngày Nay và không nhận được mã xác nhận, vui lòng quay lại để liên kết sau. Trong trường hợp thử nhiều lần mà vẫn không được, vui lòng liên hệ với VN Ngày Nay để được trợ giúp.'),
              getBody(context,'Làm sao để tài khoản lên cấp?', 'Khi đọc báo, chia sẻ, bình luận,... sẽ được nhận điểm kinh nghiệm, từ điểm kinh nghiệm này tích lại để lên cấp, mỗi cấp đều yêu cầu điểm kinh nghiệm không giống nhau.\n'
              +'Giới thiệu cấp bậc    (转到等级介绍)'),
            ],
          ),
        )
    );
  }

  Widget getBody(context, String title, String content){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ExpandablePanel(
        header: Container(
          padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
            child: Text(title)),
        collapsed: Text(''),
        expanded: Column(
          children: [
            Divider(),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(content, style: TextStyle(color:Color(0xff7e7e7e), height: 1.5)),
            )
          ],
        ),
      ),
    );
  }
}
