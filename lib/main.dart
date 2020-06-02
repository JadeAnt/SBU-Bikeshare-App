import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:bikeshare_functionality/BikeLocation.dart';
import 'PassGen.dart';
import 'BikeLocation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
//import 'package:location/location.dart';
import 'login_page.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override

  static BikeLocation WestApartmentsI= new BikeLocation('West Apartments I', 40.913378, -73.134329);
  static BikeLocation WestApartmentsC = new BikeLocation('West Apartments C',40.911754, -73.132887);
  static BikeLocation Tabler = new BikeLocation('Tabler',40.910053, -73.124887);
  static BikeLocation LifeSciences2 = new BikeLocation('Life Sciences 2',40.911422, -73.120797);
  static BikeLocation Javits = new BikeLocation('Javits',40.913432, -73.121416);
  static BikeLocation WangCenter = new BikeLocation('Wang Center',40.916524, -73.118169);
  static BikeLocation JamesCollege = new BikeLocation('James College',40.919247, -73.120864);
  static BikeLocation SAC = new BikeLocation('SAC',40.914429, -73.124660);
  static BikeLocation Library = new BikeLocation('Library',40.916137, -73.123461);
  static BikeLocation AthleticFields = new BikeLocation('Athletic Fields',40.921469, -73.126406);
  static BikeLocation LIRR = new BikeLocation('LIRR',40.920082, -73.128242);
  static BikeLocation SouthPlot = new BikeLocation('South P Lot',40.896510, -73.126509);

  static List<BikeLocation> allBikeLocations = [WestApartmentsI, WestApartmentsC, Tabler, LifeSciences2, Javits, WangCenter, JamesCollege, SAC, Library, AthleticFields, LIRR, SouthPlot];

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
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
  BitmapDescriptor custom_user_location_icon = null;

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
  create_user_location_marker(context) { // function to create a custom marker for the user's location
    if (custom_user_location_icon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/blue_dot_resize_3.png')
          .then((icon) {
        setState(() {
          custom_user_location_icon = icon;
        });
      });
    }
  }
  GoogleMapController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Timer.periodic(Duration(seconds: 1), (Timer t) => setState((){
      getLocation(); // this updates the user's location periodically (every second)
    }));

  }

  void createBikeMarkers(){
    MyApp.allBikeLocations.every((item) {
          BikeMarker(item, item.name);
          return true;
    });
  }

  Widget BikeMarker(BikeLocation location, String name){
    allMarkers.add(Marker(
        markerId: MarkerId(name),
        draggable: false,
        onTap: () {
          print('Marker Tapped');
          this.moveToLocation(location.latitude, location.longitude, name);
        },
        position: LatLng(location.latitude, location.longitude),
        icon: customIcon
    ));
    
  }

  Widget sideDrawer(){
    return Drawer(
      child: ListView(
        padding:EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader( 
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/Sbu_logo.png'),
              ),
              color: Colors.white12,
            ),
          ),
          
          ListTile(
            title: Text('Account'), 
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
            leading: Icon(Icons.account_circle),
          ),
          
          ListTile(
            title: Text('Navigation'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
            leading: Icon(Icons.navigation),
          ),

          ListTile(
            title: Text('Settings'),
            
            leading: Icon(Icons.settings),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),

            ListTile(
            title: Text('Logout'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
            leading: Icon(Icons.exit_to_app),
          ),

        ],

      ),

    );
  }

  Widget _appBar(){
    return AppBar(
        centerTitle: true,
        title: Text('SBU Bikeshare'),
        backgroundColor: Colors.red[900],
        actions: <Widget>[
          new Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            child: Image.asset('assets/wolfie.png'),
          )
        ],
      );
  }

  Widget mapContainer(){
    return Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(40.912392, -73.123392), zoom: 16.0),
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
            ),
          ),
        ]
      );
  }

  Widget floatingButtons(){
    return Stack(
        children: <Widget>[
          
          Align(
            alignment: Alignment.bottomRight,
            child:Padding(
              padding: EdgeInsets.only(bottom: 70),
              child: FloatingActionButton(
                onPressed: (){move_to_current_loc();},
                backgroundColor: Colors.red[900],
                child: Icon(Icons.my_location, color: Colors.white),
                heroTag: null,
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: (){passCodeBottomSheet();},
              child: Icon(Icons.lock_open), 
              backgroundColor: Colors.red[900],
              heroTag: null,
            )
          ),
        ],
      );
  }


  @override
  Widget build(BuildContext context) {
    getLocation();
    createMarker(context);
    create_user_location_marker(context);
    // ---------------------------------- Markers ------------------------------
    createBikeMarkers();
    //-------------------------- END OF MARKERS --------------------------------

    return Scaffold(
      appBar: _appBar(),

      drawer: sideDrawer(),

      body: mapContainer(),

      floatingActionButton: floatingButtons(),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  Future move_to_current_loc() async{
    getLocation();
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      //CameraPosition(target: LatLng(40.912392, -73.123392), zoom: 12.0),
      CameraPosition(target: LatLng(_currentPosition.latitude, _currentPosition.longitude),zoom: 18.0),

    ));
  }

  getLocation() async{
    Position position = await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    try{
      setState(() {
        _currentPosition = position;
        final marker = Marker(
          markerId: MarkerId("curr_loc"),
          position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          infoWindow: InfoWindow(title: 'Your Location'),
          icon: custom_user_location_icon
        );
        allMarkers.add(marker);
      });
    }catch(e) {
      print(e);
    }

  }
  
  passCodeBottomSheet(){
    showModalBottomSheet(context: context, builder: (builder){
       return Ink(
          height: MediaQuery.of(context).size.height*0.45,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red[900],
              title: Text("Unlock A Bike",
              style: TextStyle(
                fontSize: 24
              )),
              centerTitle: true,
            ),

            body: Container(
              color: Colors.white,
              child: Padding(padding: EdgeInsets.all(30.0),child: PassGen()),
            ),
          ),
        );
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
            color: Colors.white,
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
                            onPressed: (){passCodeBottomSheet();},

                            child: new Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: new Icon(
                                Icons.lock_open,
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
                ),


              ],
            ),
          )
          )
        );
    });
  }
}
