import 'package:do_an_cuoi_ki/Core/Colors/Custom_colors.dart';
import 'package:do_an_cuoi_ki/utils/authentication.dart';
import 'package:do_an_cuoi_ki/views/Authentication/Component/FacebookSignInButton.dart';
import 'package:do_an_cuoi_ki/views/Authentication/Component/GoogleSignInButton.dart';
import 'package:do_an_cuoi_ki/views/Authentication/Login_Screen.dart';
import 'package:flutter/material.dart';

class LoginWithGoogle extends StatelessWidget {
  const LoginWithGoogle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset('assets/images/logo-no-background.png'),
          const Spacer(),
          FutureBuilder(
            future: Authentication.initializeFirebase(context: context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error initializing Firebase');
              } else if (snapshot.connectionState == ConnectionState.done) {
                return FacebookSignInButton();
              }
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  CustomColors.firebaseOrange,
                ),
              );
            },
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: Authentication.initializeFirebase(context: context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error initializing Firebase');
              } else if (snapshot.connectionState == ConnectionState.done) {
                return GoogleSignInButton();
              }
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  CustomColors.firebaseOrange,
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account?', style: TextStyle(fontSize: 16)),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text('Login', style: TextStyle(fontSize: 16))),
            ],
          )
        ],
      ),
    ));
  }
}
