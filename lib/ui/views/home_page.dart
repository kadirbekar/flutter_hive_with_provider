import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_local_storage/core/services/local_storage_servis.dart';
import 'package:hive_local_storage/core/services/theme_servis.dart';
import 'package:provider/provider.dart';

import '../../core/consts/consts.dart' as cons;
import '../../core/models/commens.dart';
import '../../core/services/api.dart';
import '../../core/viewmodels/comment_vm.dart';
import '..//widgets/comment_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService _apiService = ApiService();
  List<Comments> comments = [];

  //init comments
  getComments() async {
    comments = await _apiService.getComments();
  }

  //get theme value from shared preferences, at the beginning it's already false
  bool themeNewValue = LocalStorageService.getThemeValue;
  bool darkTheme = false;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentViewModel>(context, listen: false);
    final themeData = Provider.of<ThemeService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: cons.DEFAULT_COLOR,
        centerTitle: true,
        title: Text(
          cons.COMMENTS,
          style: GoogleFonts.acme(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.lightbulb_outline,
              size: 30,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              themeNewValue = !themeNewValue;
              LocalStorageService.setTheme(themeNewValue);
              themeData.getTheme = themeNewValue;
            },
          )
        ],
      ),
      body: Container(
        color: Colors.teal.withOpacity(0.2),
        child: FutureBuilder(
          future: getComments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return commentCard(comments[index], commentProvider);
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
        child: CommentCard(
          backgroundColor: Colors.cyan.withOpacity(0.7),
          comment: index,
          buttons: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.indigo,
                  size: 45,
                ),
                onPressed: () => commentProvider.saveComment(index),
              ),
            ],
          ),
        ),
      );
}
