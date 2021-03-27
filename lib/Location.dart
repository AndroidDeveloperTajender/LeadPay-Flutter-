

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/ApplicationForm/ApplicationPage1.dart';

import 'package:leadgram2/colors.dart';


class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        title: Text("Select City"),
        leading: FlatButton(
          child: IconButton(
            icon: Icon(Icons.close,color: Colors.white,size: 30,),
          ),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: getBody(),
    );
  }

  getBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SimpleAutoCompleteTextField(
        suggestions: cities,
        key: key,
        textSubmitted: (val){
          setState(() {
            place=val;
            placeController.text=val;
          });
          Navigator.of(context).pop();
        },
        suggestionsAmount: 10,
        decoration: InputDecoration(
          hintText: "Search City", prefixIcon: Icon(Icons.search)
        ),
      ),
    );
  }

}
