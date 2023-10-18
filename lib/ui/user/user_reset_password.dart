import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:godrive/ui/user/user_login_page.dart';

import '../../reusable_widgets/color_utils.dart';
import '../../reusable_widgets/constant_fonts.dart';
import '../../reusable_widgets/reusable_widgets.dart';


class UserResetPassword extends StatefulWidget {
  const UserResetPassword({super.key});

  @override
  State<UserResetPassword> createState() => _UserResetPasswordState();
}

class _UserResetPasswordState extends State<UserResetPassword> {
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Reset Password",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,fontFamily: Bold,color: Colors.white),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("0000FF"),
              hexStringToColor("4B0082"),
              hexStringToColor("0000FF"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                reusableTextField(
                  "Enter email",
                  Icons.email_outlined,
                  false,
                  _emailTextController,
                ),
                SizedBox(
                  height: 20,
                ),
                firebaseButton(context, "Reset Password", () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailTextController.text)
                      .then((value) {
                    Fluttertoast.showToast(msg: "Check email");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserLoginPage()));
                  }).catchError((e) {
                    Fluttertoast.showToast(msg: e!.message);
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
