//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lettuce/url_source.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


Future<String> checkingConnection() async
{
  var statusReturn="";
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      statusReturn ="1";
      return statusReturn;
    }
  } on SocketException catch (_) {
    statusReturn ="0";
    return statusReturn;

  }
  return statusReturn;

}

dioHttpPostRequest(context,dataPost,action,loading,title,desc) async {
  print("zzzzzz");
  String c =mainUrl+action;
  print(c);
  var connection = await checkingConnection();
  if(connection=="1"){
    if(loading==1){
      screenLoadingx(context,title,desc,false,false,true);
    }

    BaseOptions options = BaseOptions(
      connectTimeout: 30000,//5000,
      receiveTimeout: 30000,//3000,
    );
    Dio dio = new Dio(options);
    //dio.options.headers["Authorization"] ;//= "Bearer $bearerToken";

    print(c);
    try {
      Response res = await dio.post(mainUrl+action, data:FormData.fromMap(dataPost),) ;

      var rawData = json.decode(res.toString());

//print(c);

      /* if(loading==1){
        Navigator.of(context, rootNavigator: true).pop();
      }*/
      rawData.addAll({"errorhandle": true});

      return rawData;

    } catch (e) {
      // final errorMessage = DioExceptions.fromDioError(e);

      if(loading==1){
        Navigator.of(context, rootNavigator: true).pop();
      }
      //screenLoadingx(context,"Error Message",errorMessage.toString(),true,true,false);
      //print(errorMessage.toString());
      return "errorException";
    }



  }else{
    screenLoadingx(context,"Error Message","No internet connection".toString(),true,true,false);
    return "errorException";
  }






}



Future<void> screenLoadingx(BuildContext context,title,desc,bool isclose,bool overlay,bool spin) async {

  Alert(
      context: context,
      title: title,
      desc: desc,
      content: Padding(padding: EdgeInsets.all(5.0),
        child: spin==true ?
        /*Image.asset(
          "assets/images/loading.gif",
          height: 225.0,
          width: 225.0,
        )*/
        CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent)
        ):Text("~~"),
      ),
      style: AlertStyle(
          isCloseButton: isclose,
          isOverlayTapDismiss: overlay,
          titleStyle: TextStyle(fontFamily: 'raleway', fontWeight: FontWeight.bold),
          descStyle: TextStyle(fontFamily: 'raleway', fontSize: 15.0),
          alertBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
      ),
      buttons: []
  ).show();

}


