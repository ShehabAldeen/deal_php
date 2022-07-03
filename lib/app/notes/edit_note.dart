import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dealwithphp/cust_comp/customs.dart';
import 'package:dealwithphp/cust_comp/valid.dart';
import 'package:dealwithphp/home.dart';
import 'package:dealwithphp/link_api/link_api.dart';
import 'package:flutter/material.dart';

import '../../crud/crud.dart';

class EditNote extends StatefulWidget {
  static const String routeName = 'edit_note';
  final notes;

  EditNote({Key? key, this.notes}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> with Crud {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();

  bool isLoading = false;

  editNote() async {
    if (formKey.currentState!.validate() == true) {
      isLoading = true;
      setState(() {});
      var response = await postRequest(linkEditNote, {
        'title': title.text,
        'content': content.text,
        'id': widget.notes['note_id'].toString()
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
  void initState() {
    title.text = widget.notes['note_title'];
    content.text = widget.notes['note_content'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
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
                        await editNote();
                      },
                      child: const Text('Edit'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
