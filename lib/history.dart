import 'package:flutter/material.dart';
import 'package:lettuce/function.dart';
import 'package:lettuce/url_source.dart';

class ListHistory extends StatefulWidget {
  const ListHistory({ Key? key }) : super(key: key);

  @override
  _ListHistoryState createState() => _ListHistoryState();
}

class _ListHistoryState extends State<ListHistory> {
  @override


  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text("List History"),
      /*  actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
              // handle the press
            },
          ),
        ],*/
      ),
      body: buildBody(),
    );
  }

  late List listhistory=[];

  @override
  void initState() {
    super.initState();
    _lishistory();
  }

  _lishistory() async {
    print("masuk sini");
    var data = {
      "action": "listbabyhatch",
    };
    var returnData = await dioHttpPostRequest(context,data,"history.php",1,"Please wait..","brewing data..");
    print("xxxyyyyxxx");
    print(returnData);
    print("xxxyyyyxxx");
    Navigator.pop(context);

    if(returnData!="errorException"){

      if(returnData['status']==true){
        print("list bbyghhact");
        print(returnData);
        setState(() {
          listhistory=returnData['data'];
        });
        print("koko");
        print(listhistory);
        // Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);



        /* Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RootApp())

        );*/

        // screenLoadingx(context,"",returnData['mesejayat'].toString(),true,true,false);
        //Navigator.of(context).pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);

        // _myorder();

/*
        Map<String, dynamic> map = returnData;
        List<dynamic> data = map["data"];
        List<Jadual> Jaduals = [];
        for (int i = 0; i < returnData['count_result']; i++) {
          Jadual user = Jadual(data[i]['codecategori'],data[i]['categoryname']);

          Jaduals.add(user);
        }

        return Jaduals;*/
      }else{
        screenLoadingx(context,"",returnData['msgtxt'].toString(),true,true,false);
        /*if(returnData['count_result']=="0"){
          setState(() {
            statusrekod="false";
          });

        }else{

          Navigator.of(context).pushNamedAndRemoveUntil('/Menu', (Route<dynamic> route) => false);
          screenLoadingx(context,"",returnData['mesejayat'].toString(),true,true,false);

        }*/

      }


    }



  }

  buildBody(){
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
          children: [
            getHeader(),
            getChats(),
          ]
      ),
    );
  }

  getHeader(){
    return
      Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),

      );
  }

  getChats(){
    return
      ListView(
          padding: EdgeInsets.only(top: 10),
          shrinkWrap: true,
          children: List.generate(listhistory.length,
                  (index){
                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.network(
                              mainUrl+"uploadimg/"+listhistory[index]['image'],
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                              child:
                              Container(
                                  child:
                                  Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                         // Expanded(
                                             // child:
                                           Container(
                                                  child: Text(listhistory[index]['penyakit'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                                              ),
                                          SizedBox(width: 10,),
                                          //),
                                         // Expanded(
                                             // child:
                                              Container(
                                                  child: Text(listhistory[index]['date'], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
                                              ),
                                          //),
                                          SizedBox(width: 5),

                                        ],
                                      ),
                                      SizedBox(height: 5,),

                                    ],
                                  )
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
          )
      );

  }
}