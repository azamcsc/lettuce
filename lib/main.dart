import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';
import 'detail.dart';
import 'store.dart';
import 'about.dart';
import 'type.dart';
import 'disease.dart';
import 'recipe.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lettuce Disease',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        //'detail': (context) => MoreDetailPage(),
        'store': (context) => ListPageMap(),
        'about': (context) => Aboutapp(),
        'type': (context) => LettuceTypesPage(),
        'disease': (context) => LettuceDiseases(),
        'recipe': (context) => LettuceRecipes()
      },
    );
  }
}

