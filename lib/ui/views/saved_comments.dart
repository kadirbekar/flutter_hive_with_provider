import 'package:flutter/material.dart';
import 'package:hive_local_storage/core/consts/consts.dart' as cons;

class SavedComments extends StatefulWidget {
  SavedComments({Key key}) : super(key: key);

  @override
  _SavedCommentsState createState() => _SavedCommentsState();
}

class _SavedCommentsState extends State<SavedComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: cons.APPBAR_COLOR,
        title: Text(cons.SAVED_COMMENTS),
      ),
      body: Center(
        child: Text("Hive records will be shown as soon as"),
      ),
    );
  }
}
