import 'package:flutter/material.dart';
import 'package:hive_local_storage/core/models/commens.dart';
import 'package:hive_local_storage/core/consts/consts.dart' as cons;

class CommentCard extends StatelessWidget {
  final Comments comment;
  final Function onPressed;
  final Color backgroundColor;
  final IconButton deleteButton;
  final IconButton addButton;
  final Column buttons;

  CommentCard({
    this.comment,
    this.onPressed,
    this.backgroundColor = cons.COMMENT_CARD_COLOR,
    this.deleteButton,
    this.addButton,
    this.buttons
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      color: this.backgroundColor,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(comment.postId.toString()),
          backgroundColor: Colors.indigo,
        ),
        title: Text(comment.name.toUpperCase()),
        subtitle: Text(comment.body),
        trailing: buttons
      ),
    );
  }
}
