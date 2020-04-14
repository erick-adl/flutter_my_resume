import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_my_resume/app/shared/widgets/custom_drawer.widget.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            body: Container(
      color: Color(0xff2f4049),
      width: mediaQuery.width,
      child: Stack(
        children: <Widget>[
          Center(
              child: Text(
            "Flutter Developer",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
          CustomDrawerWidget()
        ],
      ),
    )));
  }
}
