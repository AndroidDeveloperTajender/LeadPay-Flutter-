
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:leadgram2/AppliedLoan/appliedLoan.dart';
import 'package:leadgram2/HomePage/Notifications.dart';
import 'package:leadgram2/Registration/termsandconditions.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:leadgram2/ApplicationForm/ApplicationPage3.dart';
import 'package:leadgram2/ApplicationForm/ApplicationPage5.dart';
import 'package:leadgram2/NavBar/NavBar.dart';
import 'package:leadgram2/colors.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../token_provider.dart';

class ApplicationPage4 extends StatefulWidget {
  ApplicationPage4({Key key, this.applicationData}) : super(key: key);
  //final int applicationnumber;
  final Map<String, dynamic> applicationData;
  @override
  _ApplicationPage4State createState() => _ApplicationPage4State();
}

class _ApplicationPage4State extends State<ApplicationPage4> {
  List<String> documentURLs = List<String>();

  FlutterLocalNotificationsPlugin fltrNotification;
  String name;
  String bankName;
  ProgressDialog progressDialog;
  String accountNumber;
  String ifscCode;
  String _dropDownStateValue;
  String assetstring="1000000";
  double asset=3.0;
  var leadamount="95";
  String leadselectString="25.0";
  double lsasset=25.0;
  var pla=false;
  var termsandconditions=false;
  Razorpay razorpay;

  String _dropDownCPValue;
  String branchLocation;
  final formKey = GlobalKey<FormState>();

