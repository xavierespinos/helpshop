import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hackovid/pages/askForm.dart';
import 'package:hackovid/pages/homeBasket.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackovid/setup/signIn.dart';


class HomeMap extends StatefulWidget {
  @override
  _HomeStateMap createState() => _HomeStateMap();
}

class _HomeStateMap extends State<HomeMap> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _screenState = "map";
  bool mapToggle = false;
  GoogleMapController mapController;
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
      appBar: AppBar(
        title: Text("HELPSHOP"),
        backgroundColor: Colors.orange[800],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            FlatButton(
              onPressed: _signOut,
              child: Icon(
                Icons.exit_to_app,
                size: 30,
              ),
            ),

          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.orange[800],
            ),
            child: Row(
              children: <Widget>[
                ButtonTheme(
                  minWidth: (MediaQuery.of(context).size.width)/2,
                  child: FlatButton(
                    child: Icon(
                      Icons.map,
                      color: Colors.black,
                      size: 30,
                    ),

                  ),
                ),
                ButtonTheme(
                  minWidth: (MediaQuery.of(context).size.width)/2,
                  child: FlatButton(
                    child: Icon(
                      Icons.shopping_basket,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: goBasket,
                  ),
                )
              ],
            ),
          ),

          Stack(
            children: <Widget>[

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 128,
                child: mapToggle ?
                    GoogleMap(
                      onMapCreated: onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(currentLocation.latitude, currentLocation.longitude),
                        zoom: 15.0,
                      ),

                    ):
                    Center(child: Text(
                      "Carregant ubicació..."
                    ),)
              ),

              Positioned(
                bottom: 40,
                left: MediaQuery.of(context).size.width/2 - 90,

                child:Center(
                  child: ButtonTheme(
                    minWidth: 180.0,
                    height: 50,
                    child: RaisedButton(
                      onPressed: addShop,
                      color: Colors.orange[800],
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: Colors.white,
                        size: 35,

                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              )

            ],

          ),

        ],
      ),
    );
  }

  void onMapCreated(controller){
    setState(() {
      mapController = controller;
    });
  }

  void goBasket() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeBasket()));
  }

  _signOut() async {
    await _firebaseAuth.signOut();
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

  }

  void addShop() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AskShop()));
  }
}
