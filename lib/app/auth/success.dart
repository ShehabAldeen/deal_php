import 'package:dealwithphp/app/auth/login.dart';
import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  static const routeName = 'success';

  const Success({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('تم انشاء الحساب بنجاح الان يمكنك تسجيل الدخول')),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.routeName, (route) => false);
            },
            child: Text('تسجيل الدخول'),
          )
        ],
      ),
    );
  }
}
