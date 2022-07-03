import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dealwithphp/app/auth/success.dart';
import 'package:dealwithphp/crud/crud.dart';
import 'package:dealwithphp/cust_comp/customs.dart';
import 'package:dealwithphp/cust_comp/valid.dart';
import 'package:dealwithphp/link_api/link_api.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController userName = TextEditingController();

  Crud _crud = Crud();

  signUp() async {
    if (formKey.currentState!.validate() == true) {
      var response = await _crud.postRequest(linkSignUp, {
        "user_name": userName.text,
        "email": email.text,
        "password": password.text,
      });
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Success.routeName, (route) => false);
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
                  CustomTextField(
                      hintText: 'user name',
                      myController: userName,
                      validator: (val) {
                        return validInput(val!, 3, 20);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      hintText: 'email',
                      myController: email,
                      validator: (val) {
                        return validInput(val!, 5, 40);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    hintText: 'password',
                    myController: password,
                    validator: (val) {
                      return validInput(val!, 3, 10);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                    onPressed: () async {
                      await signUp();
                    },
                    child: Text('Sign Up'),
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
