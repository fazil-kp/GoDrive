import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:godrive/ui/rental_company/rental_home_page.dart';
import 'package:godrive/ui/rental_company/rental_sign_up_page.dart';
import 'package:godrive/ui/user/user_reset_password.dart';
import 'package:godrive/ui/user/user_sign_up_page.dart';

import '../../reusable_widgets/color_utils.dart';
import '../../reusable_widgets/reusable_widgets.dart';
import '../user/demo_page.dart';



class RentalLoginPage extends StatefulWidget {
  const RentalLoginPage({super.key});

  @override
  State<RentalLoginPage> createState() => _RentalLoginPageState();
}

class _RentalLoginPageState extends State<RentalLoginPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Image(image: AssetImage("assets/images/vehicle.png")),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Enter email",
                    Icons.email_outlined,
                    false,
                    _emailTextController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  reusableTextField(
                    "Enter Password",
                    Icons.lock_outline,
                    true,
                    _passwordTextController,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  forgetPassword(context),
                  firebaseButton(context, "LOG IN", () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                        .then((value) {
                      Fluttertoast.showToast(msg: "Login Successful ");
                      print("Log In successfully");
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RentalHomePage()));
                    }).catchError((e) {
                      Fluttertoast.showToast(msg: e!.message);
                    });
                  }),
                  signUpOption(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RentalSignUpPage()),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserResetPassword()));
        },
        child: Text(
          "Forget Password ?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
