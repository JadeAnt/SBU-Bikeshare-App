import 'dart:io';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:bikeshare_functionality/BikeLocation.dart';
import 'BikeLocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  static BikeLocation WestApartmentsI= new BikeLocation(40.913378, -73.134329);
  static BikeLocation WestApartmentsC = new BikeLocation(40.911754, -73.132887);
  static BikeLocation Tabler = new BikeLocation(40.910053, -73.124887);
  static BikeLocation LifeSciences2 = new BikeLocation(40.911422, -73.120797);
  static BikeLocation Javits = new BikeLocation(40.913432, -73.121416);
  static BikeLocation WangCenter = new BikeLocation(40.916524, -73.118169);
  static BikeLocation JamesCollege = new BikeLocation(40.919247, -73.120864);
  static BikeLocation SAC = new BikeLocation(40.914429, -73.124660);
  static BikeLocation Library = new BikeLocation(40.916137, -73.123461);
  static BikeLocation AthleticFields = new BikeLocation(40.921469, -73.126406);
  static BikeLocation LIRR = new BikeLocation(40.920082, -73.128242);
  static BikeLocation SouthPLot = new BikeLocation(40.896510, -73.126509);


  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  List<Marker> allMarkers = [];
  Position _currentPosition;
  BitmapDescriptor customIcon = null;
  createMarker(context) { // function to create a custom marker
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/bike_station_icon_resized.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  GoogleMapController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    // ---------------------------------- Markers ---------------------------
    allMarkers.add(Marker(
        markerId: MarkerId('WestApartmentsI'),
        draggable: false,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(MyApp.WestApartmentsI.latitude, MyApp.WestApartmentsI.longitude, 'West Apartments I');
        },
        position: LatLng(MyApp.WestApartmentsI.latitude, MyApp.WestApartmentsI.longitude),
        icon: customIcon
    ));

    allMarkers.add(Marker(
        markerId: MarkerId('WestApartmentsC'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(MyApp.WestApartmentsC.latitude, MyApp.WestApartmentsC.longitude, 'West Apartments C');
        },
        icon: customIcon,
        position: LatLng(MyApp.WestApartmentsC.latitude, MyApp.WestApartmentsC.longitude)));
    allMarkers.add(Marker(
        markerId: MarkerId('Tabler'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(MyApp.Tabler.latitude, MyApp.Tabler.longitude, 'Tabler');
        },
        icon: customIcon,
        position: LatLng(MyApp.Tabler.latitude, MyApp.Tabler.longitude)));
    allMarkers.add(Marker(
        markerId: MarkerId('LifeSciences2'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(MyApp.LifeSciences2.latitude, MyApp.LifeSciences2.longitude, 'Life Sciences');
        },
        icon: customIcon,
        position: LatLng(MyApp.LifeSciences2.latitude, MyApp.LifeSciences2.longitude)));
    allMarkers.add(Marker(
        markerId: MarkerId('Javits'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(MyApp.Javits.latitude, MyApp.Javits.longitude, 'Javits');
        },
        icon: customIcon,
        position: LatLng(MyApp.Javits.latitude, MyApp.Javits.longitude)));
    allMarkers.add(Marker(
        markerId: MarkerId('WangCenter'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(MyApp.WangCenter.latitude, MyApp.WangCenter.longitude, 'Wang Center');
        },
        icon: customIcon,
        position: LatLng(MyApp.WangCenter.latitude, MyApp.WangCenter.longitude)));
    allMarkers.add(Marker(
        markerId: MarkerId('James College'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(MyApp.JamesCollege.latitude, MyApp.JamesCollege.longitude, 'James College');
        },
        icon: customIcon,
        position: LatLng(MyApp.JamesCollege.latitude, MyApp.JamesCollege.longitude)));
    allMarkers.add(Marker(
        markerId: MarkerId('SAC'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(MyApp.SAC.latitude, MyApp.SAC.longitude, 'SAC');
        },
        icon: customIcon,
        position: LatLng(MyApp.SAC.latitude, MyApp.SAC.longitude)));
    allMarkers.add(Marker(
        markerId: MarkerId('Library'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(MyApp.Library.latitude, MyApp.Library.longitude, 'Library');
        },
        icon: customIcon,
        position: LatLng(MyApp.Library.latitude, MyApp.Library.longitude)));
    allMarkers.add(Marker(
        markerId: MarkerId('AthleticFields'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(MyApp.AthleticFields.latitude, MyApp.AthleticFields.longitude, 'Athletic Fields');
        },
        icon: customIcon,
        position: LatLng(MyApp.AthleticFields.latitude, MyApp.AthleticFields.longitude)));
    allMarkers.add(Marker(
        markerId: MarkerId('LIRR'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(MyApp.LIRR.latitude, MyApp.LIRR.longitude, 'LIRR');
        },
        icon: customIcon,
        position: LatLng(MyApp.LIRR.latitude, MyApp.LIRR.longitude)));
    allMarkers.add(Marker(
        markerId: MarkerId('SouthPLot'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(MyApp.SouthPLot.latitude, MyApp.SouthPLot.longitude, 'South P Lot');
        },
        icon: customIcon,
        position: LatLng(MyApp.SouthPLot.latitude, MyApp.SouthPLot.longitude)));


    //-------------------------- END OF MARKERS --------------------------------

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('SBU Bike Locations')),
        backgroundColor: Colors.red[900],
      ),
      body: Stack(
          children: [Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition:
              CameraPosition(target: LatLng(40.912392, -73.123392), zoom: 16.0),
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
            ),
          ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: movetoBoston,
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.green
                  ),
                  child: Icon(Icons.forward, color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: movetoNewYork,
                child: Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.red
                  ),
                  child: Icon(Icons.backspace, color: Colors.white),
                ),
              ),
            )
          ]
      ),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  movetoBoston() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(42.3601, -71.0589), zoom: 14.0, bearing: 45.0, tilt: 45.0),
    ));
  }

  movetoNewYork() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(40.912392, -73.123392), zoom: 12.0),
    ));
    getLocation();
  }

  getLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        final marker = Marker(
          markerId: MarkerId("curr_loc"),
          position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          infoWindow: InfoWindow(title: 'Your Location'),
        );
        allMarkers.add(marker);
      });
    }).catchError((e) {
      print(e);
    });

  }


  moveToLocation(double lat, double long, String location){ // moves camera to marker location and opens a bottom sheet
    int bikes_available=0; // default value
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, long), zoom: 20.0),
    ));
    showModalBottomSheet(context: context, builder: (builder){
      return Ink(
          height: MediaQuery.of(context).size.height*0.45,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red[900],
                title: Text(location,
                    style: TextStyle(
                        fontSize: 24
                    )),
                centerTitle: true,
              ),
              body: Container(
                color: Colors.grey[400],
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Text('$bikes_available bikes are available',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            )),
                      ),
                    ),
                    Row(
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: new RawMaterialButton(
                                onPressed: (){},
                                child: new Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: new Icon(
                                    Icons.directions_walk,
                                    size: 30.0,
                                    color: Colors.white,
                                  ),
                                ),
                                shape: new CircleBorder(),
                                fillColor: Colors.lightBlue[900]
                            ),
                          ),
                          new Padding(padding: const EdgeInsets.all(15.0),
                            child: new Text('Walking Directions',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0
                                )),
                          )
                        ]
                    ),
                    Row(
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: new RawMaterialButton(
                                onPressed: (){},
                                child: new Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: new Icon(
                                    Icons.credit_card,
                                    size: 30.0,
                                    color: Colors.white,
                                  ),
                                ),
                                shape: new CircleBorder(),
                                fillColor: Colors.lightBlue[900]
                            ),
                          ),
                          new Padding(padding: const EdgeInsets.all(15.0),
                            child: new Text('Rent a Bike',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0
                                )),
                          )
                        ]
                    )
                  ],
                ),
              )
          )
      );
    });
  }
}
