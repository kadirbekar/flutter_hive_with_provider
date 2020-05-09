import 'package:flutter/material.dart';
import 'package:hive_local_storage/ui/views/home_page.dart';
import 'package:hive_local_storage/ui/views/saved_comments.dart';
import 'package:hive_local_storage/core/consts/consts.dart' as cons;

class TabbarWidget extends StatefulWidget {
  TabbarWidget({Key key}) : super(key: key);

  @override
  _TabbarWidgetState createState() => _TabbarWidgetState();
}

class _TabbarWidgetState extends State<TabbarWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: cons.DEFAULT_COLOR,
        bottomNavigationBar: tabbar,
        body: Container(
          child: TabBarView(
            children: [
              HomePage(),
              SavedComments(),
            ],
          ),
        ),
      ),
    );
  }

  Widget get tabbar => TabBar(
        labelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.red,
        labelStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(
            text: 'Comments',
            icon: Icon(
              Icons.comment,
              size: 35,
            ),
          ),
          Tab(
            text: 'Saved Comments',
            icon: Icon(
              Icons.save,
              size: 35,
            ),
          ),
        ],
      );
}
