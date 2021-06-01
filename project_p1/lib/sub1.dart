import 'dart:math' as math;
import 'PrinterViewer.dart';
//import 'package:project_p1/PrinterViewer.dart';

import 'package:project_p1/PrinterViewer.dart';

import 'Search.dart';
import 'package:flutter/material.dart';
import 'package:project_p1/SearchPage.dart';
import 'package:project_p1/ShowLayer.dart';
import 'package:project_p1/main.dart';

class SubPage extends StatefulWidget {
  final Widget child;

  const SubPage({Key key, this.child}) : super(key: key);

  static SubPageState of(BuildContext context) =>
      context.findAncestorStateOfType<SubPageState>();

  @override
  SubPageState createState() => new SubPageState();
}

class SubPageState extends State<SubPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  //AnimationController ani;
  bool _canBeDragged = false;

  double drag = 0.0;
  int mainPage = 1;
  int k = 0;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();

  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  Widget build(BuildContext context) {
    final double maxSlide = MediaQuery.of(context).size.width / 2;
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      behavior: HitTestBehavior.translucent,
      //onTap: toggle,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Material(
            color: Colors.black12,
            child: Stack(
              children: <Widget>[

                Transform.translate(
                  offset: Offset(MediaQuery.of(context).size.width/2, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(2, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - animationController.value)),
                    alignment: Alignment.centerRight,
                    child: MyDrawer1(),
                  ),
                ),
                Transform.translate(
                  offset: Offset(maxSlide * (animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(2, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - animationController.value)),
                    alignment: Alignment.centerRight,
                    child: MyDrawer(),
                  ),
                ),
                Transform.translate(
                  offset: Offset(maxSlide * animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi * animationController.value/ 2),
                    alignment: Alignment.centerLeft,
                    child: widget.child,
                  ),
                ),



                /*
                Positioned(
                  top: 16.0 + MediaQuery.of(context).padding.top,
                  left: animationController.value *
                      MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Hello Flutter Europe',
                    style: Theme.of(context).primaryTextTheme.title,
                    textAlign: TextAlign.center,
                  ),
                ),*/
              ],
            ),
          );
        },
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
    print(animationController.value);
    _canBeDragged = true;
    drag = 0.0;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / (MediaQuery.of(context).size.width / 2);
      animationController.value += delta;
/*
      drag += details.delta.dx / (MediaQuery.of(context).size.width / 2);
      if ((drag > 0) || (mainPage == 0))
        {
          //print(delta);
          animationController.value += delta;
          k = 1;
        }
      else if((drag < 0) || (mainPage == 1))
        {
          //print(delta);
          animationController.value -= delta;
          k = -1;
        }*/
    }

  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;
    drag = 0.0;
    if (animationController.isDismissed || animationController.isCompleted) {

      return;
    }

    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
      if(mainPage==0)
        {
          mainPage = 1;
        }
      else
        {
          mainPage = 0;
        }
    } else if (animationController.value < 0.5) {
      animationController.reverse();
      mainPage = 1;
      print(mainPage);
    } else {
      animationController.forward();
      mainPage = 0;
      print(mainPage);
    }

  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/2,
      height: double.infinity,
      child: Material(
        color: Colors.teal[100],
        child: SafeArea(
          child: Theme(
            data: ThemeData(brightness: Brightness.dark),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/9,
                  child:
                  ListTile(
                    leading: Icon(Icons.forward),
                    title: Text('Printer',
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                      ),),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        //return SearchPage();
                        return PrinterViewer(0);
                      }));
                    },

                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/9,
                  child:
                  ListTile(
                    leading: Icon(Icons.forward),
                    title: Text('Computer',
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                      ),),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        //return SearchPage();
                        return MyApp1();
                      }));
                    },

                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/9,
                  child:
                  ListTile(
                    leading: Icon(Icons.forward),
                    title: Text('Vendor',
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                      ),),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        //return SearchPage();
                        return MyApp1();
                      }));
                    },

                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height/9,
                  child: ListTile(
                    leading: Icon(Icons.forward),
                    title: Text('Water Dispenser',
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                      ),),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        //return SearchPage();
                        return PrinterViewer(2);
                      }));
                    },

                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyDrawer1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: double.infinity,
      child: Material(
        color: Colors.deepOrangeAccent[100],
        child: SafeArea(
          child: Theme(
            data: ThemeData(brightness: Brightness.dark),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/9,
                  child:
                  ListTile(
                    leading: Icon(Icons.forward),
                    title: Text('Self-Study',
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                      ),),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        //return SearchPage();
                        return PrinterViewer(1);
                      }));
                    },

                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/9,
                  child:
                  ListTile(
                    leading: Icon(Icons.forward),
                    title: Text('Office',
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                      ),),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        //return SearchPage();
                        return PrinterViewer(4);
                      }));
                    },

                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/9,
                  child:
                  ListTile(
                    leading: Icon(Icons.forward),
                    title: Text('Laboratory',
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                      ),),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        //return SearchPage();
                        return PrinterViewer(3);
                      }));
                    },

                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height/9,
                  child: ListTile(
                    leading: Icon(Icons.forward),
                    title: Text('Classroom',
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.white,
                      ),),
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        //return SearchPage();
                        return Search();
                      }));
                    },

                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}