import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dealwithphp/cust_comp/customs.dart';
import 'package:dealwithphp/cust_comp/valid.dart';
import 'package:dealwithphp/home.dart';
import 'package:dealwithphp/link_api/link_api.dart';
import 'package:dealwithphp/main.dart';
import 'package:flutter/material.dart';

import '../../crud/crud.dart';

class AddNote extends StatefulWidget {
  static const String routeName = 'add_note';

  AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> with Crud {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();

  bool isLoading = false;

  addNote() async {
    if (formKey.currentState!.validate() == true) {
      isLoading = true;
      setState(() {});
      var response = await postRequest(linkAddNote, {
        'title': title.text,
        'content': content.text,
        'id': sharedPref.getString('id')
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
      } else {
        AwesomeDialog(
          context: context,
          title: 'error',
        )..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    CustomTextField(
                        hintText: 'title',
                        myController: title,
                        validator: (val) {
                          return validInput(val!, 1, 60);
                        }),
                    CustomTextField(
                        hintText: 'content',
                        myController: content,
                        validator: (val) {
                          return validInput(val!, 1, 200);
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        await addNote();
                      },
                      child: const Text('Add'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
