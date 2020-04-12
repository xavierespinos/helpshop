import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackovid/pages/ViewBasketHelping.dart';
import 'package:hackovid/setup/signIn.dart';

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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
            Padding(padding: EdgeInsets.all(10)),
            Icon(Icons.account_circle, size: 100, color: Colors.orange[800],),
            Padding(padding: EdgeInsets.only(bottom: screenHeight/1.5)),
            FlatButton(
              onPressed: _signOut,
              child: Icon(
                Icons.exit_to_app,
                size: 40,
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
          Padding(padding: EdgeInsets.all(5),),
          Text("Ajudant", style: TextStyle(fontSize: 22, color: Colors.orange[800], fontWeight: FontWeight.bold)),
          Padding(padding: EdgeInsets.all(5),),

          Container(
            height: screenHeight/4,
            child: ListView.builder(
                itemCount: helping.length,
                itemBuilder: (context, index){
                  return Card(
                      child: ListTile(
                        onTap: (){tapHelping(helping[index]);},
                        title: Text(helping[index][2]),
                        subtitle: Text("Data entrega: " + helping[index][0].split(" ")[0]),
                      )
                  );
                }
            ),
          ),
          Padding(padding: EdgeInsets.all(5),),
          Text("Ajuda Demanada",  style: TextStyle(fontSize: 22, color: Colors.orange[800], fontWeight: FontWeight.bold)),
          Padding(padding: EdgeInsets.all(5),),
          Container(
            height: screenHeight/4,
            child: ListView.builder(
                itemCount: helper.length,
                itemBuilder: (context, index){
                  return Card(
                      child: ListTile(
                        onTap: tapHelp,
                        title: Text(helper[index][2]),
                        subtitle: Text("Data entrega: " + helping[index][0].split(" ")[0]),

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




    _signOut() async {
    await _firebaseAuth.signOut();
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

  }

  void tapHelping(List helping) async{
    await showDialog(context: context,
        builder: (BuildContext context){
          return Dialog(
            child: ViewBasketHelping(helping),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))
            ),
          );
        }
    );
  }

  void tapHelp() {
  }
}
