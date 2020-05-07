import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_local_storage/core/viewmodels/comment_vm.dart';
import 'package:hive_local_storage/ui/widgets/tabbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_local_storage/core/consts/consts.dart' as cons;
import 'package:provider/provider.dart';

import 'core/models/commens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory document = await getApplicationDocumentsDirectory();

  Hive.init(document.path);

  await Hive.openBox<Comments>(cons.H_COMMENTS);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommentViewModel>(create: (context) => CommentViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.oxygenMonoTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        home: TabbarWidget(),
      ),
    );
  }
}
