import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddUbi extends StatefulWidget {
  @override
  _AddUbiState createState() => _AddUbiState();
}

class _AddUbiState extends State<AddUbi> {
  GoogleMapController mapController;
  String searchAddress;
  Set<Marker> markers = new Set();
  bool mapToggle = false;
  var currentLocation;

  void initState(){
    super.initState();
    Geolocator().getCurrentPosition().then((currLoc){
      setState(() {
        currentLocation = currLoc;
        mapToggle = true;

      });
    });


  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          mapToggle ? GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(41.088, 0.639),
              zoom: 16,
            ),
            markers: markers,

          ) : Center(child: Text(
              "Carregant ubicació..."
          ),),
          Positioned(
            top: 40,
            right: 15,
            left: 15,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Introdueix l'adreça",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, top: 15),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: searchNavigate,
                      iconSize: 30,
                    )
                ),
                onChanged: (val) {
                  setState(() {
                    searchAddress = val;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width/2 - 70,
            child: ButtonTheme(
              minWidth: 140.0,
              child: RaisedButton(
                onPressed: addPoint,
                color: Colors.orange[800],
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
                child: Text(
                  "Afegir", style: TextStyle(fontSize: 19),
                ),
              ),
            ),

          ),

        ],
      ),
    );

  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  void searchNavigate() {
    Position pos;
    Geolocator().placemarkFromAddress(searchAddress).then((result){
      pos = result[0].position;
      setState(() {
        markers.clear();
        markers.add(Marker(
          markerId: MarkerId("marker"),
          draggable: false,
          position: LatLng(pos.latitude, pos.longitude),
        ));
      });

      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: 19,
        )

      ));
    });

    
  }

  void addPoint() {
    double lat = markers.first.position.latitude;
    double long = markers.first.position.longitude;
    List<double> pos = new List();
    pos.add(lat);
    pos.add(long);
    Navigator.pop(context, pos);
  }
}
