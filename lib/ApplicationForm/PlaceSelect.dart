

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/colors.dart';
import 'ApplicationPage1.dart';


class PlaceSelect extends StatefulWidget {
  @override
  _PlaceSelectState createState() => _PlaceSelectState();
}

class _PlaceSelectState extends State<PlaceSelect> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinksColor,
        title: Text("Select City",style: TextStyle(color: lightblackColor),),
        leading: FlatButton(
          child: IconButton(
            icon: Icon(Icons.close,color: lightblackColor,size: 30,),
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
