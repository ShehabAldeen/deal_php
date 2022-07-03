import 'package:flutter/material.dart';

import '../crud/crud.dart';

class CardNotes extends StatelessWidget with Crud {
  final void Function()? onTap;
  final void Function()? onDelete;
  final String title;
  final String content;

  const CardNotes(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.content,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/images/colornote-notepad-notes-Q1Nod2.jpg',
                height: 100,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(content),
                  trailing:
                      IconButton(onPressed: onDelete, icon: Icon(Icons.delete)),
                ))
          ],
        ),
      ),
    );
  }
}
