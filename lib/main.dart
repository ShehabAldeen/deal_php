import 'package:dealwithphp/app/auth/login.dart';
import 'package:dealwithphp/app/auth/sign_up.dart';
import 'package:dealwithphp/app/auth/success.dart';
import 'package:dealwithphp/app/notes/add_note.dart';
import 'package:dealwithphp/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/notes/edit_note.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Course php Rest API',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          LoginScreen.routeName: (buildContext) => LoginScreen(),
          SignUpScreen.routeName: (buildContext) => SignUpScreen(),
          HomePage.routeName: (buildContext) => HomePage(),
          Success.routeName: (buildContext) => Success(),
          AddNote.routeName: (buildContext) => AddNote(),
          EditNote.routeName: (buildContext) => EditNote(),
        },
        initialRoute: LoginScreen.routeName);
  }
}
