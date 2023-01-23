import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Aboutapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: Text('About Me !'),
      ),
body: Column(
        children: [
          Image.asset('assets/lettuce.png'),
          SizedBox(height: 16), // add some space between image and text
          Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'This application is a lettuce detection tool that uses machine learning to identify different types of lettuce. It can be used by farmers and agricultural researchers to quickly and accurately identify and track different types of lettuce in their fields.',
                style: TextStyle(fontSize: 16),
              )),
        ],
      ),
    );
  }
}
