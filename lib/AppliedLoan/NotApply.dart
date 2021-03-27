import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/ApplicationForm/ApplicationPage1.dart';
import 'package:leadgram2/ApplicationForm/ApplicationPage5.dart';

import '../colors.dart';
class NotApply extends StatefulWidget {
  @override
  _NotApplyState createState() => _NotApplyState();
}

class _NotApplyState extends State<NotApply> {
  var username="";
  @override
  void initState() {
    getName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/pages/32-100.jpg"),
                fit: BoxFit.cover,
                //colorFilter: ColorFilter.mode(Color.fromRGBO(192, 234, 218,1).withOpacity(0.6), BlendMode.softLight),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 90, 30, 0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    height: 100,
                    child: Image.asset('assets/fulllogo.png'),
                  ),
                ),
                Text('Dear $username',style: TextStyle(color: Colors.deepPurple,fontSize: 15),),
                SizedBox(height: 15,),
                Text("   You haven't applied for any loans you can\n  select any option which is suitable for you" ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: RaisedButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ApplicationPage1()));
                  },shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                    side: BorderSide(color:Color.fromRGBO(129, 239, 194, 1.0) ),),
                    color:Colors.blue,
                    child: Text('Loans',style: TextStyle(color: Colors.white),),
                  ),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }

  void getName() async{
    var user=await FirebaseAuth.instance.currentUser();
    await Firestore.instance.collection("users").document(user.uid).get().then((val) {
      setState(() {
        username=val.data['name'];
      });
    }
    );

  }
}
