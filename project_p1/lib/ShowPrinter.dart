import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:vector_math/vector_math_64.dart' as vector;

import 'package:flutter/rendering.dart';
class PGalleryPage extends StatefulWidget {

  List<Map<String, dynamic>> info;

  PGalleryPage(this.info);

  @override
  _PGalleryPageState createState() => _PGalleryPageState();
}




class PositionPainter extends CustomPainter
{
  double xratio = 0.0;
  double yratio = 0.0;
  PositionPainter(double xRatio, double yRatio)
  {
    xratio = xRatio;
    yratio = yRatio;
  }

  Paint _paint = new Paint()
    ..color = Colors.deepOrange
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 3.0
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size)
  {
    //canvas.drawCircle(Offset(size.width * xratio, size.height * yratio), 5, _paint);
    canvas.drawCircle(Offset(size.width * xratio, size.height * yratio), 5, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate)
  {
    return false;
  }
}

class _PGalleryPageState extends State<PGalleryPage> {

  final _key = GlobalKey();
  List<String> images = [];
  String _currentImage;
  String _currentFloor = "Floor " + 1.toString();
  String _room = "";
  String _feature = "";
  List<double> ratios = [];
  List<int> floors = [];
  double x_ratio = 0.2;
  double y_ratio = 0.5;

  TransformationController _controller = TransformationController();

  @override
  void initState()
  {
    super.initState();

    //print(widget.info);
    for(int i = 0; i < widget.info.length; i++)
    {
      _room = widget.info[i]['room'];
      ratios.add(widget.info[i]['pixelw']/2550);
      ratios.add((1300 - widget.info[i]['pixelh'])/1300);
      //ratios.add(0.5);
      //ratios.add(0.5);
      floors.add(widget.info[i]['floor']);
    }
    _feature = widget.info[0]['feature'];
    print(widget.info);
    if(floors.length == 1)
    {
      images.add('images/S'+ floors[0].toString() +'.png');
    }
    else
    {
      images.add('images/S'+ 1.toString() +'.png');
      images.add('images/S'+ 2.toString() +'.png');
    }
    print(floors);
    print(ratios);
    _currentImage = images[0];
    _currentFloor = "Floor  " + floors[0].toString();
    x_ratio = ratios[0];
    y_ratio = ratios[1];

    //_controller = TransformationController(
    //    Matrix4.translation(vector.Vector3());
    //);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 20;
    double height = MediaQuery.of(context).size.height - 60;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:15,),
              Text(
                'PRINTER IN ' + _room,
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Cinzel',
                  color: Colors.black54
                  //fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 35,),
              Expanded(
                child:
                InteractiveViewer(
                  boundaryMargin: EdgeInsets.all(10),
                  transformationController: _controller,
                  maxScale: 5.0,
                  child: Container(
                    //color: Color.fromRGBO(237, 233, 227, 0),
                      decoration: new BoxDecoration(color: Color.fromRGBO(237, 233, 227, 1)),
                      height: height,
                      width: width,
                      child: Transform(

                        transform: Matrix4(
                          1.5,0,0,0,
                          0,1.5,0,0,
                          0,0,1.5,0,
                          0,0,0,1,
                        ),
                        origin: Offset(width * x_ratio, width * y_ratio * 130/255),
                        child: Stack(
                          children: <Widget>[
                            Image.asset(_currentImage, key: _key,),

                            CustomPaint(
                              size: Size(width, width*1300/ 2550),
                              painter: PositionPainter(x_ratio,y_ratio),
                            )
                          ],
                        ),
                      )

                  ),
                ),
              ),
              SizedBox(
                height:40,
              ),
              Text(
                'Description:',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 25,
                  fontFamily: 'Cinzel',

                  //fontWeight: FontWeight.bold
                ),
              )
              ,
              SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
                child: Text(
                  _feature,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontFamily: 'Arvo',
                    //fontWeight: FontWeight.bold
                  ),
                )

              ),
            ],
          ),
        ),
      ),
    );
  }
}