import 'package:do_an_cuoi_ki/helper/Root.dart';
import 'package:do_an_cuoi_ki/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class FacebookSignInButton extends StatefulWidget {
  @override
  _FacebookSignInButtonState createState() => _FacebookSignInButtonState();
}

class _FacebookSignInButtonState extends State<FacebookSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      )
          : OutlinedButton(
          onPressed: () async {
            setState(() {
              _isSigningIn = true;
            });
            User? user =
            await Authentication.signInWithGoogle(context: context);

            setState(() {
              _isSigningIn = false;
            });

            if (user != null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Root(),
                ),
              );
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/facebook.png',
                height: 30,
                fit: BoxFit.cover,
              ),
              Text('Login with facebook')
            ],
          ),
          style: TextButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              padding: const EdgeInsets.symmetric(
                  vertical: 3.0, horizontal: 5)
          )
      ),
    );

  }
}