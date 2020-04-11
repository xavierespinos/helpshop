import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List data;
String documentID;

class ViewHelp extends StatefulWidget {
  ViewHelp(List helpData, String document){
    data = helpData;
    documentID = document;
  }
  @override
  _ViewHelpState createState() => _ViewHelpState();
}

class _ViewHelpState extends State<ViewHelp> {
  final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            data[7].toString() + " necesita la teva ajuda:",
            style: TextStyle(fontSize: 20),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  style: TextStyle(fontSize: 18, color: Colors.orange),
                  text: "Data d'entrega: ",
                ),
                TextSpan(
                  style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                  text: data[0].toString().split(" ")[0] + " " + data[4].toString(),

                ),

              ]
            ),
          ),
          RichText(
            text: TextSpan(
                children: [
                  TextSpan(
                    style: TextStyle(fontSize: 18, color: Colors.orange),
                    text: "Productes: ",
                  ),
                  TextSpan(
                    style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                    text: data[6].toString(),

                  ),
                ]
            ),
          ),

          ButtonTheme(

            child: RaisedButton(
              color: Colors.orange[800],
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(
                    15.0),
              ),
              onPressed: acceptHelp,
              child: Text(
                "Ajudar",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],

      ),

    );
  }

  void acceptHelp() async{
    final FirebaseUser userInf = await FirebaseAuth.instance.currentUser();
    final uid = userInf.uid;
    await databaseReference
        .collection("markers")
        .document(documentID).updateData({"helper" : uid});
    Navigator.pop(context);
    print(data);
    
    await databaseReference.collection("helpingMarks").document(uid).collection("help").document()
    .setData({
      "date" : data[0].toString(),
      "hour" : data[4].toString(),
      "name" : data[7].toString(),
      "street" : data[5].toString(),
      "items" : data[6],
    });
  }
}
