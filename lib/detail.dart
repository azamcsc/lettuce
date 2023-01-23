
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettuce/localdata.dart';



class MoreDetailPage extends StatefulWidget {

  final String namapenyakit;
  MoreDetailPage({Key? key, required this.namapenyakit}) : super(key: key);


  @override
  _MoreDetailPageState createState() => _MoreDetailPageState();
}

class _MoreDetailPageState extends State<MoreDetailPage> {
//var info;
//late List info_detail=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text("More Detail"),
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(info.length, (index){

              return  widget.namapenyakit == info[index]["penyakit"]?
              Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                    onTap: (){

                    },
                    child:
                    Container (
                      padding: const EdgeInsets.all(16.0),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: new Column (
                        children: <Widget>[
                          Text(info[index]["info_detail"]),
                        ],
                      ),
                    )
                ),
              )
                  :
              Center(
                child: Text(""),
              );
            }

            )
        ),
      )
    );
  }
}
