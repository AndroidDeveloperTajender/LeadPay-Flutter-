import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:leadgram2/AppliedLoan/appliedLoan.dart';
import 'package:leadgram2/HomePage/Notifications.dart';
import 'package:leadgram2/NavBar/NavBar.dart';
import 'package:leadgram2/Registration/termsandconditions.dart';
import 'package:leadgram2/colors.dart';
import 'package:leadgram2/token_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
//import 'package:url_launcher/url_launcher.dart';

class ApplicationPage5 extends StatefulWidget {
  ApplicationPage5(
      {Key key, this.applicationNumber,  this.name, this.appData, this.docs})
      : super(key: key);
  final int applicationNumber;
  final String name;
  final Map<String, dynamic> appData;
  final List<File> docs;
  @override
  _ApplicationPage5State createState() => _ApplicationPage5State();
}

class _ApplicationPage5State extends State<ApplicationPage5> {

  FlutterLocalNotificationsPlugin fltrNotification;
  var data;
//  final Cashfree _cashfree = Cashfree();
  Razorpay razorpay;
  bool reviews=true;
  bool tcaggrement=false;
  bool loanaggrement=false;
  bool genaratemyapplicationnumberaggrement=false;
  bool activemyfileaggrement=false;
  ProgressDialog progressDialog;
  bool loading=true;
  bool acceted=false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
//  final Cashfree _cashfree = Cashfree();
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://kreditpay-bd0cb.appspot.com');
  StorageUploadTask _uploadTask;
  StorageReference ref;
  List<String> documentURLs = List<String>();
  List<File> documentsfile = List<File>();

