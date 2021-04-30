import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SearchPage.dart';
import 'test.dart';
import 'FileOperation.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<String> info = [];

class _MyHomePageState extends State<MyHomePage> {

  void getClassroom() async{
    //print("GO");
    var inf = await FileOperation.httpGet("classroom");
    //print(inf.runtimeType);
    info = json.decode(inf).cast<String>();
    //print(info);
  }

  @override
  void initState() {
    super.initState();
    getClassroom();
    //print(info);
    Timer(Duration(seconds: 2),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                SecondScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:Image(image: AssetImage('images/SPLASH_PAGE.jpg'), fit: BoxFit.fill,)
    );
  }
}

List<double> ratio = [
  0.5, 0.5, 1, 0.5
];

List<String> images = [
  'images/testLayout.jpg',
  'images/testLayout.jpg',
];

class LinePainter extends CustomPainter
{
  Paint _paint = new Paint()
    ..color = Colors.deepOrange
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true
    ..strokeWidth = 3.0
    ..style = PaintingStyle.stroke;

  List<dynamic> ps = [];

  LinePainter(List<dynamic> points)
  {
    ps = points;
  }


  @override
  void paint(Canvas canvas, Size size)
  {
    for(int i = 0; i< ps.length-1; i++)
      {
        canvas.drawLine(Offset(size.width * ps[i]['x'] / 2550, 0.165*(1300-ps[i]['y'])),
            Offset(size.width * ps[i+1]['x'] / 2550, 0.165*(1300-ps[i+1]['y'])),
            _paint);
      }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate)
  {
    return false;
  }
}


class SecondScreen extends StatefulWidget {
  SecondScreen({Key key}) : super(key: key);

  SecondScreenState createState() => SecondScreenState();
}


class SecondScreenState extends State<SecondScreen> {

  double x_ratio = 0.5;
  double y_ratio = 0.5;
  bool show_button = true;
  bool show_maps = false;
  int ind = 0;
  double off = 30;
  String _currentImage = 'images/layout.jpg';
  //Color _color = Colors.deepOrange;
  List<Color> colors = [Colors.cyan, Colors.deepOrangeAccent, Colors.deepOrangeAccent];
  List<String> images = ['images/A3.jpg', 'images/B3.jpg','images/C3.jpg'];
  final fromController = TextEditingController();
  final toController = TextEditingController();
  TransformationController _controller = TransformationController();


  List<List<dynamic>> path_info = [[]];

  @override
  void initState()
  {
    super.initState();
    _controller.toScene(Offset(0,500));
    _controller.value = Matrix4(
      1,0,0,0,
      0,1,0,0,
      0,0,1,0,
      0,0,0,1,
    );
    //_controller.toScene(Offset(0,500));
  }

  void getPathInfo(String rooms) async{
    var inf = await FileOperation.httpPostPath(rooms);
    //print(inf);

    //print("ffffffffffffffffffffffffffffff");
    path_info.clear();
    path_info = json.decode(inf).cast<List<dynamic>>();
    //print(path.runtimeType);
    print(path_info);
    //print(path_info[0][0]['x']);
    //print(room_info);
    //info = json.decode(inf).cast<String,String>();
    //print(inf.runtimeType);

    //print(tinf[0]['corx']);
    //print(tinf);
    //return inf;
  }

  void _passData(String content) async
  {
    await getPathInfo(content);
  }

