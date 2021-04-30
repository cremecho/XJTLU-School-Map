import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_p1/ShowLayer.dart';
import 'ShowPrinter.dart';
import 'FileOperation.dart';
import 'dart:convert';

class PrinterViewer extends StatefulWidget {
  PrinterViewer({Key key}) : super(key: key);

  _PrinterViewerState createState() => _PrinterViewerState();
}

class _PrinterViewerState extends State<PrinterViewer> {

  // input word
  var _keywords;

  //read txt file
  var _result = "";
  dynamic result;

  List<String> info = [];
  List<Map<String, dynamic>> room_info = [];

  Future getPrinter() async{
    //print("GO");
    var inf = await FileOperation.httpGet("printerroom");
    //print(inf.runtimeType);
    info = json.decode(inf).cast<String>();
    //print(info);
    //return inf;
    return inf;
  }

  @override
  void initState() {
   super.initState();
   
   print(info);
  }


/*
  //load from txt
  void loadAssests() async {
    result = await FileOperation.loadAsset();
    setState(() {

      _result = result.toString();
      print(_result);
      info = _result.split('\n');
    });
  }
*/



  void getClassInfo(String room) async{
    var inf = await FileOperation.httpPostPrinter(room);
    print("sssssssssssssssssssssssssssss");
    room_info = json.decode(inf).cast<Map<String, dynamic>>();
    print("88888888888888888888888888888888888");
    //print(inf);
    print(room_info);
    print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
    //info = json.decode(inf).cast<String,String>();
    //print(inf.runtimeType);

    //print(tinf[0]['corx']);
    //print(tinf);
    //return inf;
  }


  Widget _searchList(){


    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: info.length * 2,
      itemBuilder: (context, i){
        if (i.isOdd) return new Divider();
        final index = i ~/ 2;
        return _buildSingleRow(info[index], index);
      },
    );
  }


  Widget _buildSingleRow(String content, int index){
    //await init();
    return ListTile(
      title: Text(content),
      onTap: (){
        _passData(content);
      },
    );



  }

  void _passData(String content) async
  {
    await getClassInfo(content);
    Navigator.push(context, MaterialPageRoute(builder: (context){
      //return SearchPage();
      //print(content);
      //print(tinf.runtimeType);
      return PGalleryPage(room_info);
    }));
  }


  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return _searchList();
      },
      future: getPrinter(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return
    Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(120),
            child: AppBar(
              title: Text("Printer"),
              flexibleSpace: Image(
                image: AssetImage('images/Printer.jpg'),
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.transparent,
            )
        ),
        body: projectWidget()
        //_searchList()
    );
  }
}