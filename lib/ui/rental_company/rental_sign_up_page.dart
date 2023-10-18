import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:godrive/database/rental_model.dart';
import 'package:godrive/ui/rental_company/rental_login_page.dart';
import 'package:godrive/ui/user/user_login_page.dart';

import '../../database/user_models.dart';
import '../../reusable_widgets/color_utils.dart';
import '../../reusable_widgets/reusable_widgets.dart';
import '../user/demo_page.dart';


class RentalSignUpPage extends StatefulWidget {
  const RentalSignUpPage({super.key});

  @override
  State<RentalSignUpPage> createState() => _RentalSignUpPageState();
}

class _RentalSignUpPageState extends State<RentalSignUpPage> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Sign Up",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
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
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 130,
                  ),
                  reusableTextField(
                    "Enter UserName",
                    Icons.person_outline,
                    false,
                    _userNameTextController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  reusableTextField("Enter email", Icons.email_outlined, false,
                      _emailTextController),
                  SizedBox(
                    height: 30,
                  ),
                  reusableTextField("Enter Password", Icons.lock_outline, true,
                      _passwordTextController),
                  SizedBox(
                    height: 20,
                  ),
                  firebaseButton(context, "SIGN IN", () {
                    signUp(_emailTextController.text,
                        _passwordTextController.text);
                    // FirebaseAuth.instance
                    //     .createUserWithEmailAndPassword(
                    //         email: _emailTextController.text,
                    //         password: _passwordTextController.text)
                    //     .then((value) {
                    //   Fluttertoast.showToast(msg: "Login Successful ");
                    //   print("Created new account");
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => UserHomepage()));
                    // })
                    //   ..catchError((e) {
                    //     Fluttertoast.showToast(msg: e!.message);
                    //   });
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

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    RentalModel rentalModel =
    RentalModel(uid: '', userName: '', email: '', password: '');

    // writing all the values
    rentalModel.email = user!.email;
    rentalModel.uid = user.uid;
    rentalModel.userName = _userNameTextController.text;
    rentalModel.password = _passwordTextController.text;

    await firebaseFirestore
        .collection("Rental")
        .doc(user.uid)
        .set(rentalModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => Demo()),
            (route) => false);
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RentalLoginPage()),
            );
          },
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
