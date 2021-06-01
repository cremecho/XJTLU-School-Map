import 'dart:core';
import 'dart:io';
//import 'package:excel/excel.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;


import 'package:flutter/services.dart' show ByteData, rootBundle;

class FileOperation{
  static String _server = 'http://49.234.94.245/';




  static Future<String> loadAsset() async {
    var a = await rootBundle.loadString('resources/test.txt');
    return a;
  }


  static httpGet(String purl) async{
    var client = http.Client();
    var url = Uri.parse(_server + purl);
    var respone = await client.get(url);
    int i = 0;
    while (respone.statusCode != 200 && i < 10){
      var respone = await http.get(url);
      i++;
    }
    if (i == 10){
      return 'wrong network state, please check the network connection\n error type : ${respone.statusCode.toString()}';
    }
    //print(respone.body);
    return respone.body;
  }

  static httpPost(String room) async {
    /*
    var url = Uri.parse(_server + purl);
    var respone = await http.post(url, body: "clasroom=SB102");
    return respone.body;
  }*/
    var url_post = Uri.parse('http://49.234.94.245/po');
    //var client = http.Client();
    var response = await http.post(url_post, body: {'classroom': room});
    var _content = response.body;
    return _content;
  }

  static httpPostPrinter(String printer, String type) async {
    /*
    var url = Uri.parse(_server + purl);
    var respone = await http.post(url, body: "clasroom=SB102");
    return respone.body;
  }*/
    var url_post = Uri.parse('http://49.234.94.245/' + type);
    //var client = http.Client();
    var response = await http.post(url_post, body: {'classroom': printer});
    var _content = response.body;
    return _content;
  }

  static httpPostPath(String info) async {
    /*
    var url = Uri.parse(_server + purl);
    var respone = await http.post(url, body: "clasroom=SB102");
    return respone.body;
  }*/
    var url_post = Uri.parse('http://49.234.94.245/searchpath');
    //var client = http.Client();
    var response = await http.post(url_post, body: {'tmp': info});
    var _content = response.body;
    return _content;
  }

}