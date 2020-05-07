import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_local_storage/core/models/commens.dart';
import 'package:hive_local_storage/core/consts/consts.dart' as cons;

class CommentViewModel extends ChangeNotifier {
  List<Comments> _comments = [];
  List<Comments> get comments => _comments;
  Box<Comments> friendBox = Hive.box<Comments>(cons.H_COMMENTS);

  //save comment
  saveComment(Comments comment) {
    if(_comments.contains(comment)){
      print("already saved");
    } else {
      _comments.add(comment);
      friendBox.put(comment.id, comment);
    }
    notifyListeners();
  }

  //remove comment
  removeComment(Comments comment) {
    _comments.remove(comment);
    friendBox.delete(comment.id);
    notifyListeners();
  }

  //delete all of them
  removeAllComments() {
    _comments.clear();
    notifyListeners();
  }
}
