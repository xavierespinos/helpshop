import 'package:flutter/material.dart';
import 'package:hackovid/pages/addProd.dart';

class AskShop extends StatefulWidget {
  @override
  _AskShopState createState() => _AskShopState();
}

class _AskShopState extends State<AskShop> {
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String _name, _date, _city, _street;
List _data = new List();
double screenHeight;
@override
Widget build(BuildContext context) {
  screenHeight = MediaQuery.of(context).size.height;
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
                            Container(
                              decoration: BoxDecoration(),
                            ),
                            Text("NOVA CISTELLA", style: TextStyle(
                                color: Colors.grey, fontSize: 40),),
                            Padding(padding: EdgeInsets.all(15),),
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
                                onSaved: (input) => _date = input,
                                keyboardType: TextInputType.datetime,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.orange),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.orange,
                                  ),
                                  labelText: "DATA ENTREGA",
                                ),
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                onSaved: (input) => _city = input,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.orange),
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.orange,
                                  ),
                                  labelText: "CIUTAT",
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
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),




                            Container(
                              padding: EdgeInsets.all(screenHeight/30),
                              child: Column(
                                children: <Widget>[
                                  ButtonTheme(
                                    minWidth: 150.0,
                                    height: 40,
                                    child: RaisedButton(
                                      color: Colors.orange[800],
                                      onPressed: addProd,
                                      child: Text(
                                        "Afegir Productes", style: TextStyle(
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


  void addProd() {
    //Navigator.of(context).pop();
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        _data.add(_name);
        _data.add(_date);
        _data.add(_city);
        _data.add(_street);
      }catch(e){
        print(e);
      }
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddProd(data: _data,)));
  }
}
