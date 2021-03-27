import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/Mywallet/AccountDetails.dart';
import 'package:leadgram2/colors.dart';
import 'package:leadgram2/drawer.dart';

class MyWallet extends StatefulWidget {

  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int telepePoints=0;
  int noOfUsers=0;
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer:Draw(context: context),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/hj.png"),
                fit: BoxFit.cover,
                //colorFilter: ColorFilter.mode(Color.fromRGBO(192, 234, 218,1).withOpacity(0.6), BlendMode.softLight),
              ),
            ),
          ),
          getTable(),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(child: Image.asset("assets/9k.png",height: 50,width: 50,),onPressed: (){
                  scaffoldKey.currentState.openDrawer();
                },),
                Padding(padding: new EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),),
//              Center(
//                child: Text('My Account', style: new TextStyle(color: Colors.white, fontSize: 25.0),),
//              ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  getTable() {
    var imagesize=MediaQuery.of(context).size.height/15;
    var font1=MediaQuery.of(context).size.height/80;
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height/4.5,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            children: [
              TableRow(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex:2,
                          child: Container(
                            padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset('assets/t1.png',height: imagesize,width: imagesize,),
                                  Text('$noOfUsers Users',style: TextStyle(color: Colors.blue,fontSize: font1),),
                                  Text('Joined User By Links',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: font1))
                                ],
                              )
                          ),
                        ),
                        Expanded(flex:1,child: Container(child: Image.asset('assets/arr.png',height: imagesize,width: imagesize,))),
                        Expanded(
                          flex: 2,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset('assets/ga.png',height: imagesize,width: imagesize,),
                                  Text('50TP/User',style: TextStyle(color: Colors.blue),),
                                  Text('Earn TelePe points Per\nUser',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: font1))
                                ],
                              )
                          ),
                        ),

                      ],
                    ),
                  ]
              ),
              TableRow(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Container(child: Image.asset('assets/arr.png',height: imagesize,width: imagesize,)),
                          ),
                        )
                      ],
                    )
                  ]
              ),
              TableRow(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/kkkkkk.png',height: imagesize,width: imagesize,),
                                Text('$noOfUsers *50 TP = $telepePoints TP',style: TextStyle(color: Colors.blue,fontSize: font1),),
                                Text('Total Earnings by sharing Link',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: font1),)
                              ],
                            )
                        ),
                      ],
                    )
                  ]
              ),
              TableRow(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Container(child: Image.asset('assets/arr.png',width: imagesize,height: imagesize,)),
                          ),
                        )
                      ],
                    )
                  ]
              ),
              TableRow(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black26),
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/111.png',height: imagesize,width: imagesize,),
                                Text('$telepePoints TP = Rs.$telepePoints',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: font1),),
                                MaterialButton(
                                  color: yellowColor,
                                  child: Text("Withdraw",style: TextStyle(fontSize: font1),),
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountDetails()));
                                  },)
                              ],
                            )
                        ),
                      ],
                    )
                  ]
              ),
            ],

          ),
        ),
      ],
    );
  }

   getData() async{
    try {
      var user=await FirebaseAuth.instance.currentUser();
      var data=await Firestore.instance.collection("users").document(user.uid).get();
      setState(() {
        telepePoints=data.data['telepePoints'];
        noOfUsers=telepePoints~/50;
      });
    } on Exception catch (e) {
      print(e.toString());
    }
   }
}
