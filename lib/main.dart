import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_local_storage/core/viewmodels/comment_vm.dart';
import 'package:hive_local_storage/ui/views/splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_local_storage/core/consts/consts.dart' as cons;
import 'package:provider/provider.dart';

import 'core/services/local_storage_servis.dart';
import 'core/services/theme_servis.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //get path of your data
  Directory document = await getApplicationDocumentsDirectory();

  //assing path to hive
  Hive.init(document.path);

  //run hive
  await Hive.openBox<String>(cons.COMMENT_KEY);

  //Initialize shared preferences
  await LocalStorageService.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //get instance of provider to reach its methods
  ThemeService themeService = ThemeService();

  //get value shared prefences and save into provider
  void getThemeValue() {
    themeService.getTheme = LocalStorageService.getThemeValue;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CommentViewModel>(create: (context) => CommentViewModel()),
        ChangeNotifierProvider<ThemeService>(create: (context) => ThemeService()),
      ],
      child: Consumer<ThemeService>(
        builder: (BuildContext context, ThemeService value, Widget child) =>
            MaterialApp(
          theme: value.getTheme == true ? value.darkTheme : value.lightTheme,
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      ),
    );
  }
}
