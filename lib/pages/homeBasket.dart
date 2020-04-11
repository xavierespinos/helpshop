import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homeMap.dart';

List helper = new List();
List helping = new List();

class HomeBasket extends StatefulWidget {
  @override
  _HomeStateBasket createState() => _HomeStateBasket();
}

class _HomeStateBasket extends State<HomeBasket> {
  String uid;
  final databaseReference = Firestore.instance;
  double screenHeight;

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("HELPSHOP"),
        backgroundColor: Colors.orange[800],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[

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
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: goMap,
                  ),
                ),
                ButtonTheme(
                  minWidth: (MediaQuery.of(context).size.width)/2,
                  child: FlatButton(
                    child: Icon(
                      Icons.shopping_basket,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),

          Text("Ajudant", style: TextStyle(fontSize: 22, color: Colors.orange[800])),

          Container(
            height: screenHeight/4,
            child: ListView.builder(
                itemCount: helping.length,
                itemBuilder: (context, index){
                  return Card(
                      child: ListTile(
                        title: Text(helping[index][2]),
                      )
                  );
                }
            ),
          ),

          Text("Ajuda Demanada",  style: TextStyle(fontSize: 22, color: Colors.orange[800])),

          Container(
            height: screenHeight/4,
            child: ListView.builder(
                itemCount: helper.length,
                itemBuilder: (context, index){
                  return Card(
                      child: ListTile(
                        title: Text(helper[index]),

                      )
                  );
                }
            ),
          ),

        ],
      ),
    );
  }

  void goMap() {
    Navigator.of(context).pop();
    //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeMap()));
  }



}
