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
  double screenHeight;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child:Column(

            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                            style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold),
                            text: data[7].toString(),
                          ),
                          TextSpan(
                            style: TextStyle(fontSize: 20, color: Colors.grey[800]),
                            text: " necessita la teva ajuda:",

                          ),

                        ]
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 5),
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
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                            style: TextStyle(fontSize: 18, color: Colors.orange),
                            text: "Productes: ",
                          ),

                        ]
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),


                  Container(
                    height: screenHeight/3,
                    child: ListView.builder(
                        itemCount: data[6].length,
                        itemBuilder: (context, index){
                          return Card(
                              child: ListTile(
                                title: Text(data[6][index]),
                              )
                          );
                        }
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),


                ],
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
