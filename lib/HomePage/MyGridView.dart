import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/colors.dart';
import 'package:leadgram2/model/banks.dart';

class MyGridView extends StatelessWidget {
  final List<banks> allCities;
    MyGridView({Key key, this.allCities}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(5.0),
      childAspectRatio: 5.0 / 9.0, // 8.0/9.0
      children: _getGridViewItems(context),
    );
  }
//  _getGridViewItems_1(BuildContext context){
//    List<Widget> allWidgets = new List<Widget>();
//    for (int i = 0; i < allCities.length; i++) {
//      var widget = new Text(allCities[i].name);
//      allWidgets.add(widget);
//    };
//    return allWidgets;
//  }

  _getGridViewItems(BuildContext context) {
    List<Widget> allWidgets = new List<Widget>();
    for (int i = 0; i < allCities.length; i++) {
      var widget = _getGridItemUI(context, allCities[i]);
      allWidgets.add(widget);
    };
    return allWidgets;
  }

  // Create individual item
  _getGridItemUI(BuildContext context, banks item) {
    return new InkWell(
        onTap: () {
        //  _showSnackBar(context, item);
        },

          child:  Column(

            children: <Widget>[
              new Image.asset(

                item.image,
               height: 50,
                width: 50,

              ),

            ],
          ),

        );
  }

  /// This will show snackbar at bottom when user tap on Grid item
  // _showSnackBar(BuildContext context, banks item) {
  //   final SnackBar objSnackbar = new SnackBar(
  //     content: new Text(" is a city in "),
  //     backgroundColor: Colors.black,
  //   );
  //
  //   Scaffold.of(context).showSnackBar(objSnackbar);
  // }
}