import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hackovid/pages/askForm.dart';
import 'package:hackovid/pages/homeBasket.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackovid/pages/viewHelp.dart';
import 'package:hackovid/setup/signIn.dart';


class HomeMap extends StatefulWidget {
  @override
  _HomeStateMap createState() => _HomeStateMap();
}

class _HomeStateMap extends State<HomeMap> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Set<Marker> markers = new Set();
  List helpData;
  String uid;
  bool mapToggle = false;
  GoogleMapController mapController;
  var currentLocation;
  final databaseReference = Firestore.instance;

  void initState(){
    markers.clear();
    getMarkers();
    getHelping();
    getHelps();
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
    getMarkers();
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
                        target: LatLng(41.0879, 0.639),
                        zoom: 16.0,
                      ),
                      markers: getMarkers(),

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
      getMarkers();
      mapController = controller;
    });
  }

  void goBasket() {
    //getHelper();
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

  Set<Marker> getMarkers() {
    databaseReference
        .collection("markers")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((d) {
        List mark = d.data.values.toList();
        markers.add(Marker(
          markerId: MarkerId(d.documentID),
          draggable: false,
          position: LatLng(mark[1], mark[2]),
          onTap: (){
            onTapMarker(d.documentID);
          },
        ));
      });
    });
    return markers;
  }

  onTapMarker(String documentID)async{
    getHelpData(documentID);
    tapMarker(helpData, documentID);
  }

  void tapMarker(List helpData, String documentID) async{
    await showDialog(context: context,
        builder: (BuildContext context){
          return Dialog(
            child: ViewHelp(helpData, documentID),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))
            ),
          );
        }
    );
  }

  Future getHelpData(String documentID) async {
    await databaseReference
        .collection("markers")
        .document(documentID).get().then<dynamic>((DocumentSnapshot snapshot) async{
          helpData = snapshot.data.values.toList();

    });


  }

  Future getHelping() async {
    final FirebaseUser userInf = await FirebaseAuth.instance.currentUser();
    uid = userInf.uid;
    await databaseReference.collection("helpingMarks").document(uid).collection(
        "help").getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((d) {
        helping.add(d.data.values.toList());
      });
    });
    print(helping);
  }

  Future getHelps() async {
    final FirebaseUser userInf = await FirebaseAuth.instance.currentUser();
    uid = userInf.uid;
    await databaseReference.collection("helpMarks").document(uid).collection(
        "help").getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((d) {
        helper.add(d.data.values.toList());
      });
    });
  }
}
