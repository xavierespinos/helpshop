import 'package:flutter/material.dart';
import 'package:hackovid/pages/homeBasket.dart';

List data;

class ViewBasketHelping extends StatefulWidget {
  ViewBasketHelping(List helping){
    data = helping;
  }


  @override
  _ViewBasketHelpingState createState() => _ViewBasketHelpingState();
}

class _ViewBasketHelpingState extends State<ViewBasketHelping> {
  double screenHeight;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold),
                        text: data[3].toString(),
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
                        style: TextStyle(fontSize: 18, color: Colors.orange, fontWeight: FontWeight.bold),
                        text: "Data d'entrega: ",
                      ),
                      TextSpan(
                        style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                        text: data[0].toString().split(" ")[0] + " " + data[1].toString(),

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
                        style: TextStyle(fontSize: 18, color: Colors.orange, fontWeight: FontWeight.bold),
                        text: "Carrer: ",
                      ),
                      TextSpan(
                        style: TextStyle(fontSize: 18, color: Colors.grey[800]),
                        text: data[2].toString(),

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
                        style: TextStyle(fontSize: 18, color: Colors.orange, fontWeight: FontWeight.bold),
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
                    itemCount: data[4].length,
                    itemBuilder: (context, index){
                      return Card(
                          child: ListTile(
                            title: Text(data[4][index]),
                          )
                      );
                    }
                ),
              ),



              Padding(
                padding: EdgeInsets.only(top: 5),
              ),

            ]
        ),
    );
  }
}
