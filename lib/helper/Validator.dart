import 'package:do_an_cuoi_ki/service/user_service.dart';

class Validator{
  bool validate = true;
  String? message;
  final UserService _userService = UserService();

  void ValidateForSignUp(String name, String email, String password, String confirmPass) async{
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

    final regExp = RegExp(pattern);
    await _userService.getUserByEmail(email);
    if(_userService.user==null){
      validate = false;
      message = "Email address exist!";
    }

    if (name.isEmpty&&email.isEmpty&&password.isEmpty&&confirmPass.isEmpty) {
      validate = false;
      message = "Please enter your information!";
    }else if (name.isEmpty) {
      validate = false;
      message = "You have to enter your name!";
    }else if(email.isEmpty){
      validate = false;
      message = "You have to enter your email!";
    }else if(password.isEmpty || confirmPass.isEmpty){
      validate = false;
      message = "You have to enter your password!";
    }else if(password!=confirmPass){
      validate = false;
      message = "Password not match! Please check again.";
    }else if (!(password.length > 5) && password.isNotEmpty) {
      validate = false;
      message = "Password should contain more than 5 characters";
    }
    else if (!(regExp.hasMatch(email))) {
      validate = false;
      message = "Email not valid! please enter again.";
    }
  }

}
