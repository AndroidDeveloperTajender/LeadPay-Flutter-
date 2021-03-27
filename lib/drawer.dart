
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:telepeapp/BusinessLead/business_lead.dart';

import 'package:leadgram2/MyAccount/my_account.dart';
import 'package:leadgram2/Mywallet/MyWallet.dart';
import 'package:leadgram2/NavBar/NavBar.dart';
import 'package:leadgram2/ReferAndEarn/ReferEarn.dart';

import 'package:leadgram2/Registration/mpinlogin.dart';
import 'package:leadgram2/colors.dart';
import 'package:leadgram2/loan/loans.dart';

import 'AppliedLoan/appliedLoan.dart';
import 'Support/Support.dart';
import 'feedback/Feedback.dart';

class Draw extends StatefulWidget {
  const Draw({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  var data;
  bool loading=true;
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/pages/111-100.jpg"),
                  fit: BoxFit.cover,
//

                )
              ),
            ),
            ListView(
              children: <Widget>[
                Container(
                  height: 125,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            flex: 80,
                            child: Container(
                              color: Colors.blue,
                            ),
                          ),
                          Expanded(
                            flex: 20,
                            child: Container()
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment(0,.5),
                        child: Container(height:80,width: 80,decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: (loading)? AssetImage('assets/prof.png') : (data.containsKey("profilepic")) ? NetworkImage(data['profilepic']):  AssetImage('assets/prof.png')
                            )
                        ),),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                (loading)?Center(child: Text("Loading"),):Center(child: Text("${data['name']}, ${data['place']}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: blueColor),),
                ),
                SizedBox(
                  height: 5,
                ),
             //   (loading)?Center(child: Text("Loading")):Center(child: Text(data['phonenum'])),
                ListTile(
                  leading: Image.asset('assets/dash.png',height: 35,width: 40,),
                  title: Text(
                    'Home',
                    style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0,color: blueColor),
                  ),
                  onTap: () {
                    setState(() {
                      currentIndex=2;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavBar()),
                      );
                    });
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/ac.png',height: 30,width: 30,),
                  title: Text(
                    'Account',
                    style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0,color: blueColor),
                  ),
                  onTap: () {
                    /*
                    setState(() {
                      currentIndex=0;
                    });*/
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  MyAccount()),
                    );
                  },
                ),
                /*
                ListTile(
                  leading: Image.asset('assets/t.png',height: 50,width: 50),
                  title: Text(
                    'Loans',
                    style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0,color:blueColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => loans()),
                    );
                  },
                ),

                ListTile(
                  leading: Image.asset('assets/e.png',height: 50,width: 50,),
                  title: Text(
                    'My Wallet',
                    style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0,color: blueColor),
                  ),
                  onTap: () {
                    setState(() {
                      currentIndex=1;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavBar()),
                      );
                    });
                  },

                ),

                 */
                  ListTile(
                    leading: Image.asset('assets/u.png',height: 30,width: 30),
                    title: Text(
                      'Loan Tracking',
                      style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0,color: blueColor),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => appliedLoan()),
                      );
                    },

                  ),
              /*  ListTile(
                  leading: Image.asset('assets/p.png',height: 50,width: 50),
                  title: Text(
                    'Business Lead',
                    style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0,color: blueColor),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessLead()));
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/h.png',height: 50,width: 50),
                  title: Text(
                    'Refer and Earn',
                    style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0,color: blueColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => refer()),
                    );
                  },

                ),*/
                ListTile(
                  leading: Image.asset('assets/feedback.png',height: 30,width: 30),
                  title: Text(
                    'FeedBack',
                    style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0,color: blueColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeedBack()),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/l.png',height: 30,width: 30),
                  title: Text(
                    'Support',
                    style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0,color: blueColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Support()),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/logout.png',height: 30,width: 30),
                  title: Text(
                    'Logout',
                    style: TextStyle(fontFamily: 'Gotham', fontSize: 15.0,color: blueColor),
                  ),
                  onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MPinLoginPage()), (route) => false),
                ),

              ],
            ),
//          Padding(
//            padding: const EdgeInsets.only(top: 70,left: 100),
//            child: Container(height:80,width: 80,decoration: BoxDecoration(
//                shape: BoxShape.circle,
//                image: new DecorationImage(
//                    fit: BoxFit.fill,
//                    image: (loading)? AssetImage('assets/prof.png') : (data.containsKey("profilepic")) ? NetworkImage(data['profilepic']):  AssetImage('assets/prof.png')
//                )
//            ),),
//          ),
          ],
        ),
      ),
    );
  }

  getData() async{
    var user=await FirebaseAuth.instance.currentUser();
    await Firestore.instance.collection("users").document(user.uid).get().then((val) {
      data=val.data;
    }
    );
    setState(() {
      loading=false;
    });
  }
}


