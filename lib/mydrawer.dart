import 'package:flutter/material.dart';
import 'playlist.dart';

class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new SingleChildScrollView(
          child: new Container(
            color: Colors.amber,
            padding: EdgeInsets.only(top: 30.0,left: 10.0, bottom: 10.0),
            child: new Column(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.video_library),
                  title: new Text("RAMAYAN - Ramanand Sagar", style: new TextStyle(fontSize: 18.0)),
                  onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context)=>new Playlist(
                        url: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet%2CcontentDetails&maxResults=50&playlistId=PL-k_liNMvNQAQWZ6MILib_1Zmic3vJbMr&key=AIzaSyDZEQ252HTIXSxdLrUW0M9W3MkqXir7hbw",
                        title: "RAMAYAN - Ramanand Sagar",
                      ))),
                )
              ],
            ),
          )
      ),
    );
  }
}