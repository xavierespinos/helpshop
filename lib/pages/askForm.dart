import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackovid/classes/Data.dart';
import 'package:hackovid/pages/addProd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addUbi.dart';

class AskShop extends StatefulWidget {
  @override
  _AskShopState createState() => _AskShopState();
}

class _AskShopState extends State<AskShop> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  List<double> pos = new List();
  List listItems = new List();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final databaseReference = Firestore.instance;
  DateTime dateTime;
  TimeOfDay dateHour;
  Data data = new Data();
  String _name, _street;

  List _data = new List();
  double screenHeight;
  double screenWidth;
  @override
  Widget build(BuildContext context) {

  screenHeight = MediaQuery.of(context).size.height;
  screenWidth =  MediaQuery.of(context).size.width;
  return Scaffold(
    resizeToAvoidBottomPadding: false,
    body: Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange[900],
                  Colors.orange[500],
                  Colors.orange[300],
                ]
            )
        ),
        child: Column(

          children: <Widget>[
            SizedBox(height: screenHeight/13,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenHeight/35),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenHeight/25,),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text("NOVA CISTELLA", style: TextStyle(
                                color: Colors.grey, fontSize: 40),),
                            Padding(padding: EdgeInsets.all(8),),
                            Container(
                              child: TextFormField(
                                onSaved: (input) => _name = input,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.orange),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.orange,
                                  ),
                                  labelText: "NOM",
                                ),
                              ),
                            ),

                            Container(
                              child: TextFormField(
                                onSaved: (input) => _street = input,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.orange),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.orange,
                                  ),
                                  labelText: "CARRER",
                                  hintText: "Direcció exacta d'entrega",
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(screenHeight/50),
                            ),

                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Data d'entrega:",
                                      style: TextStyle(fontSize: 20, color: Colors.orange),
                                    ),
                                    Text(
                                      dateTime == null ? "-" :
                                      dateTime.toString().split(" ")[0],
                                      style: TextStyle(fontSize: 19, color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Hora d'entrega:",
                                      style: TextStyle(fontSize: 20, color: Colors.orange),
                                    ),
                                    Text(
                                      dateHour == null ? "-" :
                                      dateHour.toString(),
                                      style: TextStyle(fontSize: 19, color: Colors.grey[700]),
                                    ),
                                  ],

                                ),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.all(5),
                            ),

                            Row(
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(fontSize: 20, color: Colors.orange),
                                    children: [
                                      TextSpan(text: 'Ubicació afegida: '),
                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                          child: pos.isEmpty ? Icon(Icons.close) : Icon(Icons.check),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.all(5),
                            ),

                            Row(
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(fontSize: 20, color: Colors.orange),
                                    children: [
                                      TextSpan(text: 'Productes afegits: '),
                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                          child: listItems.isEmpty ? Icon(Icons.close) : Icon(Icons.check),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),


                            Padding(
                              padding: EdgeInsets.all(screenHeight/30),
                            ),

                            Container(
                              //padding: EdgeInsets.all(screenHeight/10),
                              child: Column(
                                children: <Widget>[
                                  ButtonTheme(
                                    minWidth: screenWidth/3,
                                    height: 40,
                                    child: RaisedButton(
                                      color: Colors.orange[800],
                                      onPressed: addDate,
                                      child: Text(
                                        "Afegir Data", style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white
                                      ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(
                                            18.0),
                                      ),

                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      ButtonTheme(
                                        minWidth: screenWidth/3,
                                        height: 40,
                                        child: RaisedButton(
                                          color: Colors.orange[800],
                                          onPressed: addUbi,
                                          child: Text(
                                            "Ubicació", style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                          ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(
                                                18.0),
                                          ),

                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: screenWidth/5),
                                      ),
                                      ButtonTheme(
                                        minWidth: screenWidth/3,
                                        height: 40,
                                        child: RaisedButton(
                                          color: Colors.orange[800],
                                          onPressed: addProd,
                                          child: Text(
                                            "Productes", style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white
                                          ),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(
                                                18.0),
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),


                                  Padding(
                                    padding: EdgeInsets.all(10),
                                  ),
                                  ButtonTheme(
                                    minWidth: 150.0,
                                    height: 50,
                                    child: RaisedButton(
                                      color: Colors.orange[800],
                                      onPressed: publish,
                                      child: Text(
                                        "Publicar", style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey[800]
                                      ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(
                                            18.0),
                                      ),

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ),
                    ],

                  ),
                ),

              ),

            ),
          ],
        ),
      ),


    ),

  );
}


  void addProd() async{
    //Navigator.of(context).pop();

    List items = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddProd(data: _data,)));
    setState(() {
      listItems = items;
      print(listItems);
    });

  }

  void addUbi() async{

    List position = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddUbi()));
    setState(() {
      pos = position;
    });
    print(pos);

  }

  void publish() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        data.name = _name;
        data.date = dateTime.toString();
        data.hour = dateHour.toString();
        data.street = _street;
      }catch(e){
        print(e);
      }
    }
    final FirebaseUser userInf = await FirebaseAuth.instance.currentUser();
    final uid = userInf.uid;
    await databaseReference.collection("markers").document().setData({
      "alat" : pos[0],
      "along" : pos[1],
      "user" : uid,
      "helper" : "",
      "date" : data.date,
      "hour" : data.hour,
      "street" : data.street,
      "witems" : listItems,
      "name" : data.name,
    });
    
    await databaseReference.collection("helpMarks").document(uid).collection("help").document().
        setData({
      "date" : data.date,
      "hour" : data.hour,
      "name" : data.name,
      "street" : data.street,
      "items" : data.items,
      "accpeted" : false,
    });

    Navigator.pop(context);
  }


  void addDate() async{
    final DateTime selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2022));
    final TimeOfDay selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    setState(() {
      dateTime = selectedDate;
      dateHour = selectedTime;
    });

}
}
