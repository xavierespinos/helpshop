import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackovid/pages/home.dart';
import 'package:hackovid/pages/signup.dart';

class LoginPage extends StatefulWidget{
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80,),

                Padding(
                  padding: EdgeInsets.all(5),
                  child: Image(
                    image: AssetImage("assets/logoApp.png"),
                  ),

                ),
                SizedBox(height: 70 ,),
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
                          SizedBox(height: 65,),
                          Container(
                            //padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10)
                                )]
                            ),
                            child: Column(

                              children: <Widget>[
                                TextFormField(
                                  // ignore: missing_return
                                  //validator: (input){
                                  //if(input.isEmpty) return "Perfavor introdueix un email";
                                  //},
                                  onSaved: (input) => _email = input,
                                  decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(10.0),
                                      labelStyle: TextStyle(
                                          color: Colors.orange
                                      ),
                                      labelText: "Email"

                                  ),
                                ),


                                TextFormField(
                                  // ignore: missing_return
                                  validator: (input){
                                    if(input.length < 6) return "Perfavor introdueix una contrassenya valida";
                                  },
                                  onSaved: (input) => _password = input,
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      hoverColor: Colors.orange,
                                    contentPadding: const EdgeInsets.all(10.0),
                                      labelStyle: TextStyle(
                                        color: Colors.orange
                                      ),
                                      labelText: "Contrassenya",

                                  ),
                                  obscureText: true,
                                ),

                              ],

                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: <Widget>[
                                ButtonTheme(
                                    minWidth: 140.0,
                                    height: 40,
                                    child: RaisedButton(
                                      color: Colors.orange[800],
                                      onPressed: login,
                                      child: Text("Login",
                                        style: TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(18.0),

                                      ),
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),


                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text("Encara no tens un compte?", style: TextStyle(color: Colors.grey[700], fontSize: 14),),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                    ),
                                    ButtonTheme(
                                        minWidth: 80.0,
                                        child: RaisedButton(
                                          color: Colors.orange[800],
                                          onPressed: signup,
                                          child: Text("Registra't"),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(18.0),

                                          ),
                                        )
                                    ),
                                  ],
                                ),



                              ],




                            ),


                          ),
                        ],
                      ),

                    ),

                  ),

                )
              ],
            ),

          ),
        )

    );
  }



  Future <void> login() async{

    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try {
        AuthResult user =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      }
      catch(e){
        print(e.message);
      }

    }
  }



  void signup() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }
}