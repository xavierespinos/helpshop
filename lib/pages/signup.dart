import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'homeMap.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final databaseReference = FirebaseDatabase.instance.reference();
  String _usrNme, _mail, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 80,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                      SizedBox(height: 55,),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(),
                            ),
                            Text("Registra't", style: TextStyle(color: Colors.grey, fontSize: 40),),
                            Padding(padding: EdgeInsets.all(30),),
                            Container(
                              child: TextFormField(
                                onSaved: (input) => _usrNme = input,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.orange,
                                  ),
                                  labelText: "NOM",

                                ),
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                onSaved: (input) => _mail = input,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.orange,
                                  ),
                                  labelText: "EMAIL",
                                ),
                              ),
                            ),
                            Container(
                              child: TextFormField(
                                onSaved: (input) => _password = input,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.orange,
                                  ),
                                  labelText: "CONTRASSENYA",
                                ),
                                obscureText: true,
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(30),
                              child: Column(
                                children: <Widget>[
                                  ButtonTheme(
                                    minWidth: 150.0,
                                    height: 40,
                                    child: RaisedButton(
                                      color: Colors.orange[800],
                                      onPressed: signup,
                                      child: Text("Registra't", style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey[900]
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(18.0),
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

  void signup() async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
    }
    try{
      AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _mail, password: _password);
      final FirebaseUser userInf = await FirebaseAuth.instance.currentUser();
      final uid = userInf.uid;
      databaseReference.child(uid).set({
        'userName' : _usrNme,
      });
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeMap()));
    }catch(e){
      print(e.message);
    }

  }
}
