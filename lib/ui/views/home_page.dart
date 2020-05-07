import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_local_storage/core/models/commens.dart';
import 'package:hive_local_storage/core/services/api.dart';
import 'package:hive_local_storage/core/consts/consts.dart' as cons;
import 'package:hive_local_storage/core/viewmodels/comment_vm.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService _apiService = ApiService();
  List<Comments> comments = [];

  getComments() async {
    comments = await _apiService.getComments();
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cons.APPBAR_COLOR,
        centerTitle: true,
        title: Text(
          "Comments",
          style: GoogleFonts.acme(),
        ),
      ),
      body: Container(
        color: Colors.teal.withOpacity(0.2),
        child: FutureBuilder(
          future: getComments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return commentCard(index, commentProvider);
                },
                itemCount: comments.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  //comment card
  Widget commentCard(index, commentProvider) => Padding(
        padding: EdgeInsets.all(5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          color: Colors.cyan.withOpacity(0.7),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(comments[index].postId.toString()),
              backgroundColor: Colors.indigo,
            ),
            title: Text(comments[index].name.toUpperCase()),
            subtitle: Text(comments[index].body),
            trailing: IconButton(
              icon: Icon(
                Icons.note_add,
                size: 40,
                color: Colors.black,
              ),
              onPressed: () {
                commentProvider.saveComment(comments[index]);
              },
            ),
          ),
        ),
      );
}
