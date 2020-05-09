import 'package:flutter/material.dart';
import 'package:hive_local_storage/core/consts/consts.dart' as cons;
import 'package:hive_local_storage/core/models/commens.dart';
import 'package:hive_local_storage/core/viewmodels/comment_vm.dart';
import 'package:provider/provider.dart';

class EditComment extends StatefulWidget {
  final Comments comment;

  EditComment({this.comment});

  @override
  _EditCommentState createState() => _EditCommentState();
}

class _EditCommentState extends State<EditComment> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.comment.name.toUpperCase();
    emailController.text = widget.comment.email;
    bodyController.text = widget.comment.body;
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider =
        Provider.of<CommentViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: cons.DEFAULT_COLOR,
        title: Text("Edit Comment"),
      ),
      body: Container(
      color: cons.DEFAULT_COLOR.withOpacity(0.2),
      padding: EdgeInsets.all(12),
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: nameController,
          ),
          TextFormField(
            controller: emailController,
          ),
          TextField(
            controller: bodyController,
            maxLines: 5,
          ),
          SizedBox(height: 25),
          SizedBox(
            height: 50,
            width: 150,
            child: saveButton(commentProvider, widget.comment),
          ),
        ],
      ),
        ),
    );
  }
  
  //edit comment
  Widget saveButton(CommentViewModel commentProvider, Comments comment) =>
      RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        color: cons.DEFAULT_COLOR,
        onPressed: () {
          widget.comment.postId = widget.comment.postId;
          widget.comment.id = widget.comment.id;
          widget.comment.name = nameController.text;
          widget.comment.body = bodyController.text;
          widget.comment.email = emailController.text;
          commentProvider.editComment(comments: widget.comment);
          Navigator.of(context).pop();
        },
        child: Text(
          "Save",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
      );
}
