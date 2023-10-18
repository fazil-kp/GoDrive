import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:godrive/ui/rental_company/rental_home_page.dart';
import 'package:godrive/ui/rental_company/rental_login_page.dart';
import 'package:godrive/ui/user/user_home_page.dart';
import 'package:godrive/ui/user/user_login_page.dart';
import 'package:godrive/ui/user/user_sign_up_page.dart';
import 'category_page.dart';
import 'database/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoDrive',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: RentalHomePage(),
    );
  }
}
