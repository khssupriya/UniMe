import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unime3/pages/each.dart';
import 'dart:math';
//import 'package:flutter_icons/flutter_icons.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String category;

class _MyHomePageState extends State<MyHomePage> {

  final catergories = {'dance','sports','code','music','literature'};
  String dropdownValue = 'category';
  final catIcons = {'dance':Icons.face,'sports':Icons.gamepad,'code':Icons.code,'music':Icons.music_note,'literature':Icons.book,'category':Icons.category};
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget> [
            Text('uni.me'),
            Spacer(),
            DropdownButton(
              value: dropdownValue,
              iconSize: 30,
              items: <String>['dance','sports','code','music','literature','category']
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: <Widget>[
                      Icon(catIcons[value]),
                      SizedBox(width: 5,),
                      Text(value,
                        style: TextStyle(fontSize: 18,color: Colors.black54,),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
                category = newValue;
              }              
              );
            },
            ),
          ],
        ),
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
      StreamBuilder(
        stream: ('category' != category)?Firestore.instance.collection('events').where('Category', isEqualTo:category).orderBy('_timeStampUTC', descending: true).snapshots():Firestore.instance.collection('events').orderBy('_timeStampUTC', descending: true).snapshots(),
        builder: (context, snapshot){
          //if(snapshot.hasData){
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
                          documentSnapshot['Short Description'].substring(0,min(documentSnapshot['Short Description'].toString().length, 200)) + '...',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 10.0,) ,
                        Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
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
                                      documentSnapshot['Date'].substring(0,10),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],                                  
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Collge:',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      documentSnapshot['College Name'],
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],                                  
                                ),
                              ],

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
          // }
          // else return Center(child: Text('Sorry! nothings here'),);
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
