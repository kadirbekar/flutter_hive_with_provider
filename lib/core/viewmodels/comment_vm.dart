import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_local_storage/core/models/commens.dart';
import 'package:hive_local_storage/core/consts/consts.dart' as cons;

class CommentViewModel extends ChangeNotifier {
  List<Comments> _comments = [];
  List<Comments> get comments => _comments;
  Box<String> commentBox = Hive.box<String>(cons.H_COMMENTS);

  
  //save comment
  saveComment(Comments comment) {
    if(_comments.contains(comment)){
      print("already saved");
    } else {
      _comments.add(comment);
      final encodedComment = jsonEncode(comment);
      commentBox.put(comment.id, encodedComment);
    }
    notifyListeners();
  }

  //remove comment
  removeComment(Comments comment) {
    _comments.remove(comment);
    commentBox.delete(comment.id);
    notifyListeners();
  }

  //delete all of them
  removeAllComments() {
    _comments.clear();
    notifyListeners();
  }
}
