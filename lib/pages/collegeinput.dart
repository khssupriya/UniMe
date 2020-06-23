import 'package:flutter/material.dart';
import 'package:unime3/pages/home.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class CollegeInput extends StatefulWidget {
  @override
  _CollegeInputState createState() => _CollegeInputState();
}


class _CollegeInputState extends State<CollegeInput> {

  String dropdownValue = 'My College', college;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 100,),
             // Text('Choose your college', style: TextStyle(color: Colors.white, fontSize: 20,),),
              DropdownButton(
                value: dropdownValue,
                dropdownColor: Colors.black87,
                iconSize: 30,
                items: <String>['My College','VNR VJIET', 'IIT D', 'KIIT', 'JNTUH', 'IIT K']
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child:Text(value, style: TextStyle(fontSize: 18,color: Colors.white,),),
                );
                }).toList(),
                onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                  college = newValue;
                  print(college);
                }              
                );
              },
              ),
              FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(myCollege: college,)));
                },
                child: Text('Lets Go', style: TextStyle(color: Colors.white),),
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}