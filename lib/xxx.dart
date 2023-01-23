import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
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

  pickGalleryImage()async
  {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    dectectImage(_image);
  }

  pickImagePhoneCamera()async
  {
    var image = await picker.pickImage(source: ImageSource.camera);
    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    dectectImage(_image);
  }

  loadModel()async
  {
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

  dectectImage(File image)async
  {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _output = output!;
      _loading = false;
    });
    // print(_output[0]['label']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 50.0,),
            const Text(
              'GetX',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 40.0,
              ),
            ),
            const SizedBox(height: 5,),
            const Text(
              'Flowers Detection Application',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            const SizedBox(height: 50.0,),
            Center(
                child: _loading
                    ?
                Container(
                  width: 350.0,
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/flowers.png'),
                      const SizedBox(height: 50.0,),
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
                      const SizedBox(height: 20.0,),
                      _output.isNotEmpty// !=null
                          ?
                      Text('${_output[0]['label']}',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                        ),
                      )
                          :
                      Container(),
                      const SizedBox(height: 10.0,),
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
                      size: const Size(100, 100),
                      child: ClipOval(
                        child: Material(
                          color: Colors.orange,
                          child: InkWell(
                            splashColor: Colors.green,
                            onTap: (){
                              pickImagePhoneCamera();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(Icons.camera_alt_rounded,size: 40.0,),
                                Text("Camera"),
                              ],
                            ),
                          ),
                        ),
                      )
                  ),
                  const SizedBox(width: 25.0,),
                  SizedBox.fromSize(
                      size: Size(100, 100),
                      child: ClipOval(
                        child: Material(
                          color: Colors.orange,
                          child: InkWell(
                            splashColor: Colors.green,
                            onTap: (){
                              pickGalleryImage();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(Icons.photo,size: 40.0,),
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
    );
  }
}
