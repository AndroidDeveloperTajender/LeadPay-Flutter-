import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/NavBar/NavBar.dart';
import 'package:leadgram2/drawer.dart';

import '../colors.dart';

class Tracking extends StatefulWidget {
  Tracking({Key key,this.data}):super(key:key);
  final DocumentSnapshot data;
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  @override
  void initState() {
    setStatus();
    super.initState();
  }
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int currentStep=1;
  String loanAmount="";
  String username="User";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body:SafeArea(
          child:Stack(
            children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/pages/32-100.jpg",
                fit: BoxFit.cover,
                
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 30,
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/12,),
                      Center(
                        child: Container(
                          height: 80,
                          width: 100,
                          child: Image.asset("assets/logo.png"),
                        ),
                      ),
                      Text('Dear $username',style: TextStyle(color: Colors.deepPurple,fontSize: 15),),
                      SizedBox(height: 10,),
                      Text('Thanks for submitting your loan application with KreditPay'),
                    ],
                  ),
                ),
                Expanded(
                  flex: 70,
                  child: Padding(
                    padding:EdgeInsets.only(left:MediaQuery.of(context).size.width/6),
                    child: SizedBox(
                      child: Stepper(
                        physics: AlwaysScrollableScrollPhysics(),
                        steps: [
                          Step(
                            title: Text('Application Form Submitted',),
                            content: Text("hey"),
                            isActive: true,
                          ),
                          Step(
                              title: Text('Documents Submitted'),
                              content: Text(''),
                              isActive: true,
                              state: (currentStep==1)?StepState.complete:StepState.indexed
                          ),
                          Step(
                              title: Text('Application Under Review',),
                              subtitle: Text("(It make take 3-15 working Days)"),
                              content: Text(''),
                              isActive: (currentStep>1)?true:false,
                              state: (currentStep==2)?StepState.complete:StepState.indexed
                          ),
                          Step(
                              title: Text('Approved'),
                              content: Text(""),
                              subtitle: Text('(As per bank/financial\n Service Provider Report)'),
                              state: (currentStep==3)?StepState.complete:StepState.indexed,
                              isActive:(currentStep>2)?true:false
                          ),
                          Step(
                            title: Text('Total Loan Amount'),
                            subtitle: (currentStep>3)?Text("\u20b9"+loanAmount,style: TextStyle(fontWeight: FontWeight.bold)):Text(""),
                            content: Text("\u20b9"+loanAmount,style: TextStyle(fontWeight: FontWeight.bold),),
                            state: (currentStep==4)?StepState.complete:StepState.indexed,
                            isActive: (currentStep>3)?true:false,

                          ),
                          Step(
                              title: Text('Distributed'),
                              content: Text(''),
                              isActive: (currentStep==5)?true:false,
                              state: (currentStep==5)?StepState.complete:StepState.indexed
                          ),
                        ],
                        type: StepperType.vertical,
                        currentStep: currentStep,
                        controlsBuilder: (BuildContext context,
                            {VoidCallback onStepContinue, VoidCallback onStepCancel,VoidCallback onStepTapped}) =>
                            Container(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton(child: Image.asset("assets/backkkll.png",height: 50,width: 50,),onPressed: (){
                    Navigator.of(context).pop();
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


      ),

    );
  }

  setStatus() async{
    var user=await FirebaseAuth.instance.currentUser();
    await Firestore.instance
        .collection("users")
        .document(user.uid)
        .get()
        .then((value) {
      setState(() {
        username = value.data['name'];
      });
    });
    if(widget.data['loan_application_status']=="Submitted Documents"){
      setState(() {
        currentStep=1;
      });
    }

    if(widget.data['timestamp']<DateTime.now().millisecondsSinceEpoch){
      setState(() {
        currentStep=2;
        _alreatgetDialog("Application Under Review\n(It make take 3-15 working Days)");
      });
    }

    /*
    if(widget.data['loan_application_status']=="Under Review"){
      setState(() {
        currentStep=2;
      });
    }

     */
    if(widget.data['loan_application_status']=="Approved"){
      setState(() {
        currentStep=4;
        loanAmount=widget.data['loanamount'];
      });
    }
    if(widget.data['loan_application_status']=="Distributed"){
      setState(() {
        currentStep=5;
        loanAmount=widget.data['loanamount'];
      });
    }
  }

  _alreatgetDialog(String msg) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.8,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/trackings3.png"),
                        fit: BoxFit.cover)),
                child: Stack (
                     children: [
                    Column(
                      children: [

                        Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Congratulation ! Dear ${username}',style: TextStyle(fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),

                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Text('${msg}',style: TextStyle(fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),
                                // Center(
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(15.0),
                                //     child: Column(
                                //       children: [
                                //         Image.asset("assets/trackings3.png",fit: BoxFit.fill,),
                                //       ],
                                //     ),
                                //   ),
                                // ),

                                FlatButton(
                                  child: Text(
                                    "Back",
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                  ), color: Colors.blue,
                                  onPressed: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => NavBar()));
                                  },
                                ),
                              ],
                            )),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("",style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                        /*
                        Row(
                          children: [
                            Center(
                              child:  Image.asset(
                                "assets/congresssss.jpg.jpg",
                                height: 150,
                                width: MediaQuery.of(context).size.width / 1.4,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),*/
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}




