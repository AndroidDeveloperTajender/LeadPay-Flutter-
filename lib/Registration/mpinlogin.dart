import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/Registration/authentication.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:leadgram2/NavBar/NavBar.dart';
import 'package:leadgram2/Registration/MobileLoginPage.dart';

import 'package:leadgram2/Registration/Registration.dart';
import 'package:leadgram2/colors.dart';

class MPinLoginPage extends StatefulWidget {
  @override
  _MPinLoginPageState createState() => _MPinLoginPageState();
}

class _MPinLoginPageState extends State<MPinLoginPage> {
  final errorSB = SnackBar(
    content: Text("INVALID MPIN"),
  );
  final key = new GlobalKey<ScaffoldState>();
  String enteredmpin = "";
  String _mpin;
  int _currentPage = 0;
  final pageView = PageController(initialPage: 0);
  Timer _timer;
  @override
  void initState() {
    getData();
    AuthService().versionCheck(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
//      body: PageView(
//        controller: pageView,
//        children: [
//          getPage1(),
//
//        ],
//      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/Intro/commonbg.png",
                fit: BoxFit.cover,
              ),
            ),

            Column(
              children: [
                SizedBox(
                  height:  50,
                ),
                Image.asset("assets/logo.png",height: 100,width: 100,),

                SizedBox(
                  height:  100,
                ),
                Padding(padding: const EdgeInsets.only(left: 20,right: 20,top: 1,bottom: 1),child:
                Card(
                  elevation: 8,
                  shape:   RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "INSTANT,SIMPLE,FAST,ANYTIME",
                          style: TextStyle(color: blueColor, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                        child: Text(
                          "Enter Your M-PIN",
                          style: TextStyle(
                              color: blueColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: PinCodeTextField(
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            inactiveFillColor: greyColor,
                            activeColor: yellowColor,
                            selectedColor: yellowColor,
                            activeFillColor: yellowColor,
                            inactiveColor: greyColor,
                          ),
                          length: 6,
                          onChanged: (val) {
                            setState(() {
                              enteredmpin = val;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 40,
                            child:MaterialButton(

                                onPressed: () {
                                  key.currentState.showSnackBar(SnackBar(
                                    content: Text("Currently Not Working"),
                                  ));
                                },
                                child:Ink(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [Color(0xff0A5D9C), Color(0xff339EF1)],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(30.0)
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Reset",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                )
                            ) ,
                          )
                          ,
                          SizedBox(
                            width: 120,
                            height: 40,
                            child:   MaterialButton(

                              onPressed: () {
                                if (_mpin == enteredmpin) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => NavBar()),
                                          (route) => false);
                                } else {
                                  key.currentState.showSnackBar(errorSB);
                                }
                              },
                              child:Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [Color(0xff0A5D9C), Color(0xff339EF1)],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0)
                                ),
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ) ,
                          )
                          ,
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MobileLoginPage()));
                              },
                              child: Text(
                                "or Login by Mobile Number ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegistrationPage()));
                              },
                              child: Text("Register",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: blueColor)))
                        ],
                      ) ,),
                    ],
                  ),
                ),
                )


              ],
            )
          ],
        ),
      ),
    );
  }

  getData() async {
    var user = await FirebaseAuth.instance.currentUser();
    await Firestore.instance
        .collection("users")
        .document(user.uid)
        .get()
        .then((val) {
      _mpin = val.data['mpin'];
    });
    print(_mpin);
  }

  getPage1() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/8.jpg",
            fit: BoxFit.fill,
          ),
        ),
        Align(
          alignment: Alignment(0, -.45),
          child: Image.asset(
            "assets/telepegif.gif",
            height: 125,
            width: 125,
          ),
        )
      ],
    );
  }
}
