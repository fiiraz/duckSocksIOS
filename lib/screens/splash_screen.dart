import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simplefire/presenters/sample_presenter.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SamplePresenter presenter;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.pushReplacementNamed(context, "/login") );
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var assetImage = AssetImage('assets/images/logo_sm.png');
    var image = Image(image: assetImage, width: 48.0, height: 48.0,);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              color: Color(0xffda694b),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Container(
                          width: 200.0,
                          height: 200.0,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                image: DecorationImage(image: image.image),
                              ),),
                          ),
                        ),


                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "Duck Socks",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text("Duck Socks", style:
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      fontFamily:"Leelawadee",
                      fontStyle: FontStyle.normal,
                    ),
                      softWrap: true,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  fillData() {
    setState(() {
    });
  }
}
