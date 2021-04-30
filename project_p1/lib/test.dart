import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: new TextStyle(
          fontFamily: "Ewert",
          //fontSize: 25.0,
        ),),
    ),
    body: Center(
    // Center is a layout widget. It takes a single child and positions it
    // in the middle of the parent.
    child: ElevatedButton(
    child: Text("TEST DATA", style: new TextStyle(
    fontFamily: 'Cinzel')),
    onPressed: () async {
      /*
      var httpClient = new HttpClient();
      var uri = new Uri.http(
          '49.234.94.245', '/', {'classroom': 'SB102'});
      //String url = 'http://49.234.94.245/classroom/SB123';
      // ignore: close_sinks
      var res = await httpClient.getUrl(uri);
      //var res = await http.post(url,body: "classroom=SB102")
      var response = await res.close();
      var responseBody = await response.transform(utf8.decoder).join();
      var data = json.decode(responseBody);
      //decode jason file
      //var json = jsonDecode(body);
      print(data);*/
      //var url_post = Uri.parse('http://49.234.94.245/searchpath');
      var ur_post = Uri.parse('http://49.234.94.245/po');
      //var client = http.Client();
      print("1111111111111");
      //var response = await http.post(url_post, body: {'tmp':'SA264!SB221!2!2'});
      var response1 = await http.post(ur_post, body: {'classroom':'SA169'});
      print("2222222222222");
      //var _content = response.body;
      var _content1 = response1.body;
      //print(json.decode(_content));
      print(json.decode(_content1));
    }
      )
    ),
    floatingActionButton: FloatingActionButton(
    onPressed: _incrementCounter,
    tooltip: 'Increment',
    child: Icon(Icons.add),
    ), // This trailing comma makes auto-formatting nicer for build methods.
    );
    }
  }
