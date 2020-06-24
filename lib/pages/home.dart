import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unime3/pages/each.dart';
import 'dart:math';
import 'package:intl/intl.dart';
//import 'package:flutter_icons/flutter_icons.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.myCollege}) : super(key: key);

  final String myCollege;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String category, myCollege;

class _MyHomePageState extends State<MyHomePage> {

  Set colleges = new  Set();

  Future<void> loadData(){
    colleges.add('college');
    Firestore.instance.collection('events').getDocuments().then((querySnapshot){
      querySnapshot.documents.forEach((result){
        Firestore.instance.collection('events').document(result.documentID).get().then((value){
          colleges.add(value.data['College Name']);
          print(colleges);
          setState(() {
            
          });
        });
      });
    });
    return null;
  }

  _MyHomePageState(){
    loadData();
  }
  
  final catergories = {'dance','sports','code','music','literature'};
  String dropdownValue = 'category';
  String dropdownValueclg = 'college';
  final catIcons = {'dance':Icons.face,'sports':Icons.gamepad,'code':Icons.code,'music':Icons.music_note,'literature':Icons.book,'category':Icons.category};
  final catColors = {'dance':Colors.amber,'sports':Colors.pinkAccent,'code':Colors.green,'music':Colors.redAccent,'literature':Colors.teal,'category':Colors.orangeAccent};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Colors.black87,
      title:Image(image: AssetImage('assests/title.png'), width: 100,),
    ),
    body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.black,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton( 
                  value: dropdownValueclg,
                  dropdownColor: Colors.black87,
                  iconSize: 30,
                  items: colleges
                  .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child:Text(value.substring(0,min(value.toString().length,15)),
                            style: TextStyle(fontSize: 18,color: Colors.white,),
                          ),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                  setState(() {
                    dropdownValueclg = newValue;
                    myCollege = newValue;
                    print(myCollege);
                  }              
                  );
                },
                ),
                DropdownButton(
              value: dropdownValue,
              dropdownColor: Colors.black87,
              iconSize: 30,
              items: <String>['category','dance','sports','code','music','literature']
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: <Widget>[
                      Icon(catIcons[value],color: catColors[value],),
                      SizedBox(width: 5,),
                      Text(value,
                        style: TextStyle(fontSize: 18,color: Colors.white,),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
                category = newValue;
                print(category);
              }              
              );
          },
          ),
              ],
          ),
            ),
    StreamBuilder(
      initialData: null,
      stream:(('category' != category && 'college'!= myCollege)?
      (Firestore.instance.collection('events').where('Category', isEqualTo:category).where('College Name', isEqualTo:myCollege).
      orderBy('_timeStampUTC', descending: true).snapshots()):
      (('category' != category )?(Firestore.instance.collection('events').where('Category', isEqualTo:category).
      orderBy('_timeStampUTC', descending: true).snapshots()):
      (('college' != myCollege )?(Firestore.instance.collection('events').where('College Name', isEqualTo:myCollege).
      orderBy('_timeStampUTC', descending: true).snapshots()):
      ((Firestore.instance.collection('events').orderBy('_timeStampUTC', descending: true).snapshots()))))),
      builder: (context, snapshot){
        AsyncSnapshot <dynamic> temp = snapshot;
        if(snapshot.hasData){
          if(snapshot == null)setState(() { });
          return Expanded(
                        child: ListView.builder(
              shrinkWrap: true,
              itemCount: temp.data.documents.length,
              itemBuilder: (context, index){
                DocumentSnapshot documentSnapshot = temp.data.documents[index];
                snapshot = null;
                if(documentSnapshot['Date'].toDate().compareTo(documentSnapshot['DeleteDate'].toDate()) <= 0)Firestore.instance.collection('events').document(documentSnapshot.documentID).delete();
                return Card(
                  //color: Colors.black26,
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
                                    'Date: ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Text(
                                    DateFormat("dd-MM-yyy HH:mm").format(documentSnapshot['Date'].toDate()).substring(0,16).substring(0,10),
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
                                    'College: ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
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
                             Navigator.push(context, MaterialPageRoute(builder: (context) => Each(documentSnapshot: documentSnapshot,)));
                            },
                            child: Text('Know More',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            color: Colors.orangeAccent, 
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
        else{snapshot=null;print("im here");return Center(child: Text('Sorry! nothings here'),);}
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
      backgroundColor: Colors.redAccent
    ),
    );
  }
}
