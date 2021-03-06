import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../consts/consts.dart' as cons;
import '../models/commens.dart';

class CommentViewModel extends ChangeNotifier {
  List<Comments> _comments = [];
  List<Comments> get comments => _comments;
  Box<String> commentBox = Hive.box<String>(cons.COMMENT_KEY);

  
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
  removeAllComments(List<dynamic> keys) {
    _comments.clear();
    commentBox.deleteAll(keys);
    notifyListeners();
  }

  //edit comment
  editComment({Comments comments}) {
    final encodedComment = jsonEncode(comments);
    commentBox.put(comments.id, encodedComment);
  }
}