  bool user1=false;
  bool user2=false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
//  final HttpsCallable callable = CloudFunctions.instance
//      .getHttpsCallable(functionName: 'widgets')
//        ..timeout = const Duration(seconds: 30);
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://telepe-6a686.appspot.com');
  StorageUploadTask _uploadTask;
  StorageReference ref;
  @override
  void initState() {
    // TODO: implement initState
   // getUser();


    var androidInitilize=new AndroidInitializationSettings('logo');
    var IOSInitilize=new IOSInitializationSettings();
    var initilizationSettings=new InitializationSettings(androidInitilize, IOSInitilize);
    fltrNotification=new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationSettings,
        onSelectNotification:notificationSelected);

//  _cashfree.on(Cashfree.EVENT_PAYMENT_SUCCESS, _handleCashfreePaymentSuccess);
//  _cashfree.on(Cashfree.EVENT_PAYMENT_ERROR, _handleCashfreePaymentError);
//  _cashfree.on(Cashfree.EVENT_ERROR, _handleCashfreeError);
    razorpay=new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerPaymentWallet);
    //documentsfile = widget.appData['documents'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog=ProgressDialog(context,type:ProgressDialogType.Normal,
      textDirection: TextDirection.rtl,
      isDismissible: true,);
    return WillPopScope(
        child: Scaffold(
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
                  fit: BoxFit.fill,
                ),
              ),
              Form(
                key: formKey,
                child: Column(
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
                          "assets/step3.png",
                          height:  MediaQuery.of(context).size.height / 6.5,
                          width:  MediaQuery.of(context).size.width / 1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(padding: const EdgeInsets.only(left: 20.0,right:20.0),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            children: [
                              Padding(padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: DropdownButton(
                                      hint: _dropDownStateValue == null
                                          ? Text('Choose Location')
                                          : Text(
                                        _dropDownStateValue,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(color: Colors.black),
                                      items: ['Andhra Pradesh', 'Arunachal Pradesh', 'Assam','Bihar',
                                        'Chhattisgarh','Goa','Gujarat','Haryana','Himachal Pradesh',
                                        'Jharkhand','Karnataka','Kerala','Madhya Pradesh','Maharashtra'
                                        ,'Manipur','Meghalaya','Mizoram','Mizoram','Odisha','Punjab'
                                        ,'Rajasthan','Sikkim','Tamil Nadu','Telangana','Tripura'
                                        ,'Uttar Pradesh','Uttar Pradesh','Uttarakhand','New Delhi','Chandigarh'
                                      ].map(
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
                                            _dropDownStateValue = val;
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
                                      hint: _dropDownCPValue == null
                                          ? Text('Customer Proffession')
                                          : Text(
                                        _dropDownCPValue,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      isExpanded: true,
                                      iconSize: 30.0,
                                      style: TextStyle(color: Colors.black),
                                      items: ['Individual','Self Employeed','Salaried','House WIfe',
                                        'Student','Others'].map(
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
                                            _dropDownCPValue = val;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 30,
                                            width: 190,
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15,top: 5),
                                                  child: Text("Assets Details:",style: TextStyle(fontSize: 15,color: blueColor,fontWeight: FontWeight.w400),),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 15,top: 5),
                                                  child: Text("${assetstring}rs",style: TextStyle(fontSize: 15,color: blueColor,fontWeight: FontWeight.bold),),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              //   Text("3M"),
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(context).size.width / 1.3,
                                                child:Slider(
                                                  activeColor: Colors.blue,
                                                  divisions: 999999,
                                                  onChanged: (val){
                                                    setState(() {
                                                      assetstring=val.toStringAsFixed(0);
                                                      asset=val;
                                                    });
                                                  },
                                                  min: 1,
                                                  max: 100000000,
                                                  value: asset,
                                                ),
                                              ), //   Text("3 Yrs")
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Center(
                                  child: Padding(

                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 30,
                                            width: MediaQuery.of(context).size.width / 1.3,
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5,top: 10),
                                                  child: Text("Lead Select(How Much Need):",style: TextStyle(fontSize: 15,color: blueColor,fontWeight: FontWeight.w400),),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5,top: 10),
                                                  child: Text("${leadselectString}",style: TextStyle(fontSize: 15,color: blueColor,fontWeight: FontWeight.bold),),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              //   Text("3M"),
                                              Container(
                                                height: 30,
                                                width: MediaQuery.of(context).size.width / 1.4,
                                                child:Slider(
                                                  activeColor: Colors.blue,
                                                divisions: 20,
                                                  onChanged: (val){
                                                    setState(() {
                                                      leadselectString=val.toStringAsFixed(0);
                                                      lsasset=val;
                                                      print(leadselectString);
                                                      if(leadselectString=="25"){
                                                        leadamount="95";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="49"){
                                                        leadamount="90";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="73"){
                                                        leadamount="85";
                                                        print(leadselectString);
                                                      }
                                                      else if(leadselectString=="96"){
                                                        leadamount="80";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="120"){
                                                        leadamount="75";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="144"){
                                                        leadamount="70";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="168"){
                                                        leadamount="65";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="191"){
                                                        leadamount="60";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="215"){
                                                        leadamount="55";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="239"){
                                                        leadamount="50";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="263"){
                                                        leadamount="45";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="286"){
                                                        leadamount="40";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="310"){
                                                        leadamount="35";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="334"){
                                                        leadamount="30";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="358"){
                                                        leadamount="25";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="381"){
                                                        leadamount="20";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="405"){
                                                        leadamount="15";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="429"){
                                                        leadamount="10";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="453"){
                                                        leadamount="5";
                                                        print(leadselectString);
                                                      }else if(leadselectString=="476"){
                                                        leadamount="5";
                                                      }else if(leadselectString=="500"){
                                                        leadamount="5";
                                                        print(leadselectString);
                                                      }
                                                    });
                                                  },
                                                  min: 25,
                                                  max: 500,
                                                  value: lsasset,
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
                                    height: 50,
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    child: SizedBox(
                                      width: 120,
                                      height: 40,
                                      child:MaterialButton(

                                          onPressed: () {
                          if(_dropDownStateValue!="Choose Location" && _dropDownCPValue!="Customer Proffession"){
                            if (formKey.currentState.validate()) {
                              // _get     Dialog();
                              uploadApplicationDetails(
                                  '', '', '');

                            }
                          }else {
                            scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Please fill all details!"),
                            ));
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
                                                "Submit",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white
                                                ),
                                              ),
                                            ),
                                          )
                                      ) ,
                                    ),),
                              ),
                            ],
                          ),
                        ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ), onWillPop: () => Future.value(false));
  }

  uploadApplicationDetails(
      String refID, String paymentMode, String orderId) async {
    var pushToken = await FirebaseMessaging().getToken();
    var info = widget.applicationData;
    info['pushToken'] = pushToken;
    info['loan_application_status'] = "Submitted Documents";
    info["referenceId1"] = refID;
    info["paymentMode1"] = paymentMode;
    info["orderId1"] = orderId;
    info["LeadAmount"]=leadamount;
    info["LeadSelect"]=leadselectString;
    info["Assets"]=assetstring;
    info["Location"]=_dropDownStateValue.toString();
    info["Customer_Profession"]=_dropDownCPValue.toString();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return getLeadsDialog(info);
        });
  }

  getLeadsDialog(Map<String,dynamic>appdata){
 //   Navigator.push(context, CupertinoPageRoute(builder: (context)=>ApplicationPage5(applicationNumber: widget
   //     .applicationData['applicationnumber'],
   //   name: name,appData: appdata,)));

    //   return showDialog(context: context,
    //    builder: (context){
      return WillPopScope( onWillPop:  ()=>Future.value(true),
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child:  Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.height/1.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/pages/formcardbg.png"))),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child:Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Dear ${widget.applicationData['fullname']}",
                                style: TextStyle(fontSize: 16,color: Colors.white),
                              ),
                              Text(
                                "Congratulations!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Kindly Accept all terms and condition submit the requesting leads Packages Fee."
                        , style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15.0),),
                    ),

                    Row(
                      children: [
                        CheckboxListTile(value: user1,
                            title: Text("Term & Conditions",style: TextStyle(fontSize: 16,color: Colors.white)),
                            onChanged: (value){
                              setState(() {
                                user1=value;
                              });
                            }),
                        Divider(
                          height: 10,
                        ),
                        CheckboxListTile(value: user2,
                            title: Text("Pay Lead Asset",style: TextStyle(fontSize: 16,color: Colors.white)),
                            onChanged: (value){
                              setState(() {
                                user2=value;
                              });
                            }),


                      ],
                    ),

                    SizedBox(
                      width: 120,
                      height: 40,
                      child:MaterialButton(
                          onPressed: () {
                            if(user1==true&&user2==true){

                              progressDialog.show();
                              progressDialog.update(message: "Generating Your Loan Value, Please Wait..");

                              Timer(Duration(seconds: 5),
                                      ()=>
                                      PaymentDialog()

                              );
                            }else{
                              scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text("Please fill all details.."),
                              ));
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
                                "Submit",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          )
                      ) ,
                    ),

                  ],
                ),
              ),
            ),
          ));
   // });
  }

  PaymentDialog(){
    progressDialog.hide();
    return showDialog(context: context,builder: (context){
      return WillPopScope( onWillPop:  ()=>Future.value(false),
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.height/1.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/pages/formcardbg.png"), fit: BoxFit.cover)),
              child:Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child:Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Dear ${widget.applicationData['fullname']}",style: TextStyle(fontSize: 16,color: Colors.white),
                                ),
                                Text(
                                  "Congratulations!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Your Lead Request Has Been genrated and accepted.\n we have many customer for your"
                              "selected products with good profiltes. \n Please Submit and Pay the Leads Amount and get your leads."
                          , style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Amount (${widget.applicationData['LeadAmount']}rs) is 100% Refundable with 30 days may back genrate it we failed to sure your leads or 100% exchange for switch off/unreachable/not Interred Leas. \n Increase Your Business Now and get your Track"
                          , style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),),
                      ),
                      SizedBox(
                        width: 120,
                        height: 40,
                        child:MaterialButton(

                            onPressed: () {
                              progressDialog.show();
                              progressDialog.update(message: "Generating Your Loan Value, Please Wait..");

                              Timer(Duration(seconds: 5),
                                      () =>
                                      //openCheckout()
                                   //   progressDialog.hide()
                                  uploadApplicationDetailss(widget.applicationData['applicationnumber'], "dafgdas")
                              );
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
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                        ) ,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }

  void openCheckout() async{
    progressDialog.hide();
    // var info = widget.appData;
    // String orderId=DateTime.now().millisecondsSinceEpoch.toString();
    var options={
        'key':'rzp_test_wGIwjB59jldXa6',
      //'key':'rzp_live_WoA3Np74fsSuDc',
      'amount':num.parse('399')*100,
      'name':'Lead Gram',
      // 'order_id':'order_EMBFqjDHEEn80l',
      'prefill':{
        'contact':widget.applicationData['mobilenum'],
        'email':widget.applicationData['emailid']
      },
      'external':{
        'wallets':['paytm']
      }
    };
    try{
      razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    print("Success");
    //Toast.show("Success", context);
    //print(documentsfile);
    print("3");
    uploadApplicationDetailss(response.paymentId, response.orderId);
  }

  uploadApplicationDetailss(String refID,  String orderId) async {
    print("Adding up Data!");
    var info = widget.applicationData;

    info["referenceId2"] = refID;
    info["paymentMode2"] = "paymentMode";
    info["orderId2"] = orderId;
    info['timestamp'] = DateTime.now().millisecondsSinceEpoch;
    print(info);
    //  print('uploading success');
    await Firestore.instance
        .collection("LeadGramApplication")
        .document()
        .setData(info);
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Upload Complete!"),
    ));
   // checkReferral();
    _getTrackDialog();
  }

  void handlerPaymentFailure(PaymentFailureResponse response)async{
    print("Error");
    //  Toast.show("Error "+response.code.toString(), context);
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
                "Something Went Wrong.\n${response.code.toString()},Status: \n${response.message.toString()}"),
          );
        });
  }

  void handlerPaymentWallet(ExternalWalletResponse response)async{
    // Toast.show("External Wallet "+response.walletName, context);
    print("External Wallet");
  }

  _getTrackDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.1,
                width: MediaQuery.of(context).size.width / 1.2,
             /*   decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/pages/congress.jpg"),
                        fit: BoxFit.cover)),*/
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Dear ${widget.applicationData['fullname']}"),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Congratulations!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: blueColor),
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                    "Your Track No:"),
                                InkWell(
                                    onTap: () {
                                      Clipboard.setData(new ClipboardData(
                                          text: widget.applicationData['applicationnumber']
                                              .toString()));
                                      scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content:
                                        new Text("Copied to Clipboard"),
                                      ));
                                    },
                                    child: SelectableText(
                                      widget.applicationData['applicationnumber'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Text("You Can Track Your Leads By Track System in line \n Thanks"),
                              /*  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>TermsPage()));

                                    },
                                    child: Text(
                                      "Check T&C For More Information.",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                          fontSize: 10),
                                    )),*/
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FlatButton(
                                      child: Text(
                                        "Thanks",
                                        style: TextStyle(
                                            color: blueColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        _showNotification();
                                     //   homenav=true;
                                      },
                                    ),
                                    /*
                                    FlatButton(
                                      child: Text(
                                        "Track",
                                        style: TextStyle(
                                            color: blueColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {

                                        _showNotification();
                                        tracknav=true;
                                      },
                                    )
                                    */
                                  ],
                                ),

                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future _showNotification() async{
    var androidDetails=new AndroidNotificationDetails("channel ID", "LeadGram", "Your Transaction is Successfully Submited "
        "of 299 Rs.",importance: Importance.Max);

    var iSODetails=new IOSNotificationDetails();
    var generalNotificationDetails=new NotificationDetails(androidDetails, iSODetails);

    await fltrNotification.show(0, "Payment Successfully.", "Your Transaction has been Completed,Your Application Number is ${widget.applicationData['applicationnumber'].toString()}", generalNotificationDetails);

  }

  Future notificationSelected(String payload) async{
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => NotificationsPage()),
            (route) => false);
  }

  getSuccessDialog(Map<String,dynamic> appData) {
    print(appData['documents']);
    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width / 1.2,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/llno.png"), fit: BoxFit.cover)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Dear ${widget.applicationData['fullname']}",
                            ),
                            Text(
                              "Congratulations!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: blueColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                        "Your Account Number has been Submitted Successfully. Please complete Your Next Process and Generate your Loan Application Number For Your Loan Amount ${widget.applicationData['loanamount']} INR"
                       , style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15.0),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Thanks",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: blueColor,
                          fontSize: 18),
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Process & Generate",
                      style: TextStyle(
                          color: blueColor, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
//                      Navigator.pushAndRemoveUntil(
//                          context,
//                          CupertinoPageRoute(
//                              builder: (context) => ApplicationPage5(
//                                    applicationNumber: widget
//                                        .applicationData['applicationnumbfer'],
//                                    name: name,appData: appData,docs: appData['documents'],
//                                  )),
//                          (route) => false);
                      progressDialog.show();
                      //progressDialog.update(message: "Calculating is in Please Wait..");

                      Timer(Duration(seconds: 5),
                              ()=>
                                 UploadingScreen(appData)
                      );
                    },
                    color: yellowColor,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  UploadingScreen(Map<String, dynamic> appData){
    progressDialog.hide();
    Navigator.push(context, CupertinoPageRoute(builder: (context)=>ApplicationPage5(applicationNumber: widget
        .applicationData['applicationnumber'],
      name: name,appData: appData,)));
  }

}