  bool tracknav=true;
  bool homenav=true;
  bool signaggrement=false;
  bool stamppaper=false;
@override
  void initState() {
    // TODO: implement initState
  getUser();
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
    documentsfile = widget.appData['documents'];

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog=ProgressDialog(context,type:ProgressDialogType.Normal,
      textDirection: TextDirection.rtl,
      isDismissible: true,);
    return WillPopScope(
      onWillPop: () => showDialog(
          context: context,
          builder: (context) {
            return WillPopScope(
              onWillPop: () => Future.value(false),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  height: 250,
                  width: 250,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Row(
                            children:[
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text("Dear (${widget.name})",style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Dont Worry',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),

                                  RichText(
                                    text: TextSpan(
                                      text: ' Your Payment Will Refund 100% in your account in both cases loan approve & Decline So Dont Worry Please Continue with your Application',
                                      style: TextStyle(fontSize: 12.0, color: Colors.black,fontWeight: FontWeight.bold),

                                    ),
                                  ),

                                  FlatButton(
                                    child: Text(
                                      "Apply & Get Loan",
                                      style: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold),
                                    ), color: Colors.blue,
                                    onPressed: () {
                                      openCheckout();
                                    },
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ) ?? false;
          }),
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
                    "assets/a3.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 75,
                    ),
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
                    Text(
                      "Application Form",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle, color: violateColor),
                            child: Center(
                              child: Text(
                                "1",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: blueColor,
                              height: 2,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle, color: violateColor),
                            child: Center(
                              child: Text(
                                "2",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: blueColor,
                              height: 2,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle, color: pinksColor),
                            child: Center(
                              child: Text(
                                "3",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: blueColor,
                              height: 2,
                            ),
                          ),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle, color: pinksColor),
                            child: Center(
                              child: Text(
                                "4",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Personal/\nIncome",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),

                        Text("Loan\nSelect",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        Text("Verify\nAccount",
                            style: TextStyle(
                                color: blueColor, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        Text("Get Loan",
                            style: TextStyle(
                                color: blueColor, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Dear ${widget.name} ",
                                        style: TextStyle(color: blueColor),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Congratulation",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: blueColor)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Wrap(
                                    children: [
                                      Text(
                                          "Accept all T&C and Policies & Continue for Next. ")
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),


                                Row(
                                  children:<Widget> [
                                    Checkbox(
                                      value: signaggrement,
                                      onChanged: (val){
                                        setState(() {
                                          signaggrement=val;
                                        });
                                      },
                                      activeColor: Colors.black,
                                      checkColor: Colors.white,
                                    ),
                                    Text("Relationship & PR \n Aggrement.",style: TextStyle(fontSize: 12),),
                                    Checkbox(
                                      value: acceted,
                                      onChanged: (val){
                                        setState(() {
                                          acceted=val;
                                        });
                                      },
                                      activeColor:  Colors.black,
                                      checkColor: Colors.white,
                                    ),
                                    Text("Accepted all\n T&C",style: TextStyle(fontSize: 12),),
                                  ],
                                ),
                                Row(
                                  children:<Widget> [
                                    Checkbox(
                                      value: loanaggrement,
                                      onChanged: (val){
                                        setState(() {
                                          loanaggrement=val;
                                        });
                                      },
                                      activeColor: Colors.black,
                                      checkColor: Colors.white,
                                    ),
                                    Text("Loan Process Application\n For"
                                        "(${widget.appData['loanamount']})",style: TextStyle(fontSize: 12),),
                                    Checkbox(
                                      value: stamppaper,
                                      onChanged: (val){
                                        setState(() {
                                          stamppaper=val;
                                        });
                                      },
                                      activeColor:  Colors.black,
                                      checkColor: Colors.white,
                                    ),
                                    Text("399 Rs KPPF \nProcess .",style: TextStyle(fontSize: 12),),

                                  ],
                                ),
                                Row(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        "Dear ${widget.name}",
                                        style: TextStyle(color: blueColor),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        "You will Receive 12 Digits Application No Instantly After Complete The Process, Complete your Application Process Now For your Loan, And Don't Exit Before the Generate Of your File Number. ",
                                        style:TextStyle(fontSize: 13,color: lightblackColor) ,)
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onPressed: () {
                                        scaffoldKey.currentState.showSnackBar(SnackBar(
                                          content: Text("Please wait!"),
                                        ));
                                        print(documentsfile);

                                        if(loanaggrement==true && acceted==true && stamppaper==true&& signaggrement==true) {

                                          progressDialog.show();
                                          progressDialog.update(message: "Generating Your Loan Value, Please Wait..");
                                          Timer(Duration(seconds: 5),
                                                  ()=>
                                                  _alreatgetDialog()
                                          );

                                        }else{
                                          scaffoldKey.currentState.showSnackBar(SnackBar(
                                            content: Text("Please fill all details.."),
                                          ));
                                        }
                                      },
                                      child: Text(
                                        "Accept & Process",
                                        style: TextStyle(
                                            color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      color: Colors.blue,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _alreatgetDialog() {

  progressDialog.hide();
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.9,
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/congratulationbg.jpg"),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Dear (${widget.name})",style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Congratulation !',style: TextStyle(fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),

                                RichText(
                                  text: TextSpan(
                                      text: ' Your Loan Application and Our Relationship Aggrement will Generate After Process Aggrement Fee ',
                                      style: TextStyle(fontSize: 12.0, color: Colors.black,fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(text: " (All Initial Fee Paid By You , when is 399 INR- Refundable 100%)", style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 12.0)),
                                  //      TextSpan(text: " For Stamps Papers) ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 12.0))
                                      ]
                                  ),
                                ),

                                RichText(
                                  text: TextSpan(
                                      text: ' KreditPay Has (',
                                      style: TextStyle(fontSize: 12.0, color: Colors.black,fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(text: " 0% Application. 0% Process Fee. 0% Brokerage Fees) ", style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 12.0)),
                                       // TextSpan(text: " Fees) ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 12.0))
                                      ]

                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "399 RS Is 100% Refundable.",
                                      style: TextStyle(fontSize: 12.0, color: Colors.black,fontWeight: FontWeight.bold),
                                      children: <TextSpan>[
                                        TextSpan(text: " With your Loan Instantly So", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                        TextSpan(text: " don't Worry To your Loan and Fee. ", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                                      ]
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        Text("Apply & Generate Application No Now",style: TextStyle(fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),

                                FlatButton(
                                  child: Text(
                                    "Apply & Get Loan",
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                  ), color: Colors.blue,
                                  onPressed: () {
                                    openCheckout();
                                  },
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

  AlertDialogs(){
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          children:[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("Dear (${widget.name})",style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Dont Worry',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),

                                RichText(
                                  text: TextSpan(
                                      text: ' Your Payment Will Refund 100% in your account in both cases loan approve & Decline So Dont Worry Please Continue with your Application',
                                      style: TextStyle(fontSize: 12.0, color: Colors.black,fontWeight: FontWeight.bold),
                                      
                                  ),
                                ),

                                FlatButton(
                                  child: Text(
                                    "Apply & Get Loan",
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold),
                                  ), color: Colors.blue,
                                  onPressed: () {
                                    openCheckout();
                                  },
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

  void openCheckout() async{
    // var info = widget.appData;
    // String orderId=DateTime.now().millisecondsSinceEpoch.toString();
    var options={
      //  'key':'rzp_test_wGIwjB59jldXa6',
      'key':'rzp_live_WoA3Np74fsSuDc',
      'amount':num.parse('399')*100,
      'name':'KREDITPAY',
      // 'order_id':'order_EMBFqjDHEEn80l',
      'prefill':{
        'contact':widget.appData['mobilenum'],
        'email':widget.appData['emailid']
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
    print(documentsfile);
    print("3");
    uploadApplicationDetails(
        response.paymentId, response.orderId);



  }

  uploadApplicationDetails(
      String refID,  String orderId) async {
    print("Adding up Data!");
    var info = widget.appData;
    print(info['documents']);
    print(documentsfile);
    info.remove("documents");
    info['documenturls'] = documentURLs;
    info["referenceId2"] = refID;
    info["paymentMode2"] = "paymentMode";
    info["orderId2"] = orderId;
    info['timestamp'] = DateTime.now().millisecondsSinceEpoch;
    print(info);
    //  print('uploading success');
    await Firestore.instance
        .collection("FundBookingLoanApplications")
        .document()
        .setData(info);
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Upload Complete!"),
    ));
    checkReferral();
    _getDialog();
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

  _getDialog() {
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
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/teelpe25.png"),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Dear ${widget.name}"),
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
                                    "Thanks for your Application Your Track ID:"),
                                InkWell(
                                    onTap: () {
                                      Clipboard.setData(new ClipboardData(
                                          text: widget.applicationNumber
                                              .toString()));
                                      scaffoldKey.currentState
                                          .showSnackBar(SnackBar(
                                        content:
                                            new Text("Copied to Clipboard"),
                                      ));
                                    },
                                    child: SelectableText(
                                      widget.applicationNumber.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Text("Dear Applicant, We are not any kind of BANK/NBFC/FINACIAL Institution we are a financial mediator/consultant only we can not processed any Loan we can share your details to Service Provider for your requirments only"),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>TermsPage()));

                                    },
                                    child: Text(
                                      "Check T&C For More Information.",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                          fontSize: 10),
                                    )),
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
                                        homenav=true;
                                      },
                                    ),
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

  void handlerPaymentWallet(ExternalWalletResponse response)async{
    // Toast.show("External Wallet "+response.walletName, context);
    print("External Wallet");
  }

  getUser() async{
    var user=await FirebaseAuth.instance.currentUser();
    await Firestore.instance.collection("users").document(user.uid).get().then((val) {
      data=val.data;
    }
    );
    setState(() {
      loading=false;
    });
  }

  checkReferral() async {
    try {
      bool success = false;
      var user = await FirebaseAuth.instance.currentUser();
      var refUID =
          await Firestore.instance.collection("users").document(user.uid).get();
      if (refUID.data['invitedBy'] != "none" &&
          refUID.data['referralDone'] == false) {
        await Firestore.instance
            .collection("users")
            .document(refUID.data['invitedBy'])
            .updateData({
          "Points": FieldValue.increment(50),
        });
        success = true;
      }
      if (success) {
        await Firestore.instance
            .collection("users")
            .document(user.uid)
            .updateData({
          "referralDone": true,
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future _showNotification() async{
    var androidDetails=new AndroidNotificationDetails("channel ID", "KreditPay", "Your Transaction is Successfully Submited "
        "of 299 Rs.",importance: Importance.Max);

    var iSODetails=new IOSNotificationDetails();
    var generalNotificationDetails=new NotificationDetails(androidDetails, iSODetails);

    await fltrNotification.show(0, "Payment Successfully.", "Your Transaction has been Completed,Your Application Number is ${widget.applicationNumber.toString()}", generalNotificationDetails);
    if(tracknav){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => appliedLoan()),
              (route) => false);
    }else if(homenav) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => NavBar()),
              (route) => false);
    }else if(reviews){
      // if (await canLaunch("https://play.google.com/store/apps/details?id=com.kredit_pay")) {
      //   await launch("https://play.google.com/store/apps/details?id=com.kredit_pay");
      // } else {
      //   throw 'Could not launch ';
      // }
    }
  }

  Future notificationSelected(String payload) async{
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => NotificationsPage()),
            (route) => false);
  }

}