  @override

  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
          /*constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
         image: new DecorationImage(
            fit: BoxFit.cover,
            image: new AssetImage('images/layout.jpg'),

        ),
      ),*/
          child:Stack
            (
              children: <Widget>[
                //SizedBox(height: 40),

                Container(
                  child:
                      Row(
                        children: [
                          Expanded(
                            child: InteractiveViewer(
                              //boundaryMargin: EdgeInsets.all(10),
                              transformationController: _controller,
                              maxScale: 5.0,
                              child: Container(
                                decoration: new BoxDecoration(color: Color.fromRGBO(237, 233, 227, 1)),
                                height: height,
                                width: width,
                                child:
                                    Transform.translate(
                                      offset: Offset(0,off),
                                      child:
                                      Stack(
                                        children: <Widget>[

                                        Image.asset(_currentImage,
                                            //fit: BoxFit.fill,
                                            //width: MediaQuery.of(context).size.width,
                                            //height: MediaQuery.of(context).size.height,
                                        ),

                                        CustomPaint(
                                          size: Size(width, height),
                                          painter: LinePainter(path_info[ind]),
                                        ),

                                      ],
                                    ),
                                    )



                              ),
                            ),
                          ),
                        ],
                      ),

                ),
                Positioned(
                    top: 40,
                    left: width * 0.1,
                   // SizedBox(height: 40),
                    child:  Theme(data: new ThemeData(
                      primaryColor: Colors.black54,
                      primaryColorDark: Colors.black54,
                    ),
                      child:

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width*0.8,
                                child: new TextField(
                                  controller: fromController,
                                  decoration: InputDecoration(

                                      prefixIcon: Icon(Icons.location_on, color: Colors.black45 ),
                                      border: new OutlineInputBorder(
                                          //borderRadius: new BorderRadius.circular(15.0),
                                          borderSide: const BorderSide(color: Colors.black12)
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 60),
                                      hintText: 'Start From ...',
                                      hintStyle: TextStyle(
                                        height: 0.3,
                                        color: Colors.black26,
                                        fontSize: 16,
                                      )

                                  ),
                                  onChanged: (value){
                                    setState(() {
                                      show_button = true;
                                    });

                                  },//controller: TextEditingController() ..text,
                                ),

                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 50,
                                child: new TextField(
                                  controller: toController,
                                  decoration: InputDecoration(

                                      prefixIcon: Icon(Icons.where_to_vote, color: Colors.black45,),
                                      border: new OutlineInputBorder(
                                          //borderRadius: new BorderRadius.circular(15.0),
                                          borderSide: const BorderSide(color: Colors.black12)
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 60),
                                      hintText: 'Go To ...',
                                      hintStyle: TextStyle(
                                        height: 0.3,
                                        color: Colors.black26,
                                        fontSize: 16,
                                      )

                                  ),
                                  onChanged: (value){
                                    setState(() {
                                      show_button = true;
                                    });

                                  },
                                  //controller: TextEditingController() ..text,
                                ),

                              ),
                              SizedBox(height: 20.0),
                              ///if the show button is false
                              !show_button
                                  ? const SizedBox.shrink()
                                  :
                              ElevatedButton(
                                  onPressed: () async{
                                         print(fromController.text.toUpperCase());
                                         //_passData(f);
                                         //print(info);
                                         off = 300;
                                         String f = fromController.text.toUpperCase().trim();
                                         String t = toController.text.toUpperCase().trim();

                                         bool from = info.contains(f);
                                         //print(from);
                                         bool to = info.contains(t);

                                         bool equal = (f==t);

                                         if(from && to && (!equal))
                                           {
                                             ind = 0;
                                             String str = f + '!' + t + '!' + f[2] + '!' + t[2];
                                             print(str);
                                             await _passData(str);
                                             String l1 = 'images/'+ f[0] + f[2] + '.png';
                                             String l2 = 'images/'+ t[0] + t[2] + '.png';
                                             //print(info);
                                             setState(() {
                                               show_button = false;
                                               show_maps = true;
                                               if(l1 == l2)
                                               {
                                                 images.clear();
                                                 images.add(l1);
                                               }
                                               else
                                               {
                                                 images.clear();
                                                 images.add(l1);
                                                 images.add(l2);
                                               }
                                               print(images);
                                               _currentImage = images[0];
                                               //_controller.toScene(Offset(width * x_ratio, height * y_ratio));
                                               _controller.value = Matrix4(
                                                 1,0,0,0,
                                                 0,1,0,0,
                                                 0,0,1,0,
                                                 0,0,0,1,
                                               );
                                               //_controller.toScene(Offset(500, 0));

                                               colors.clear();

                                               for(int i=0; i<images.length;i++)
                                               {
                                                 colors.add(Colors.grey);
                                               }
                                               colors[0] = Colors.black12;

                                             });
                                           }
                                  },

                                  child:
                                       Text("GO!") ),

                            ],

                          ),

                    ),
                ),
                Positioned(
                    top: height/3,
                    right: 8,

                    child:

                     !show_maps
                        ? const SizedBox.shrink()
                        :Container(
                    height: height/2,
                    width:40,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                ind = index;
                                _currentImage = images[index];
                                //_currentFloor = "Floor  " + floors[index].toString();
                                _controller.value = Matrix4.identity();
                                //x_ratio = ratios[index*2];
                                //y_ratio = ratios[index * 2 + 1];
                                for(int i=0; i<images.length;i++)
                                {
                                  colors[i] = Colors.grey;
                                }
                                colors[index] = Colors.black12;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(2),
                              //color: colors[index],
                              child: Icon(
                                Icons.adjust,
                                color: colors[index],
                              ),
                            ),
                          );
                        }
                    )
                ))
                //Container(
                //
                //)


              ],
          )

     ),
      floatingActionButton: FloatingActionButton(
        child:
            new IconTheme(data: new IconThemeData(
              color: Colors.black54,
              ),
              child: Icon(
                Icons.more_vert,

            ),),
          focusColor: Colors.white38,
          backgroundColor: Colors.white,
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            //return SearchPage();
            return MyApp1();
          }));
        },
      ),
    );
  }


}