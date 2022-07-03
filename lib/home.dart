import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dealwithphp/app/auth/sign_up.dart';
import 'package:dealwithphp/app/notes/add_note.dart';
import 'package:dealwithphp/app/notes/edit_note.dart';
import 'package:dealwithphp/crud/crud.dart';
import 'package:dealwithphp/cust_comp/card_notes.dart';
import 'package:dealwithphp/link_api/link_api.dart';
import 'package:dealwithphp/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Crud {
  getNotes() async {
    var response =
        await postRequest(linkViewNote, {"id": sharedPref.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${sharedPref.getString('email')}"),
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, SignUpScreen.routeName, (route) => false);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AddNote.routeName, (route) => false);
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == "fail") {
                    return const Center(
                      child: Text(
                        'لا يوجد ملاحظات',
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data['data']?.length ?? 0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CardNotes(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditNote(
                                      notes: snapshot.data['data'][index],
                                    )));
                          },
                          title:
                              "${snapshot.data['data'][index]['note_title']}",
                          content:
                              "${snapshot.data['data'][index]['note_content']}",
                          onDelete: () async {
                            var response = await postRequest(linkDeleteNote, {
                              'id': snapshot.data['data'][index]['note_id']
                                  .toString()
                            });
                            if (response['status'] == "success") {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  HomePage.routeName, (route) => false);
                            } else {
                              AwesomeDialog(
                                context: context,
                                title: 'حدث خطاء',
                              )..show();
                            }
                          },
                        );
                      });
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Center(
                  child: Text('Loading...'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
