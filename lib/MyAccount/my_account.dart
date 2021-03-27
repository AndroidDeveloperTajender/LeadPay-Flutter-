import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leadgram2/MyAccount/edit_account.dart';
import 'package:leadgram2/colors.dart';
import 'package:leadgram2/drawer.dart';

import '../HomePage/HomeScreen.dart';



class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var data;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading=true;
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton:  FloatingActionButton(
        elevation: 5.0,
        child: new Icon(Icons.edit),
        backgroundColor: Colors.blue,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => EditAccount()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: Draw(context: context),
      body: (loading) ? Center(child: CircularProgressIndicator()):SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child:  SafeArea(
          child: Stack(
            children: <Widget>[
              new Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/Intro/commonbg.png', fit: BoxFit.cover,),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Container(
                  child:  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/logo.png",
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                      //Padding(padding: new EdgeInsets.only(top: MediaQuery.of(context).size.width / 10),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FlatButton(child: Image.asset("assets/menudrawer.png",height: 20,width: 30,),onPressed: (){
                            scaffoldKey.currentState.openDrawer();
                          },),
                          Padding(padding: new EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),),
                          Center(
                            child: Text('My Account', style: new TextStyle(fontWeight: FontWeight.bold,color: lightblackColor, fontSize: 25.0),),
                          ),
                        ],
                      ),
                      //Padding(padding: new EdgeInsets.only(top: MediaQuery.of(context).size.height / 35),),
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: (data.containsKey("profilepic")) ? NetworkImage(data['profilepic']): AssetImage('assets/prof.png')
                            )
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(left: 10,right: 10),child:
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [

                            Padding(padding: new EdgeInsets.only(top: 20.0),),
                            displayInfo('Name', data['name']),
                            Padding(padding: const EdgeInsets.only(top: 10.0),),
                            displayInfo('Phone Number', data['phonenum']),
                            Padding(padding: const EdgeInsets.only(top: 10.0),),
                            displayInfo('E-Mail id', data.containsKey('emailid')?data['emailid']:'Not given'),
                            Padding(padding: const EdgeInsets.only(top: 10.0),),
                            displayInfo('Place', data['place']),
                            Padding(padding: const EdgeInsets.only(top: 10.0),),
                          ],
                        ),
                      ),)


                     // displayInfo('M-Pin', data['mpin']),
                    //  Padding(padding: const EdgeInsets.only(top: 35.0),),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  displayInfo(String field, String val) {
    double _width = MediaQuery.of(context).size.width;
    return new Container(
      width: _width,
      height: 50.0,
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: _width / 3,
            child: new Text('$field', style: new TextStyle(fontSize: 16.0),),
          ),
          Padding(padding: EdgeInsets.all(12.0),),
          Container(
            width: _width / 2,
            height: 35.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey.shade200
            ),
            child: Center(
              child: Text('$val', style: TextStyle(fontSize: 15.0),),
            ),
          )
        ],
      ),
    );
  }
  getData() async{
    var user=await FirebaseAuth.instance.currentUser();
    await Firestore.instance.collection("users").document(user.uid).get().then((val) {
      data=val.data;
    });
    print(data);
    setState(() {
      loading=false;
    });
  }

}






