import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_cuoi_ki/models/user.dart';
import 'package:do_an_cuoi_ki/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

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

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _photoURLController = TextEditingController();

  String? gender;
  String? select;
  List<String> genderList = ['male', 'female', 'other'];
  Map<int, String> mappedGender = ['male', 'female', 'other'].asMap();

  TextEditingController searchController = TextEditingController();

  bool enableList = false;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0), color: Colors.white),
            child: TextField(
              controller: searchController,
              onTap: () {},
              decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xffe0e0e0),
                    size: 25,
                  ),
                  hintText: 'Nhập từ khóa',
                  hintStyle: TextStyle(color: Color(0xffe0e0e0), fontSize: 16),
                  suffixIcon: Icon(Icons.area_chart, color: Color(0xffd43c3b))),
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          backgroundColor: const Color(0xffd43c3b),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Form(
                        key: _formKey,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("SỬA ĐỔI THÔNG TIN",
                                        style: TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold))
                                  ],
                                ),
                                const SizedBox(height: 20),
                                InputWidget(
                                    controler: _fullNameController,
                                    title: "Họ và tên",
                                    keyboarType: TextInputType.text,
                                    hintText: _user!.userName??""),
                                InputWidget(
                                    controler: _addressController,
                                    title: "Địa chỉ",
                                    keyboarType: TextInputType.text,
                                    hintText: _user!.address??""),
                                InputWidget(
                                    controler: _phoneNumberController,
                                    title: "Điện thoại",
                                    keyboarType: TextInputType.number,
                                    hintText: _user!.phone??""),
                                InputWidget(
                                    controler: _photoURLController,
                                    title: "Ảnh đại diện",
                                    keyboarType: TextInputType.text,
                                    hintText: _user!.photoURL??""),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Gender",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: StatefulBuilder(
                                      builder: (_, StateSetter setState) => Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ...mappedGender.entries.map(
                                                (MapEntry<int, String> mapEntry) => Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Radio(
                                                    activeColor: Theme.of(context).primaryColor,
                                                    groupValue: select,
                                                    value: genderList[mapEntry.key],
                                                    onChanged: (value) =>{
                                                      setState(() =>
                                                      select = value.toString()),
                                                      gender = value.toString(),
                                                    }
                                                  ),
                                                  Text(mapEntry.value)
                                                ]),
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                                SizedBox(height: 20),
                                !isLoading
                                    ? Center(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          minimumSize:MaterialStateProperty.all(const Size(200,50)),
                                          backgroundColor: MaterialStateProperty.all<
                                              Color>(const Color.fromARGB(255, 83, 80, 80))),
                                      onPressed: (() async {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext ctx) {
                                              return AlertDialog(
                                                title: const Text('Bạn chắc chắn muốn thay đổi thông tin?',
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
                                                        final String name = _fullNameController.text;
                                                        final String address = _addressController.text;
                                                        final String phone = _phoneNumberController.text;
                                                        final String photoURl = _photoURLController.text;
                                                        print(_user!.userName);
                                                        print(_user!.photoURL);
                                                        print(_user!.address);
                                                        print(_user!.phone);
                                                        print(_user!.gender);

                                                        final FirebaseFirestore _firestore = FirebaseFirestore.instance;

                                                        try{
                                                            await _firestore
                                                                .collection("users")
                                                                .doc(_user!.userId)
                                                                .update({'userName': name==""?_user!.userName:name,
                                                              'photoURL': photoURl==""?_user!.photoURL:photoURl,
                                                              'address': address==""?_user!.address:address,
                                                              'phone': phone==""?_user!.phone:phone,
                                                              'gender': gender==null?_user!.gender:gender});
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(SnackBar(
                                                              content: Text(
                                                                "Update Successfully!.",
                                                                style: TextStyle(color: Colors.green),
                                                              )));
                                                          Navigator.pop(context);
                                                            Navigator.pop(context);
                                                            Navigator.pop(context);
                                                        }catch(e){
                                                          ScaffoldMessenger.of(context)
                                                              .showSnackBar(SnackBar(
                                                              content: Text(
                                                                "Update Fail!.",
                                                                style: TextStyle(color: Colors.red),
                                                              )));
                                                        }
                                                      },
                                                      child: const Text('TIẾP TỤC', style: TextStyle(color: Colors.green),)),
                                                ],
                                              );
                                            });
                                      }),
                                      child: const
                                      Text("Sửa thông tin",style: TextStyle(fontSize: 20),)),
                                )
                                    : const Center(
                                  child: CircularProgressIndicator(),
                                ),

                              ],
                            )
                        )
                    )
                ))));
  }
}


class InputWidget extends StatefulWidget {
  final controler, title, keyboarType, hintText;
  const InputWidget(
      {Key? key, this.controler, this.title, this.keyboarType, this.hintText})
      : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        TextFormField(
          controller: widget.controler,
          keyboardType: widget.keyboarType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            labelStyle: const TextStyle(color: Colors.black),
            border: const OutlineInputBorder()
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
