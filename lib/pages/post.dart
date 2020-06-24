import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Post extends StatefulWidget {
  Post({Key key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  String title, shortDes, clgName, link, email, phone, category, fee;
  DateTime datetm,  deleteDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void createData(){

    Firestore.instance.collection("events").add({
      'Title': this.title,
      'Short Description': this.shortDes,
      'College Name': this.clgName,
      'Date': this.datetm,
      'Link': this.link,
      'Category': this.category,
      'Email Address': this.email,
      'Phone Number': this.phone,
      '_timeStampUTC': DateTime.now(),
      'Fee': this.fee,
      'DeleteDate': this.deleteDate,
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
        keyboardType: TextInputType.text,
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
                      SizedBox(height: 5,),
                      _buildCategory(),
                      SizedBox(height: 80,),
                      RaisedButton(
                        onPressed: (){
                          if (!_formKey.currentState.validate())return;
                          _formKey.currentState.save();                       
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