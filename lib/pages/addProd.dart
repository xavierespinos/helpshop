import 'package:flutter/material.dart';
import 'package:hackovid/pages/addItem.dart';

List _items = new List();

class AddProd extends StatefulWidget {
  List data;

  AddProd({Key key, @required this.data}) : super(key: key);
  @override
  _AddProdState createState() => _AddProdState();
}

class _AddProdState extends State<AddProd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List _data;
  double screenHeight;

  @override
  void initState() {
    _items.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _data = widget.data;



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
            mainAxisSize: MainAxisSize.min,
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
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: screenHeight/25,),
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(),
                              ),
                              Text("PRODUCTES", style: TextStyle(
                                  color: Colors.grey, fontSize: 40),
                              ),
                              Padding(padding: EdgeInsets.all(5),
                              ),
                              ],
                          ),
                        ),

                        Container(
                          height: screenHeight/2,
                          child: ListView.builder(
                              itemCount: _items.length,
                              itemBuilder: (context, index){
                                return Card(
                                    child: ListTile(
                                      title: Text(_items[index]),
                                    )
                                );
                              }
                          ),
                        ),




                        Expanded(
                          child: Column(
                            children: <Widget>[

                              Align(
                                alignment: Alignment.bottomCenter,
                                child: FloatingActionButton(
                                  onPressed: (){
                                    addItem(context);
                                  },
                                  backgroundColor: Colors.orange,
                                  child: Icon(Icons.add),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ButtonTheme(
                                  minWidth: 150.0,
                                  height: 40,
                                  child: RaisedButton(
                                    color: Colors.orange[800],
                                    onPressed: publish,
                                    child: Text(
                                      "AFEGIR", style: TextStyle(
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


  void publish() {
    Navigator.pop(context, _items);

  }

  void addItem(BuildContext context) async {

    final item = await showDialog(context: context,
      builder: (BuildContext context){
        return Dialog(
          child: AddItem(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))
          ),
        );
      }
    );

    _items.add(item);
  }


}
