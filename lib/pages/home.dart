import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Padding (
                padding: EdgeInsets.all(20.0),
                child:Column(
                children: <Widget>[
                  Text(
                    'Mummies for Dummies',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0,) ,
                  Text(
                    'Hey there, IIT Kaulalampur is here again with an other exclusive competitive coding contest.. Hope into the journey and code along absjfbs fsgnds gdhdlghkgdn.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 10.0,) ,
                  Row(
                    children: <Widget>[
                      Text(
                        'Date:',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '12-12-12',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Spacer(),
                      FlatButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/each');
                        },
                        child: Text('Know More',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        color: Colors.blue, 
                      ),
                    ],
                  ),
                ],
              ),

              ),
            ),
            Card(
              child:Column(
                children: <Widget>[
                  Text(
                    'I am a third post apparently',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/post');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
