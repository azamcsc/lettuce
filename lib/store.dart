import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
//import 'package:progress_indicator_button/progress_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:lettuce/localdata.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

class ListPageMap extends StatefulWidget {
  const ListPageMap({ Key? key }) : super(key: key);

  @override
  _ListPageMapState createState() => _ListPageMapState();
}

class _ListPageMapState extends State<ListPageMap> {

  Completer<GoogleMapController> _controller = Completer();
  double zoomVal=500.0;
  Set<Marker> _markers = {};
  var selectedDistance;
  var selectedLat;
  var selectedLog;
  //late List storedata=[];


  //final Completer<GoogleMapController?> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? sourcePosition, destinationPosition;
  loc.LocationData? _currentPosition;
  LatLng curLocation = LatLng(5.405731918486201, 103.0876196);//(23.0525, 72.5667);
  StreamSubscription<loc.LocationData>? locationSubscription;



  var _isLoading=false;
  var title= "Find A Store Near You";
  @override

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text("List Store"),
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

  void initState() {
    // TODO: implement initState
    super.initState();
    // setCustomMarker();
    //_listbabyhatch();
    _onMapCreated();
    getNavigation();
  }
/*
  _listbabyhatch() async {
    print("masuk sini");
    var data = {
      "action": "listbabyhatch",
    };
    var returnData = await dioHttpPostRequest(context,data,"babyhatch.php",1,"Please wait..","brewing data..");
    print("xxxyyyyxxx");
    print(returnData);
    print("xxxyyyyxxx");
    Navigator.pop(context);

    if(returnData!="errorException"){

      if(returnData['status']==true){
        print("list bbyghhact");
        print(returnData);
        setState(() {
          babyhatchdata=returnData['data'];
        });
        print("koko");
        print(babyhatchdata);
        // Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);



        *//* Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => RootApp())

        );*//*

        // screenLoadingx(context,"",returnData['mesejayat'].toString(),true,true,false);
        //Navigator.of(context).pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);

        // _myorder();

*//*
        Map<String, dynamic> map = returnData;
        List<dynamic> data = map["data"];
        List<Jadual> Jaduals = [];
        for (int i = 0; i < returnData['count_result']; i++) {
          Jadual user = Jadual(data[i]['codecategori'],data[i]['categoryname']);

          Jaduals.add(user);
        }

        return Jaduals;*//*
      }else{
        screenLoadingx(context,"",returnData['msgtxt'].toString(),true,true,false);
        *//*if(returnData['count_result']=="0"){
          setState(() {
            statusrekod="false";
          });

        }else{

          Navigator.of(context).pushNamedAndRemoveUntil('/Menu', (Route<dynamic> route) => false);
          screenLoadingx(context,"",returnData['mesejayat'].toString(),true,true,false);

        }*//*

      }


    }



  }*/

