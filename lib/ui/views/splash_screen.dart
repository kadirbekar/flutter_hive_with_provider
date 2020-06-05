import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_local_storage/core/consts/ui_text_helper.dart' as text;
import 'package:hive_local_storage/ui/widgets/tabbar.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future pageRotate() async {
    Future.delayed(Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TabbarWidget()));
    });
  }

  @override
  void initState() {
    super.initState();
    pageRotate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: SvgPicture.asset(
            text.splash_svg,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
