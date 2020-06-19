import 'package:flutter/material.dart';

class Each extends StatefulWidget {
  Each({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EachState createState() => _EachState();
}

class _EachState extends State<Each> {
  @override
  Widget build(BuildContext context) {
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
              'Mummies for Dummies',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0,) ,
            Text(
              'Hey there, IIT Kaulalampur is here again with an other exclusive competitive coding contest.. Hope into the journey and code along absjfbs fsgnds gdhdlghkgdn.',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Text(
              'this is the additional info i would add to fill the page.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0,) ,
            Row(
              children: <Widget>[
                Text(
                  'Date:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.0,) ,
                Text(
                  '12-12-12',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Spacer(),
                FlatButton(
                  onPressed: (){},
                  child: Text(
                    'Add to Calendar',
                    style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
          SizedBox(height: 20,),
          Center(
            child: FlatButton(
              color:Colors.red,
              onPressed: (){},
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
                '1234567809',
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
                'dummy@mummy.com',
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