  buildBody(){
    return SingleChildScrollView(

      padding: EdgeInsets.only(left: 0, right: 0),
      child: Column(
          children: [
            getHeader(),
            Stack(
              children: <Widget>[
                _buildGoogleMap(context),
                /*_zoomminusfunction(),
                _zoomplusfunction(),*/
                Positioned(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:_buildContainer(),//getChats(),//
                  ),
                ),

              ],
            ),
          ]
      ),
    );
  }



  getHeader(){
    return
      Container(
          padding: EdgeInsets.fromLTRB(0, 60, 0, 5),
          child: Column(
            children: [

              SizedBox(height: 15),

            ],
          )
      );
  }

  httpJob(AnimationController controller) async {
    controller.forward();
    print("delay start");
    await Future.delayed(Duration(seconds: 3), () {});
    print("delay stop");
    controller.reset();
  }

  getChats(){
    return
      ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(top: 10),
          shrinkWrap: true,
          children: List.generate(storedata.length,
                  (index) =>storedata.length>0 ? _buildContainer():Container()



            /* => ChatItem(chats[index],
                onTap: ()async{
                  *//* const String lat = "42.3540";
                  const String lng = "71.0586";
                  const String mapUrl = "geo:$lat,$lng";
                  if (await canLaunch(mapUrl)) {
                  await launch(mapUrl);
                  } else {
                  throw "Couldn't launch Map";
                  }*//*
                  *//*Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NavigationScreen(
                          double.parse("3.1626"),
                          double.parse("101.7122"))));*//*
                  //MapUtils.openMap(-3.823216,-38.481700);
                },
              )*/
          )
      );
  }




  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }
  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.712776, -74.005974), zoom: zoomVal)));
  }


  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 60.0),
        height: 100.0,
        child:

        ListView(
            scrollDirection: Axis.horizontal,
            children:List.generate(storedata.length,
                    (index){
              print("dasdsscds");
              print(storedata.length);
                  var j=    calculateDistance(double.parse(storedata[index]['lat']),double.parse(storedata[index]['log']), curLocation.latitude, curLocation.longitude);
                  //var latlongx =babyhatchdata[index]['skill'];
                  print("xxxxxxx");
                  print(j);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _boxes(
                        "https://www.todayscatholic.com.my/wp-content/uploads/2019/06/BabyHatch.png",
                        double.parse(storedata[index]['lat']),double.parse(storedata[index]['log']),storedata[index]['storename'],storedata[index]['storename'],j),
                  );
                })

          /*<Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.todayscatholic.com.my/wp-content/uploads/2019/06/BabyHatch.png",
                  6.163325, 100.519793,"xxxxx"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.todayscatholic.com.my/wp-content/uploads/2019/06/BabyHatch.png",
                  6.1677628,100.4717278,"Le Bernardin"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.todayscatholic.com.my/wp-content/uploads/2019/06/BabyHatch.png",
                  6.1677628,100.4717278,"Blue Hill"),
            ),
          ],*/
        ),
      ),
    );
  }


  getDirections(dst1,dst2) async {
    print("mmmmmmmm");
    List<LatLng> polylineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyAcew41cugd9apDMiAt_DVUT-lUHkQcmJU',
        PointLatLng(curLocation.latitude, curLocation.longitude),
        PointLatLng(dst1, dst2),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        points.add({'lat': point.latitude, 'lng': point.longitude});
      });
    } else {
      print("jjjjjj");
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }


  Widget _boxes(String _image, double lat,double long,String restaurantName,String bhID,double jx) {

    return  GestureDetector(
      onTap: ()async {
        final GoogleMapController controller = await _controller.future;
        controller.showMarkerInfoWindow(MarkerId(bhID));
        _gotoLocation(lat,long);
        setState(() {
          selectedLat=lat;
          selectedLog=long;

          getDirections(selectedLat,selectedLog);


          selectedDistance="34";
        });
      },
      child:Container(
          alignment: Alignment.center,
          //height: 200,
          width: 300,
          margin: EdgeInsets.only(bottom: 2),
          padding: const EdgeInsets.all(2),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset('assets/lettuce.png',height: 50,width: 50,),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: myDetailsContainer1(restaurantName,jx),
                ),
              ),

            ],)
      ),
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Widget myDetailsContainer1(String restaurantName,hj) {
    String inString = hj.toStringAsFixed(2); // '2.35'
    double inDouble = double.parse(inString);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Container(

              child: Text(restaurantName,
                style: TextStyle(
                    color: Color(0xff6200ee),
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height:5.0),
        Container(
            child: Text(
              "Distance : \u00B7 ${inDouble}km",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {

    return Container(
        height: MediaQuery.of(context).size.height-200,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
                padding: EdgeInsets.only(
                    bottom:MediaQuery.of(context).size.height*0.75),
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.normal,
                polylines: Set<Polyline>.of(polylines.values),
                initialCameraPosition:  CameraPosition(target: curLocation, zoom: 12),
                gestureRecognizers: < Factory < OneSequenceGestureRecognizer >> {
                  Factory < OneSequenceGestureRecognizer > (
                        () =>  EagerGestureRecognizer(),
                  ),
                },
                onMapCreated: (GoogleMapController controller) async{
                  //final GoogleMapController controller = await _controller.future;
                  _markers.add(
                      Marker(
                        markerId: MarkerId("cl"),
                        position: curLocation,
                        infoWindow: InfoWindow(title: "Your Location"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueOrange,
                        ),
                      )
                  );

                  // controller.showMarkerInfoWindow(MarkerId("cl"));
                  _controller.complete(controller);

                },
                markers: _markers//{
              //for (var i = 0; i < 10; i++) {
              /* Marker(
              markerId: MarkerId('bluehill'),
              position: LatLng(6.1796454,100.5246638),
              infoWindow: InfoWindow(title: 'Blue Hillx'),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet,
              ),
            )*/
              //}

              // newyork1Marker,newyork2Marker,newyork3Marker,gramercyMarker,bernardinMarker,blueMarker
              //},
            ),
            /*Positioned(
            top: 30,
            left: 15,
            child: GestureDetector(
              onTap: () {

              },
              child: Icon(Icons.arrow_back),
            ),
          ),*/
            Positioned(
                bottom: 250,
                right: 10,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.navigation_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await launchUrl(Uri.parse(
                            'google.navigation:q=${selectedLat}, ${selectedLog}&key=AIzaSyDw6sLACEWvsuPdl3RsOlYTnPXnemlTcDg'));
                      },
                    ),
                  ),
                ))
          ],
        )
    );
  }


  void _onMapCreated() async{
   // await _listbabyhatch();
    _markers.clear();

    for (var i = 0; i < storedata.length; i++) {
      print("ooooootttooooooo");
      print(storedata[i]['storename']);
      setState(() {

        _markers.add(
            Marker(
              markerId: MarkerId(storedata[i]['storename']),
              position: LatLng(double.parse(storedata[i]['lat']),double.parse(storedata[i]['log'])),
              infoWindow: InfoWindow(title: storedata[i]['storename']),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueYellow,
              ),
            )
        );
      });
    }
  }

  Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
              bearing: 45.0,)));
  }


  getNavigation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    final GoogleMapController? controller = await _controller.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (_permissionGranted == loc.PermissionStatus.granted) {
      _currentPosition = await location.getLocation();
      setState(() {
        curLocation =LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
      });

      print("fffff");
      print(curLocation.latitude);
      /* locationSubscription =
          location.onLocationChanged.listen((LocationData currentLocation) {
            controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
              zoom: 16,
            ))).then((_) async {
              await Future.delayed(Duration(seconds: 3));

              //getDirections(const LatLng(6.1560497,100.5197951));

            });



          });*/
    }
  }




  addPolyLine(List<LatLng>polylineCoordinates) {
    print("ssssssss");
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

}

class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    // Uri googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    var googleUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=-3.823216,-38.481700');
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}





/*
Marker gramercyMarker = Marker(
  markerId: MarkerId('gramercy'),
  position: LatLng(40.738380, -73.988426),
  infoWindow: InfoWindow(title: 'Gramercy Tavern'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);

Marker bernardinMarker = Marker(
  markerId: MarkerId('bernardin'),
  position: LatLng(6.1796454,100.5246638),
  infoWindow: InfoWindow(title: 'Le Bernardin'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('bluehill'),
  position: LatLng(6.1796454,100.5246638),
  infoWindow: InfoWindow(title: 'Blue Hillx'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork1Marker = Marker(
  markerId: MarkerId('newyork1'),
  position: LatLng(6.147453, 100.514643),
  infoWindow: InfoWindow(title: 'Los Tacos'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork2Marker = Marker(
  markerId: MarkerId('newyork2'),
  position: LatLng(6.1636668,100.516703),
  infoWindow: InfoWindow(title: 'Tree Bistro'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork3Marker = Marker(
  markerId: MarkerId('newyork3'),
  position: LatLng(6.167789,100.47176278),
  infoWindow: InfoWindow(title: 'Le Coucou'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);*/