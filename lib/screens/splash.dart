import 'dart:async';

import 'package:epicture/screens/root.dart';
import 'package:flutter/material.dart';

class SplashScreenWidget extends StatefulWidget {
  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return RootScreenWidget();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Container(
                width: 200,
                padding: EdgeInsets.only(top: 250),
                child: Image.asset(
                  "assets/epicture.png",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: SizedBox(
                width: 250,
                child: Image.asset(
                  "assets/epicture-text.png",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
