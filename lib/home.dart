import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'detail.dart';
import 'history.dart';

import "package:async/async.dart";

import 'package:path/path.dart';

import 'dart:io';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();
  var penyakit="";

  pickGalleryImage(context)async
  {
    setState(() {
      _output=[];
    });
    print("yyyyyy");
    print(_output);
    var image = await picker.pickImage(source: ImageSource.gallery);
    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    dectectImage(_image,context);
  }

  pickImagePhoneCamera(context)async
  {
    setState(() {
      _output=[];
    });
    print("yyyyyy");
    print(_output);
    var image = await picker.pickImage(source: ImageSource.camera);
    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    dectectImage(_image, context);
  }

  loadModel()async
  {
    Tflite.close();
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loadModel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel().then((value)
    {
      setState(() {

      });
    });
  }

  showLoaderDialog(context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  Future addProduct(File imageFile,penyakitx,context) async {
// ignore: deprecated_member_use
    var stream =  http.ByteStream(
        DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("https://babyhatch.000webhostapp.com/upload.php");

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile(
        "image", stream, length, filename: basename(imageFile.path));

    request.files.add(multipartFile);
    request.fields['penyakit'] = penyakitx;

    var respond = await request.send();
    if (respond.statusCode == 200) {
      print("Image Uploaded");
      Navigator.pop(context);
    } else {
      print("Upload Failed");
      Navigator.pop(context);
    }
  }

  dectectImage(File image,BuildContext context)async
  {
    showLoaderDialog(context);
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState((){
      _output = output!;
      _loading = false;
    });
    print("xxxxxxx");
    print(_output);
    if(_output.isNotEmpty){


      setState(() {
        penyakit=_output[0]['label'];
      });
      addProduct(_image,penyakit,context);
    }else{
      setState(() {
        penyakit="Invalid Image";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Welcome!'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                ),
                child: Text(
                  'All About Lettuce',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Lettuce Type'),
                onTap: () {
                  Navigator.pushNamed(context, 'type');
                  // Navigate to lettuce type screen
                },
              ),
              ListTile(
                title: Text('Recipe'),
                onTap: () {
                  Navigator.pushNamed(context, 'recipe');
                  // Navigate to about app screen
                },
              ),
              ListTile(
                title: Text('Disease'),
                onTap: () {
                  Navigator.pushNamed(context, 'disease');

                  // Navigate to disease screen
                },
              ),
              ListTile(
                title: Text('History'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListHistory(),
                    ),
                  );

                  // Navigate to history screen
                },
              ),
              ListTile(
                title: Text('Store Nearby'),
                onTap: () {
                  Navigator.pushNamed(context, 'store');
                  // Navigate to place screen
                },
              ),
              ListTile(
                title: Text('About App'),
                onTap: () {
                  Navigator.pushNamed(context, 'about');
                  // Navigate to about app screen
                },
              ),
            ],
          ),
        ),

        body: Container(

          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              const SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black87,
                    width: 3,
                  ),
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),

                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  'Define Lettuce Disease',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              Center(
                  child: _loading
                      ?
                  Container(
                    width: 350.0,
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/logo3.png'),
                        const SizedBox(height: 10.0,),
                      ],
                    ),
                  )
                      :
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 250.0,
                          child: Image.file(_image),
                        ),
                        const SizedBox(height: 5.0,),
                      //  _output.isNotEmpty// !=null
                        //    ?

                        Text(penyakit,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,

                          ),


                        ),

                         //   :
                       // Container(),
                         SizedBox(height: 10.0,),
                        // New button
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green, width: 0.5),
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(40)),
                            padding: EdgeInsets.all(0.2),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MoreDetailPage(namapenyakit:penyakit),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                            )),

                      ],
                    ),
                  )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox.fromSize(
                        size: const Size(75, 75),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              splashColor: Colors.green,
                              onTap: (){
                                pickImagePhoneCamera(context);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.camera_alt_rounded,size: 20.0,),
                                  Text("Camera"),
                                ],
                              ),
                            ),
                          ),
                        )
                    ),
                    const SizedBox(width: 50.0,),
                    SizedBox.fromSize(
                        size: Size(75, 75),
                        child: ClipOval(
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              splashColor: Colors.green,
                              onTap: (){
                                pickGalleryImage(context);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(Icons.photo,size: 20.0,),
                                  Text("Gallery"),
                                ],
                              ),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
