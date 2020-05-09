import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_local_storage/core/consts/consts.dart' as cons;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_local_storage/core/models/commens.dart';
import 'package:hive_local_storage/core/viewmodels/comment_vm.dart';
import 'package:hive_local_storage/ui/views/edit_comment.dart';
import 'package:hive_local_storage/ui/widgets/comment_card.dart';
import 'package:provider/provider.dart';

class SavedComments extends StatefulWidget {
  SavedComments({Key key}) : super(key: key);

  @override
  _SavedCommentsState createState() => _SavedCommentsState();
}

class _SavedCommentsState extends State<SavedComments> {
  Box<String> commentBox;

  @override
  void initState() {
    super.initState();
    commentBox = Hive.box<String>(cons.COMMENT_KEY);
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: cons.DEFAULT_COLOR,
        title: Text(cons.SAVED_COMMENTS),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: IconButton(
              icon: Icon(
                Icons.delete_sweep,
                size: 35,
                color: Colors.white,
              ),
              //get keys from commets box and assing them into method as parameter
              onPressed: () {
                final keys = commentBox.keys.toList();
                commentProvider.removeAllComments(keys);
              },
            ),
          ),
        ],
      ),
      body: Container(
        color: cons.DEFAULT_COLOR.withOpacity(0.2),
        child: ValueListenableBuilder(
          valueListenable: commentBox.listenable(),
          builder: (context, Box<String> comment, widget) {
            if (commentBox.length == 0) {
              return noSavedData;
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final key = comment.keys.toList()[index];
                  final value = jsonDecode(comment.get(key));
                  final Comments currentComment = Comments.fromJson(value);
                  return GestureDetector(
                  onTap: () => Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => EditComment(comment: currentComment,))),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: CommentCard(
                      backgroundColor: cons.COMMENT_CARD_COLOR,
                      comment: currentComment,
                      buttons: Column(
                        children: <Widget>[
                          deleteButton(commentProvider, currentComment),
                        ],
                      ),
                    ),
                  ),
                    );
                },
                itemCount: comment.length,
              );
            }
          },
        ),
      ),
    );
  }

  //show empty data message
  Widget get noSavedData => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.sentiment_neutral,
              size: 60,
              color: Colors.red,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "No saved data",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      );

  //delete button
  Widget deleteButton(commentProvider, currentComment) => IconButton(
      icon: Icon(
        Icons.delete_forever,
        color: Colors.black,
        size: 45,
      ),
      onPressed: () => commentProvider.removeComment(currentComment));
}
