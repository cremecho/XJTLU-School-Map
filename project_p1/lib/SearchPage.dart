import 'package:flutter/material.dart';
import 'sub1.dart';

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget child = SearchPage();
    child = SubPage(child: child);
    return MaterialApp
      (
         home: child,
      );
  }
}

class SearchPage extends StatefulWidget{
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {



  @override
  void initState()
  {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
         return Scaffold(
                 body:
                     Center
                     (
                       child: Container(
                         alignment: Alignment.center,
                         color: Colors.white,
                         child: Stack(
                           children: <Widget>[
                         // Max Size

                             Container(
                               margin: EdgeInsets.only(left: 0.36 * width, top: 0, right: 0, bottom: 0),
                               height: double.infinity,
                               width: double.infinity,
                               decoration: BoxDecoration(
                                   color: Colors.deepOrangeAccent[100],
                               ),
                             ),

                             Container(
                               margin: EdgeInsets.only(left: 0, top: 0, right: 0.36 * width, bottom: 0),
                               height: double.infinity,
                               width: double.infinity,
                               decoration: BoxDecoration(
                                   color: Colors.teal[100],
                               )
                             ),

                             Container(
                               margin: EdgeInsets.only(left: 200, top: 650, right: 0, bottom: 0),
                               child:
                               Text('CLASSROOM',
                                 style: TextStyle(
                                   fontSize: 62,
                                   foreground: Paint()
                                     ..style = PaintingStyle.stroke
                                     ..strokeWidth = 6
                                     ..color = Colors.white54,
                                 ),
                               ),
                             ),

                             Container(
                               margin: EdgeInsets.only(left: 0, top: 40, right: 120),
                               child:
                               Text('EQUIP MENT',
                                 style: TextStyle(
                                   fontSize: 70,
                                   foreground: Paint()
                                     ..style = PaintingStyle.stroke
                                     ..strokeWidth = 6
                                     ..color = Colors.white54,
                                 ),
                               ),
                             ),

                             Container(
                               margin: EdgeInsets.only(left: 90, top: height * 0.36, right: 90, bottom: height * 0.36),
                               //margin: EdgeInsets.only(left: 90, top: 300, right: 90, bottom: 300),
                               height: double.infinity,
                               width: double.infinity,
                               /*
                               child:
                               Text('                More Info   About...',
                                 style: TextStyle(
                                   fontSize: 40,
                                   foreground: Paint()
                                     ..style = PaintingStyle.stroke
                                     ..strokeWidth = 6
                                     ..color = Colors.white,
                                 ),
                               ),*/
                               child: Center(
                                 child:
                                 Text('More Info About...',
                                   style: TextStyle(
                                     fontSize: 40,
                                     foreground: Paint()
                                       ..style = PaintingStyle.stroke
                                       ..strokeWidth = 6
                                       ..color = Colors.white,
                                   ),
                                 ),
                               ),
                               decoration: BoxDecoration(

                                 color: Colors.white30,
                                 borderRadius: BorderRadius.only(
                                     topLeft: Radius.circular(10),
                                     topRight: Radius.circular(10),
                                     bottomLeft: Radius.circular(10),
                                     bottomRight: Radius.circular(10)
                                 ),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.grey.withOpacity(0.5),
                                     spreadRadius: 5,
                                     blurRadius: 7,
                                     offset: Offset(0, 3), // changes position of shadow
                                   ),
                                 ],
                               ),
                             ),


                           ],

                     ),
                      )
                     )

         );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}