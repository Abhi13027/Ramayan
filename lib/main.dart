import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'playlist.dart';


void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new AfterSplash(),
        image: new Image(
          image: AssetImage('images/Raavan.png'),
          alignment: Alignment(0.0,1.0),),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
        ),
        photoSize: 180.0,
        loaderColor: Colors.transparent,
      ),
    );
  }
}


class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Ramayan",
      home: Playlist(
        url: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet%2CcontentDetails&maxResults=50&playlistId=PL-k_liNMvNQAQWZ6MILib_1Zmic3vJbMr&key=AIzaSyDZEQ252HTIXSxdLrUW0M9W3MkqXir7hbw",
        title: "RAMAYAN - Ramanand Sagar",
      ),
    );
  }
}
