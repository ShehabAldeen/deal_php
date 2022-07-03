import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dealwithphp/cust_comp/customs.dart';
import 'package:dealwithphp/link_api/link_api.dart';
import 'package:dealwithphp/main.dart';
import 'package:flutter/material.dart';

import '../../crud/crud.dart';
import '../../cust_comp/valid.dart';
import '../../home.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  Crud _crud = Crud();

  login() async {
    if (formKey.currentState!.validate() == true) {
      var response = await _crud.postRequest(
          linkLogin, {'email': email.text, 'password': password.text});
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
        sharedPref.setString('id', response['data']['user_id'].toString());
        sharedPref.setString('username', response['data']['user_name']);
        sharedPref.setString('email', response['data']['email']);
      } else {
        AwesomeDialog(
            context: context,
            title: 'تنبيه',
            body: Text("البريد الالكتروني او كلمة المرور خطا"))
          ..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                      "assets/images/colornote-notepad-notes-Q1Nod2.jpg"),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: 'email',
                    myController: email,
                    validator: (val) {
                      return validInput(val!, 3, 20);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: 'password',
                    myController: password,
                    validator: (val) {
                      return validInput(val!, 3, 20);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                    onPressed: () {
                      login();
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
