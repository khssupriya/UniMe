import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Each extends StatefulWidget {
  Each({Key key, this.title, this.documentSnapshot}) : super(key: key);

  final String title;
  final DocumentSnapshot documentSnapshot;

  @override
  _EachState createState() => _EachState(documentSnapshot: documentSnapshot,);
}

class _EachState extends State<Each> {

  _EachState({this.documentSnapshot});

  final DocumentSnapshot documentSnapshot;  

  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body:
      SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            SizedBox(height: 20.0,),
            Text(
              this.documentSnapshot['Title'],
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,) ,
            Text(
              this.documentSnapshot['Short Description'],
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0,) ,
            Row(
              children: <Widget>[
                Text(
                  'Date & Time:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0,) ,
                Text(
                  this.documentSnapshot['Date'],
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: (){
                    Add2Calendar.addEvent2Cal(
                      Event(
                        title: documentSnapshot['Title'],
                        description: documentSnapshot['Short Description'],
                        location: 'uni.me app',
                        startDate: DateFormat('dd-MM-yyy HH:mm').parse(documentSnapshot['Date']),
                        endDate: DateFormat('dd-MM-yyy HH:mm').parse(documentSnapshot['Date']).add(Duration(days: 1)),
                        allDay: false,
                      ),
                    ).then((success) {
                      scaffoldState.currentState.showSnackBar(
                      SnackBar(content: Text(success ? 'Success' : 'Error')));
                    });
                  },
                  icon: Icon(
                    Icons.calendar_today,
                    size: 20,
                  ),
                ),
              ],
            ),
          SizedBox(height: 20,),
          Center(
            child: FlatButton(
              color:Colors.red,
              onPressed: () async {
              const url = 'https://flutter.io';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
              child: Text(
                'Register now',
                style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Text(
            'Contact Us',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
          ),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              RawMaterialButton(
                onPressed: (){},
                fillColor: Colors.blue,
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
                child: Icon(
                Icons.phone,
                size: 20.0,  
                color: Colors.white,          
                ),
              ),
              SizedBox(width: 2.0,) ,
              Text(
                this.documentSnapshot['Phone Number'],
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
           SizedBox(height: 10,),
          Row(
            children: <Widget>[
              RawMaterialButton(
                onPressed: (){},
                fillColor: Colors.blue,
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
                child: Icon(
                Icons.email,
                size: 20.0,  
                color: Colors.white,          
                ),
              ),
              SizedBox(width: 2.0,) ,
              Text(
                this.documentSnapshot['Email Address'],
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ],
    ),
        ),
      ),
    );
  }
}