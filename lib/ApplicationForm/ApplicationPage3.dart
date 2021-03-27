

import 'dart:async';
import 'dart:io';
import 'dart:math';
//import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/ApplicationForm/ApplicationPage4.dart';
import 'package:leadgram2/ApplicationForm/ApplicationPage5.dart';
import 'package:leadgram2/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ApplicationPage3 extends StatefulWidget {
  ApplicationPage3({Key key,this.map}):super(key:key);
  final Map<String,dynamic> map;
  @override
  _ApplicationPage3State createState() => _ApplicationPage3State();
}

class _ApplicationPage3State extends State<ApplicationPage3> {
  //List<String> documentURLs=List<String>();
  List<File> documents=List<File>();
  String _dropDownValue;
  String _dropDownCibilValue;
  double loanamount=5000.0;
  String loanamountString="5000";
  String monthsString="1";
  double months=3.0;
  ProgressDialog progressDialog;
  String persontypes="";
  String residental="";
  String name="";
  String workstatus="";
  var rent = true;
  var own = false;
  var salary=true;
  final pancardController=TextEditingController(text:"Upload");
  final adhaarfrontController=TextEditingController(text:"Upload");
  final adhaarbackController=TextEditingController(text:"Upload");
  final photoController=TextEditingController(text:"Upload");
  final cancelchequeController=TextEditingController(text:"Upload");
  File pancard;
  File adhaarfront;
  File adhaarback;
  File photo;
  File cancelcheque;
  bool PanCardDone=false;
  bool adFDone=false;
  bool adBDone=false;
  bool photoDone=false;
  bool CancelChequeDone=false;
  var businessman=false;
  var applicationData;
  final scaffoldKey=GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
//  final FirebaseStorage _storage =
//  FirebaseStorage(storageBucket: 'gs://telepe-f122e.appspot.com');
//  StorageUploadTask _uploadTask;
//  StorageReference ref;
  var applicationNumber;
  @override
  void initState() {
    int min = 10000000; //min and max values act as your 6 digit range
    int max = 99999900;
    var randomizer = new Random();
    applicationNumber = min + randomizer.nextInt(max - min)+DateTime.now().millisecondsSinceEpoch;
    super.initState();
  }
  @override
  void dispose() {
  //  FilePicker.clearTemporaryFiles();
 //   documents.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    progressDialog=ProgressDialog(context,type:ProgressDialogType.Normal,
      textDirection: TextDirection.rtl,
      isDismissible: true,);
    return WillPopScope(child: Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
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
              Form(child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 80,
                        width: 100,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/step2.png",
                        height:  MediaQuery.of(context).size.height / 6.5,
                        width:  MediaQuery.of(context).size.width / 1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 0,),
                      new Padding(padding: const EdgeInsets.only(left:22.0,right:20.0),
                        child:Card(
                          elevation: 10,
                          shape:   RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: [
                              new Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Padding(

                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 30,
                                            width: MediaQuery.of(context).size.width / 1.5,
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15,top: 10),
                                                  child: Text("Customer Age Reuired:",style: TextStyle(fontSize: 15,color: blueColor,fontWeight: FontWeight.w400),),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15,top: 10),
                                                  child: Text("${monthsString}y",style: TextStyle(fontSize: 15,color: blueColor,fontWeight: FontWeight.bold),),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              //   Text("3M"),
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(context).size.width / 1.5,
                                                child:Slider(
                                                  activeColor: lightblackColor,
                                                  divisions: 99,
                                                  onChanged: (val){
                                                    setState(() {
                                                      monthsString=val.toStringAsFixed(0);
                                                      months=val;
                                                    });
                                                  },
                                                  min: 1,
                                                  max: 70,
                                                  value: months,
                                                ),
                                              ),
                                              //   Text("3 Yrs")
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  child:      Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Checkbox(
                                        value: salary,
                                        onChanged: (val){
                                          setState(() {
                                            salary=val;
                                            // background=AssetImage("assets/teelpe15.jpg");
                                            businessman=false;
                                            //student=false;
                                            //  notworking=false;
                                            //    working=false;
                                          });
                                        },
                                        activeColor: lightblackColor,
                                        checkColor: Colors.white,
                                      ),
                                      Text("Salary"),
                                      Checkbox(
                                        value: businessman,
                                        onChanged: (val){
                                          setState(() {
                                            businessman=val;
                                            //    background=AssetImage("assets/teelpe16.jpg");
                                            salary=false;
                                            //    student=false;
                                            //    notworking=false;
                                            //    working=false;
                                          });
                                        },
                                        activeColor: lightblackColor,
                                        checkColor: Colors.white,
                                      ),
                                      Text("Businessman"),

                                    ],
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  child:      Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Checkbox(
                                        value: rent,
                                        onChanged: (val){
                                          setState(() {
                                            rent=val;
                                            // background=AssetImage("assets/teelpe15.jpg");
                                            own=false;
                                            //student=false;
                                            //  notworking=false;
                                            //    working=false;
                                          });
                                        },
                                        activeColor: lightblackColor,
                                        checkColor: Colors.white,
                                      ),
                                      Text("Rent"),
                                      Checkbox(
                                        value: own,
                                        onChanged: (val){
                                          setState(() {
                                            own=val;
                                            //    background=AssetImage("assets/teelpe16.jpg");
                                            rent=false;
                                            //    student=false;
                                            //    notworking=false;
                                            //    working=false;
                                          });
                                        },
                                        activeColor: lightblackColor,
                                        checkColor: Colors.white,
                                      ),
                                      Text("Own"),

                                    ],
                                  ),
                                ),
                              ),



                              Padding(padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: DropdownButton(
                                      hint: _dropDownValue == null
                                          ? Text('Monthly Income')
                                          : Text(
                                        _dropDownValue,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(color: Colors.black),
                                      items: ['UPTO 2L', 'UPTO 5L', 'UPTO 10L','UPTO 50L',
                                        'UPTO 1Cr','UPTO 5Cr+'].map(
                                            (val) {
                                          return DropdownMenuItem<String>(
                                            value: val,
                                            child: Text(val),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (val) {
                                        setState(
                                              () {
                                            _dropDownValue = val;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),),
                              Padding(padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: DropdownButton(
                                      hint: _dropDownCibilValue == null
                                          ? Text('CIBIL STATUS')
                                          : Text(
                                        _dropDownCibilValue,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(color: Colors.black),
                                      items: ['500-600', '600-700', '700-800','800-900',
                                        '900-1000'].map(
                                            (val) {
                                          return DropdownMenuItem<String>(
                                            value: val,
                                            child: Text(val),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (val) {
                                        setState(
                                              () {
                                            _dropDownCibilValue = val;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),),
                              new Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Padding(

                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              height: 40,
                                              child:MaterialButton(

                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => ApplicationPage3()));
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
                                            ),

                                            SizedBox(
                                              width: 120,
                                              height: 40,
                                              child:  MaterialButton(

                                                  onPressed: () {
                                                    bool goAhead = true;
                                                    //    if (formKey.currentState.validate()) {

                                                    if(rent){
                                                      residental="Rent";
//                                            var info;
//                                            info['persontype']="Salaried Person";
//                                            info['company']=companyName;
//                                            info['experience']=experience;
//                                            info['grosssalary']=grosssalary;
//                                            details=info;
                                                    }
                                                    if(own){
                                                      // var info=widget.map;

                                                      residental="Owned";
//                                            var info;
//                                            info['persontypes']="Businessman";
//                                            info['company']=companyName;
//                                            info['experience']=experience;
//                                            info['monthlyincome']=income;
//                                            details=info;

                                                    }
                                                    if(salary){
                                                      workstatus="Salaried Person";
//                                            var info;
//                                            info['persontype']="Salaried Person";
//                                            info['company']=companyName;
//                                            info['experience']=experience;
//                                            info['grosssalary']=grosssalary;
//                                            details=info;
                                                    }
                                                    if(businessman){
                                                      // var info=widget.map;

                                                      workstatus="Businessman";
//                                            var info;
//                                            info['persontypes']="Businessman";
//                                            info['company']=companyName;
//                                            info['experience']=experience;
//                                            info['monthlyincome']=income;
//                                            details=info;

                                                    }
                                                    if(_dropDownCibilValue!="CIBIL STATUS"&&_dropDownValue!="Monthly Income") {
                                                      uploadData();
                                                    }else{
                                                      scaffoldKey.currentState.showSnackBar(SnackBar(
                                                        content: Text("Please fill all details!"),
                                                      ));
                                                    }
                                                    //    }

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
                                                        "Next",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ),
                                            )
                                            ,
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) ,)
                    ],
                  )
                ],
              ))

            ],
          ),
        ),
      ),
    ), onWillPop: () => Future.value(false))
      ;
  }



  uploadData() async{
    progressDialog.hide();
    var user=await FirebaseAuth.instance.currentUser();
    var info=widget.map;

    info["age"]= monthsString;
    info["workstatus"]= workstatus;
    info[ "residental"]= residental;
    info[ "monthly_income"]= _dropDownValue;
    info[  "cibil_status"]= _dropDownCibilValue;
   // info["loanamount"]=loanamountString;
  //  info['tenure']=monthsString+"months";
    info['uid']=user.uid;
    info['applicationnumber']=applicationNumber;
  //  info['documents']=documents;
    info['loan_application_status'] = "Submitted Documents";
    print(info);
    setState(() {
      applicationData=info;
    //  _getDialog(applicationData);
      Navigator.push(context, CupertinoPageRoute(builder: (context)=>ApplicationPage4(applicationData: applicationData,)));

    });
  }

}

