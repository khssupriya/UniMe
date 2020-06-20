import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unime3/pages/each.dart';

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
      StreamBuilder(
        stream: Firestore.instance.collection('events').snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Expanded(
                          child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index){
                  DocumentSnapshot documentSnapshot = snapshot.data.documents[index];
                  return Card(
                    child: Padding (
                      padding: EdgeInsets.all(20.0),
                      child:Column(
                      children: <Widget>[
                        Text(
                          documentSnapshot['Title'],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0,) ,
                        Text(
                          documentSnapshot['Short Description'],
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
                              documentSnapshot['Date'],
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Spacer(),
                            FlatButton(
                              onPressed: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => Each(title: widget.title, documentSnapshot: documentSnapshot,)));
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
                  );
                }
                ),
            );
          }
        },
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
