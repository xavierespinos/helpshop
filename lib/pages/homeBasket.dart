import 'package:flutter/material.dart';

import 'homeMap.dart';

class HomeBasket extends StatefulWidget {
  @override
  _HomeStateBasket createState() => _HomeStateBasket();
}

class _HomeStateBasket extends State<HomeBasket> {
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

        ],
      ),
    );
  }

  void goMap() {
    Navigator.of(context).pop();
    //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeMap()));
  }
}
