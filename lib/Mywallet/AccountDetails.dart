//import 'package:cashfree/cashfree.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/buttons.dart';
import 'package:leadgram2/colors.dart';
import 'package:leadgram2/token_provider.dart';

import '../colors.dart';

class AccountDetails extends StatefulWidget {
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final formKey=GlobalKey<FormState>();
  final scaffoldKey=GlobalKey<ScaffoldState>();
  String name;
  String bankName;
  String accountNumber;
  String ifscCode;
  String branchLocation;
  String phoneNumber;
  String email;
 /* final Cashfree _cashfree = Cashfree();
  @override
  void initState() {
    _cashfree.on(Cashfree.EVENT_PAYMENT_SUCCESS, _handleCashfreePaymentSuccess);
    _cashfree.on(Cashfree.EVENT_PAYMENT_ERROR, _handleCashfreePaymentError);
    _cashfree.on(Cashfree.EVENT_ERROR, _handleCashfreeError);
    super.initState();
  }

  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/1.png",
                fit: BoxFit.cover,
              ),
            ),
            getContents(context),

          ],
        ),
      ),
    );
  }

  getContents(BuildContext context) {
    var width=MediaQuery.of(context).size.width/1.5;
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 70, 30, 10),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              child: Image.asset('assets/teelpe15.png'),
            ),
            //SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text('Submit Account Details',style: TextStyle(color: blueColor,fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: width,
                  child: TextFormField(
                    validator: (val){
                      if(val.isEmpty){
                        return "Required";
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Full Name(As per Bank)",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        filled: true,
                        fillColor: greyColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: width,
                  child: TextFormField(
                    onChanged: (val){
                      phoneNumber=val;
                    },
                    maxLength: 10,
                    validator: (val){
                      if(val.isEmpty){
                        return "Required";
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: "",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Phone Number",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        filled: true,
                        fillColor: greyColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: width,
                  child: TextFormField(
                    onChanged: (val){
                      email=val;
                    },
                    validator: (val){
                      if(val.isEmpty){
                        return "Required";
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Email id",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        filled: true,
                        fillColor: greyColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: width,
                  child: TextFormField(
                    validator: (val){
                      if(val.isEmpty){
                        return "Required";
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Bank Name",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        filled: true,
                        fillColor: greyColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: width,
                  child: TextFormField(
                    validator: (val){
                      if(val.isEmpty){
                        return "Required";
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Account Number",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        filled: true,
                        fillColor: greyColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: width,
                  child: TextFormField(
                    validator: (val){
                      if(val.isEmpty){
                        return "Required";
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "IFSC Code",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        filled: true,
                        fillColor: greyColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: width,
                  child: TextFormField(
                    validator: (val){
                      if(val.isEmpty){
                        return "Required";
                      }
                      return null;
                    },
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Branch Location",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                        filled: true,
                        fillColor: greyColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text('Verify & Validate Account By Rs.25\nAnd Then Transfer Your Earning to Bank',textAlign: TextAlign.center,),
                  Text('(Do not worry this amount will be refundable after verify)',style: TextStyle(color: blueColor),textAlign: TextAlign.center )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundButton(color: yellowColor,f: (){
             if(formKey.currentState.validate()){
               scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Please wait!"),));
             // initiatePayment();
             }

            },name: 'Verify and Get Amount',),


          ],
        ),
      ),
    );
  }

  /*
  initiatePayment() async{
    var orderId=DateTime.now().millisecondsSinceEpoch.toString();
    String token=await cashFreeToken().getToken(orderId, 25);
    var options = {
      'token': token,
      'stage': "PROD",
      'appId': "57663ad830b5854b39d3205f136675",
      'orderId': orderId,
      'orderAmount': 25,
      'orderNote': "TestNote",
      'orderCurrency': "INR",
      'customerName': name,
      'customerPhone': phoneNumber,
      'customerEmail': email,
      'notifyUrl': '',
      "paymentModes": ''
    };
    _cashfree.doPayment(options);
  }

  void _handleCashfreePaymentSuccess(
      CashfreePaymentSuccessResponse response) async {
    print("Cashfree payment success orderId:${response.orderId}");
    uploadData();
    showDialog<dynamic>(context: context,
        builder: (BuildContext context){
          var fontSize=MediaQuery.of(context).size.height/55;
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            content: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/haksn.png'),
                      fit: BoxFit.cover
                  )
              ),
              height: MediaQuery.of(context).size.height/3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Congratulations',style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: fontSize+4),),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Your Request has been submitted successfully, you will get your settlement within 7 working days after verifying your Account.',style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w400
                    ),),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(onPressed: (){
                        Navigator.pop(context);
                        //Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child:categories()));
                      },shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color:Colors.transparent ),),
                        color:yellowColor ,
                        child: Text('ok',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),

                ],
              ),
            ),

          );
        }
    );
  }

  void _handleCashfreePaymentError(
      CashfreePaymentFailureResponse response) async {
    print(
        "Cashfree payment error msg:${response.txMsg}, status: ${response.txStatus}");
    showDialog(context: context,builder: (_){
      return AlertDialog(content: Text("Something Went Wrong.\n${response.txMsg},\n${response.txStatus}"),);
    });
  }

  void _handleCashfreeError(CashfreeError cashfreeError) async {
    print("Cashfree error:${cashfreeError.message}");
    showDialog(context: context,builder: (_){
      return AlertDialog(
        content: Text("Payment Error!\n${cashfreeError.message}"),
      );
    });
  }

  */

  void uploadData() async{
    try {
      var user=await FirebaseAuth.instance.currentUser();
      var data=await Firestore.instance.collection("users").document(user.uid).get();
      var telepePoints=data.data['telepePoints'];
      await Firestore.instance.collection("RefferalForms").add({
        "telepePoints":telepePoints,
        "name":name,
        "bankName":bankName,
        "accountNumber":accountNumber,
        "ifscCode":ifscCode,
        "phoneNumber":phoneNumber,
        "email":email,
        "branchLocation":branchLocation,
        "uid":user.uid
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

//   getData() async{
//    var user=await FirebaseAuth.instance.currentUser();
//    var data=await Firestore.instance.collection("users").document(user.uid).get();
//    phoneNumber=data.data['phonenum'];
//   }
}
