import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'mydrawer.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//import 'package:firebase_admob/firebase_admob.dart';


class Playlist extends StatefulWidget {
  Playlist({this.title, this.url});
  final String title;
  final String url;

  @override
  _PlaylistState createState() => new _PlaylistState();
}

class _PlaylistState extends State<Playlist>{

  Future<List> getData() async{
    final response = await http.get(widget.url);
    var responseBody = json.decode(response.body);
    var listItems = responseBody['items'];
    return listItems;
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.amber,
        title: new Text(widget.title),
      ),
      drawer: new MyDrawer(),
      body: Center(
        child: new FutureBuilder<List>(
            future: getData(),
            builder: (context, snapshot){
              if(snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? new ListVideo(list: snapshot.data) : new CircularProgressIndicator();
            }
        ),
      ),
    );
  }
}

class ListVideo extends StatelessWidget{
  final List list;
  ListVideo({this.list});

  @override
  Widget build(BuildContext context) {

    return new ListView.builder(
      itemCount: list==null ? 0 : list.length,
      itemBuilder: (context, i){
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              new GestureDetector(
                onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => VideoPlay(url: 'https://youtube.com/embed/${list[i]['contentDetails']['videoId']}',))),
                child: new Container(
                  height: 210.0,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new NetworkImage(list[i]['snippet']['thumbnails']['high']['url']),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
              ),
              new Padding(padding: const EdgeInsets.all(10.0)),
              new Text(list[i]['snippet']['title'], style: new TextStyle(fontSize: 18.0),),
              new Padding(padding: const EdgeInsets.all(10.0))
            ],
          ),
        );
      },
    );
  }
}

class VideoPlay extends StatefulWidget {
  final String url;

  VideoPlay({this.url});

  @override
  _VideoPlayState createState() => new _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay>{

  final flutterWebViewPlugin = FlutterWebviewPlugin();


  @override
  Widget build(BuildContext context) {
    flutterWebViewPlugin.onDestroy.listen((_){
      if(Navigator.canPop(context)){
        Navigator.of(context).pop();
      }
    });

    return new Center(
      child: new WebviewScaffold(url: widget.url),
    );
  }
}
