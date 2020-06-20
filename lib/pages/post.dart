import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unime3/items/event.dart';

class Post extends StatefulWidget {
  Post({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  String title, shortDes, clgName, date, link, email, phone;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void createData(){
    print(this.title);
    print(this.shortDes); 

    Firestore.instance.collection("events").add({
      'Title': this.title,
      'Short Description': this.shortDes,
      'College Name': this.clgName,
      'Date': this.date,
      'Link': this.link,
      'Email Address': this.email,
      'Phone Number': this.phone,
    }).whenComplete((){
      print("$title created");
    });

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
          labelText: 'Short Description',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        validator: (String val) {
          if(val.isEmpty)return "Description is required";
          else return null;
        },
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
        validator: (String val) {
              if(val.isEmpty)return "College Name is required";
              else return null;
        },
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
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Date',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
        validator: (String val) {
              if(val.isEmpty)return "Data is required";
              else return null;
        },
        keyboardType: TextInputType.text,
        onSaved: (String val){
          this.date = val;
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
        validator: (String val) {
              if(val.isEmpty)return "URL is required";
              else return null;
        },
        keyboardType: TextInputType.url,
        onSaved: (String val){
          this.link = val;
        },
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
            if(val.isEmpty)return "Email is required";
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
        validator: (String val) {
              if(val.isEmpty)return "Phone Number is required";
              else return null;
        },
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
       appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body:SingleChildScrollView(
          child:Form(
            key: _formKey,
            child:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 40,),
                  _buildTitle(),
                  _buildShortDes(),
                  _buildClgName(),
                  _buildDate(),
                  _buildLink(),
                  _buildEmail(),
                  _buildPhone(),
                  SizedBox(height: 80,),
                  RaisedButton(
                    onPressed: (){
                      if (!_formKey.currentState.validate())return;
                      _formKey.currentState.save();
                       
                      createData();
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white,fontSize: 16),
                      ),
                      color: Colors.blue,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}