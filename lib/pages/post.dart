import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
//import 'package:path/path.dart';

class Post extends StatefulWidget {
  Post({Key key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  String title, shortDes;
  String clgName="unknown", link, email, phone, category="college", fee;
  int hasPoster=0;
  DateTime datetm,  deleteDate, utcTimeStamp;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

   File _image;
   Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery,);
      setState(() {
        _image = image;
          print('Image Path $_image');
      });
    }
    Future uploadPic(BuildContext context) async{
      utcTimeStamp = DateTime.now();
      String fileName = DateFormat('yyyy-MM-dd hh:mm').format(utcTimeStamp);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      setState(() {
        this.hasPoster = 1;
        print("Profile Picture uploaded");
      });
    }
    Widget _buildImage(context){
      return Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 180.0,
              child: (_image!=null)?Image.file(_image,fit: BoxFit.fill,):
              Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT93bJ52wkX7uUjX4BTsWdJa1vKA9rRqEznQg&usqp=CAU&auto=format&fit=crop&w=500&q=60",
                fit: BoxFit.fill,
              ),
            ),
            Spacer(),
            FlatButton(
               color: Colors.redAccent,
               child:Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('Upload\n poster',style: TextStyle(color: Colors.white,),),
               ),
               onPressed: () {
                 getImage();
               },
             ),
          ],
        ),
      );
    }

  void createData(){

    Firestore.instance.collection("events").add({
      'Title': this.title,
      'Short Description': (this.shortDes.length>0)?this.shortDes:"The author has not provided any description",
      'College Name': (this.clgName.length>0)?this.clgName:"unknown",
      'Date': this.datetm,
      'Link': this.link,
      'Category': this.category,
      'Email Address': this.email,
      'Phone Number': this.phone,
      '_timeStampUTC': (utcTimeStamp!=null)?utcTimeStamp:DateTime.now(),
      'Fee': this.fee,
      'DeleteDate': this.deleteDate,
      'Has Poster': this.hasPoster,
    }).whenComplete((){
      print("$title created");
    });
  }

  Widget _buildFee(){
    return 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Fee',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        validator: (String val) {
              if(val.isEmpty)return "Fee is required";
              else return null;
        },
        keyboardType: TextInputType.number,
        onSaved: (String val){
          this.fee = val;
        },
      ),
    );
  }

  Widget _buildTitle(){
    return 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Title',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        validator: (String val) {
              if(val.isEmpty)return "Title is required";
              else return null;
        },
        keyboardType: TextInputType.text,
        onSaved: (String val){
          this.title = val;
        },
      ),
    );
  }

   Widget _buildShortDes(){
    return 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Description',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        onSaved: (String val){
          this.shortDes = val;
        },
      ),
    );
  }

   Widget _buildClgName(){
    return 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'College Name',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        keyboardType: TextInputType.text,
        onSaved: (String val){
          this.clgName = val;
        },
      ),
    );
  }

   Widget _buildDate(){
    return 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child:
      DateTimeField(
        format: DateFormat("dd-MM-yyy HH:mm"),
        decoration: InputDecoration(
          labelText: 'Date of Event',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            this.datetm = DateTimeField.combine(date,time);
            return DateTimeField.combine(date, time);
          } else {
            this.datetm =currentValue;
            return currentValue;
          }
        },
        validator: (DateTime val) {
              if(val == null)return "Date of event is required";
              else return null;
        },
      ),
    );    
  }

  Widget _buildDeleteDate(){
    return 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child:
      DateTimeField(
        format: DateFormat("dd-MM-yyy HH:mm"),
        decoration: InputDecoration(
          labelText: 'Delete Post On',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            this.deleteDate = DateTimeField.combine(date,time);
            return DateTimeField.combine(date, time);
          } else {
            this.deleteDate = currentValue;
            return currentValue;
          }
        },
        validator: (DateTime val) {
              if(val == null)return "Date of deletion is required";
              else return null;
        },
      ),
    );    
  }

   Widget _buildLink(){
    return 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'link',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        keyboardType: TextInputType.url,
        onSaved: (String val){
          this.link = val;
        },
      ),
    );
  }

  String dropdownValue = 'category';

  Widget _buildCategory(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 30,
            elevation: 16,
            style: TextStyle(color: Colors.black54,),
            underline: Container(
              height: 1,
              color: Colors.black54,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
                this.category = newValue;
              });
            },
            items: <String>['category','dance','sports','code','music','literature']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                  style: TextStyle(fontSize: 18,color: Colors.black54,),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

   Widget _buildEmail(){
    return 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Email Address',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        validator: (String val) {
            if(val.isEmpty)return null;
            if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(val)) 
              return 'Please enter a valid Email Address';
            else return null;            
        },
        keyboardType: TextInputType.emailAddress,
        onSaved: (String val){
          this.email = val;
        },
      ),
    );
  }

   Widget _buildPhone(){
    return 
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Phone Number',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        keyboardType: TextInputType.phone,
        onSaved: (String val){
          this.phone = val;
        },
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       key: _scaffoldKey,  
       appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Image(image: AssetImage('assests/title.png'), width: 100,),
      ),
      body:SingleChildScrollView(
              child:Column(
                children: <Widget>[
                  SizedBox(height: 20,),
              Text('New Post',
                style: TextStyle(
                  fontSize: 20,
                ),          
              ),
              Form(
                key: _formKey,
                child:Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      _buildTitle(),
                      _buildShortDes(),
                      _buildClgName(),
                      _buildDate(),
                      _buildDeleteDate(),
                      _buildFee(),
                      _buildLink(),
                      _buildEmail(),
                      _buildPhone(),
                      _buildImage(context),
                      SizedBox(height: 5,),
                      _buildCategory(),
                      SizedBox(height: 80,),
                      RaisedButton(
                        onPressed: (){
                          if (!_formKey.currentState.validate())return;
                          _formKey.currentState.save();      
                          if(_image != null){
                            this.hasPoster = 1;
                          uploadPic(context);   
                          }              
                          createData();
                          final snackBar = SnackBar(content: Text('Sucessful Post!'));
                          _scaffoldKey.currentState.showSnackBar(snackBar);    
                          Future.delayed(const Duration(milliseconds: 800), () {
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white,fontSize: 16),
                          ),
                          color: Colors.redAccent,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}