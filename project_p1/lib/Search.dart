import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_p1/ShowLayer.dart';
import 'FileOperation.dart';
import 'dart:convert';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  // input word
  var _keywords;

  //read txt file
  var _result = "";
  dynamic result;

  List<String> info = [];
  List<Map<String, dynamic>> room_info = [];

  void getClassroom() async{
    //print("GO");
    var inf = await FileOperation.httpGet("classroom");
    //print(inf.runtimeType);
    info = json.decode(inf).cast<String>();
  }

  @override
  void initState() {

    getClassroom();

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
    var inf = await FileOperation.httpPost(room);
    room_info = json.decode(inf).cast<Map<String, dynamic>>();
    print(room_info);
    //info = json.decode(inf).cast<String,String>();
    //print(inf.runtimeType);

    //print(tinf[0]['corx']);
    //print(tinf);
    //return inf;
  }

  void postTest() async{
    String _getPost = FileOperation.httpPost('po');
    print(_getPost);
  }


  Widget _searchList(){

    if (_keywords == null ||_keywords == '')
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: info.length * 2,
        itemBuilder: (context, i){
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          return _buildSingleRow(info[index], index);
        },
      );

    print("OK");
    List<String> matched = info.map((e){
      if (e.toUpperCase().contains(_keywords.toUpperCase()))
        return e;
    }).toList();
    print("OK!");

    matched.removeWhere((element) => element == null);

    //print(matched.length);
    if (matched.length == 0)
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: info.length * 2,
        itemBuilder: (context, i){
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          return _buildSingleRow(info[index], index);
        },
      );

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: matched.length * 2,
      itemBuilder: (context, i){
        if (i.isOdd) return new Divider();
        final index = i ~/ 2;
        return _buildSingleRow(matched[index], index);
      },
    );
  }


  Widget _buildSingleRow(String content, int index){
    return ListTile(
      title: Text(content),
      onTap: (){
        /*
        Navigator.pushReplacementNamed(context,'/classroom', arguments:{
          'searchType': 1,
          'classroomName': content
        });*/

        //getClassInfo(content);
        /*
        Navigator.push(context, MaterialPageRoute(builder: (context){
          //return SearchPage();
          //print(content);
          //print(tinf.runtimeType);
          return GalleryPage(room_info);
        }));*/
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
      return GalleryPage(room_info, "Classroom");
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(200),
            child: AppBar(
               title:
                   Text('CLASSROOM'),

              flexibleSpace:
                  Stack(
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/classroom.jpg'),
                        fit: BoxFit.cover,
                      ),
                      Column(
                        children: <Widget>[
                          SizedBox(height: 115),
                          Row(
                              children: <Widget>[
                                SizedBox(width: 70,),
                                Container(
                                  child: TextField(
                                    autofocus: true,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(30),
                                            borderSide: BorderSide.none)),
                                    onChanged: (value){
                                      setState(() {
                                        this._keywords=value;
                                      });
                                    },
                                  ),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width - 140,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(233, 233, 233, 0.8),
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                              ]
                          ),

                        ],
                      )

                    ],
                  ),
              actions: <Widget>[
                InkWell(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Row(
                      children: <Widget>[Text("cancel")],
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
              backgroundColor: Colors.transparent,
            )
        ),


        body: _searchList()
    );
  }
}