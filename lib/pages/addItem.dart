import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String _item;
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Afegir nou item a la cistella",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          TextFormField(
            onChanged: (input) => _item = input,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              labelStyle: TextStyle(
                color: Colors.orange,
              ),
              labelText: "Producte",
              hintText: "3 Llet desnatada",
            ),

          ),
          ButtonTheme(

            child: RaisedButton(
              color: Colors.orange[800],
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(
                    15.0),
              ),
              onPressed: addItem,
              child: Text(
                "Afegeix",
              ),
            ),
          ),


        ],
      ),
    );
  }

  void addItem() {
    Navigator.pop(context, _item);
  }
}
