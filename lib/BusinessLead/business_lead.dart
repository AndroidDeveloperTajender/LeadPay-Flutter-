import 'dart:math';
import "package:http/http.dart" as http;
//import 'package:cashfree/cashfree.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:leadgram2/BusinessLead/placeSelect.dart';
import 'package:leadgram2/colors.dart';
import 'package:leadgram2/drawer.dart';
import 'package:leadgram2/token_provider.dart';

final placeController = TextEditingController(text: "Select Place");
String place = "";

class BusinessLead extends StatefulWidget {
  @override
  _BusinessLeadState createState() => _BusinessLeadState();
}

class _BusinessLeadState extends State<BusinessLead> {
  //final Cashfree _cashfree = Cashfree();

  final leadProductController = TextEditingController(text: "Lead Product");
  final incomeRangeController = TextEditingController(text: "Income Range");
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey=GlobalKey<FormState>();
  var _banker = false;
  var _financialConsultant = false;
  var _other = false;
  var _financialServiceProvider = false;
  var buttonIndex = 0;
  String fullName;
  String companyName;
  String phoneNumber;
  String emailID;
  String leadType = "";
  String userName = "";
  String incomeRange = "";
  String leadProduct = "";
  var amount = 5000;
  var leadRequired = [
    "100Lead/50Rs=Rs. 5000",
    "200Lead/40Rs=Rs. 8000",
    "500Lead/30Rs=Rs. 15,000",
  ];
  /*
  @override
  void initState() {
    getUserData();
    _cashfree.on(Cashfree.EVENT_PAYMENT_SUCCESS, _handleCashfreePaymentSuccess);
    _cashfree.on(Cashfree.EVENT_PAYMENT_ERROR, _handleCashfreePaymentError);
    _cashfree.on(Cashfree.EVENT_ERROR, _handleCashfreeError);
    super.initState();
  }


   */
  @override
  void dispose() {
    //_cashfree.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: new Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: new Image.asset(
                  'assets/eee.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  child: Image.asset(
                    "assets/backkkll.png",
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: new EdgeInsets.only(top: 5.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/simplelogo.png',
                            height: 75,
                            width: 75,
                            fit: BoxFit.cover,
                            scale: 2.0,
                          ),
                        ],
                      ),
                      new Center(
                        child: new Text(
                          'Business Leads',
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: new EdgeInsets.only(top: 20.0),
                      ),
                      new Container(
                        //width: MediaQuery.of(context).size.width,
                        height: 190.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white.withOpacity(0.85)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: new Column(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: new Text(
                                    'Dear $userName',
                                    style: new TextStyle(
                                        color: blueColor,
                                        fontFamily: 'Gotham',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Padding(
                                padding: new EdgeInsets.only(top: 15.0),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: new Text('Thanks for Visit us')),
                              new Text(
                                  'If you are a banker/Financial Consultant/ Financial Services provider and want to grow your business then please join us'),
                              Padding(
                                padding: new EdgeInsets.only(top: 15.0),
                              ),

                              // ***** BLUE BUTTON ****

                              Expanded(
                                child: new FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Your Experience + Telepe Leads = High Profit + Grow as sky',
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(15.0)),
                                  color: blueColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: new EdgeInsets.only(top: 10.0),
                      ),
                       Container(
                        width: MediaQuery.of(context).size.width,
                        // HEIGHT OF SECOND CONTAINER
//                      height: MediaQuery.of(context).size.height*1.8,
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white.withOpacity(0.85)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Column(
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: new Text(
                                    'I am a',
                                    style: new TextStyle(
                                        fontFamily: 'Gotham',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: CheckboxListTile(
                                      title: Text(
                                        'Banker',
                                        style: TextStyle(fontSize: 12.5),
                                      ),
                                      value: _banker,
                                      onChanged: (val) {
                                        setState(() {
                                          leadType = "Banker";
                                          _banker = val;
                                          _financialConsultant = false;
                                          _financialServiceProvider = false;
                                          _other = false;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: CheckboxListTile(
                                      title: Text(
                                        'Financial Consultant',
                                        style: TextStyle(fontSize: 12.5),
                                      ),
                                      value: _financialServiceProvider,
                                      onChanged: (val) {
                                        setState(() {
                                          leadType = "Financial Consultant";
                                          _banker = false;
                                          _financialConsultant = false;
                                          _financialServiceProvider = val;
                                          _other = false;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              new Row(
                                children: <Widget>[
                                  Expanded(
                                    child: CheckboxListTile(
                                      title: Text(
                                        'Financial Service Provider',
                                        style: TextStyle(fontSize: 12.5),
                                      ),
                                      value: _financialConsultant,
                                      onChanged: (val) {
                                        setState(() {
                                          leadType = "Financial Service Provider";
                                          _banker = false;
                                          _financialConsultant = val;
                                          _financialServiceProvider = false;
                                          _other = false;
                                        });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: CheckboxListTile(
                                      title: Text(
                                        'Other',
                                        style: TextStyle(fontSize: 12.5),
                                      ),
                                      value: _other,
                                      onChanged: (val) {
                                        setState(() {
                                          leadType = "Other";
                                          _other = val;
                                          _banker = false;
                                          _financialConsultant = false;
                                          _financialServiceProvider = false;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              inputButton('Full Name'),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                              ),
                              inputButton('Bank Name/Company Name'),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                              ),
                              inputButton('Phone Number'),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                              ),
                              inputButton('Email id'),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Text(
                                        'Choose Lead Product',
                                        style: TextStyle(
                                          fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                        onTap: getLeadDialog,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: pinkColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 45,
                                          width: 150,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 80,
                                                  child: Center(
                                                      child: Text(
                                                    leadProductController.text,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ))),
                                              Expanded(
                                                  flex: 20,
                                                  child: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Colors.white))
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Text(
                                        'Lead Location',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PlaceSelect()));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: pinkColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 45,
                                            width: 150,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 80,
                                                    child: Center(
                                                        child: Text(
                                                      placeController.text,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ))),
                                                Expanded(
                                                    flex: 20,
                                                    child: Icon(
                                                        Icons.keyboard_arrow_down,
                                                        color: Colors.white))
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50.0,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      new Text(
                                        'Lead Monthly\nIncome Range',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      InkWell(
                                          onTap: getIncomeDialog,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: pinkColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 45,
                                            width: 150,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    flex: 80,
                                                    child: Center(
                                                        child: Text(
                                                      incomeRangeController.text,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ))),
                                                Expanded(
                                                    flex: 20,
                                                    child: Icon(
                                                        Icons.keyboard_arrow_down,
                                                        color: Colors.white))
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'No. of lead required',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      '(Select any one)',
                                      style: TextStyle(color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6.0),
                              ),
                              choiceButtons(),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                              ),
                              // TEXT OPTIONS ( NON_SELECTABLE )
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: new Column(
//                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              'A. 100% Verified And Genuine',
                                              style: new TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0),
                                            ),
                                            Spacer(),
                                            Text(
                                              'B. Transparent Policy',
                                              style: new TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0),
                                            ),
                                            Spacer()
                                          ],
                                        )),
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              'C. 99% Accuracy Maintained',
                                              style: new TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0),
                                            ),
                                            Spacer(),
                                            Text(
                                              'D. Exchange Facility',
                                              style: new TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.0),
                                            ),
                                            Spacer()
                                          ],
                                        )),
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: new Text(
                                          '\t\tDear $userName',
                                          style: new TextStyle(
                                              color: Colors.blue, fontSize: 12.0),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                    ),
                                    new Center(
                                      child: new Text(
                                        'Thanks for choosing our services,',
                                        style: new TextStyle(
                                            color: Colors.black, fontSize: 13.5),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: new Text(
                                          '10 days money back guarantee if you are not satisfied with our lead services. So, don\'t worry about your payment',
                                          style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.5),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: new FlatButton(
                                        onPressed: () async {
                                          if(formKey.currentState.validate() && leadProductController.text!="Lead Product" && placeController.text!="Select Place" && incomeRangeController.text!="Income Range"){
                                            scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Please wait!"),));
                                          //  initiatePayment();
                                          }
                                          else{
                                            scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Please fill all details!"),));
                                          }
                                        },
                                        child: Text(
                                          'Buy and Download',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.white),
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(15.0)),
                                        color: blueColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  inputButton(String field) {
    return new SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 15,
      child: new TextFormField(
        maxLength: (field=="Phone Number")?10:30,
        validator: (val){
          if(val.isEmpty){
            return "Required!";
          }
          return null;
        },
        onChanged: (val) {
          if (field == "Full Name") {
            setState(() {
              fullName = val;
            });
          }
          if (field == "Bank Name/Company Name") {
            setState(() {
              companyName = val;
            });
          }
          if (field == "Phone Number") {
            setState(() {
              phoneNumber = val;
            });
          }
          if (field == "Email id") {
            setState(() {
              emailID = val;
            });
          }
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: "",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: pinkColor),
                borderRadius: BorderRadius.circular(18)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: pinkColor),
                borderRadius: BorderRadius.circular(18)),
            hintText: "  $field",
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
            filled: true,
            fillColor: pinkColor),
      ),
    );
  }

  choiceButtons() {
    var buttonHeight = MediaQuery.of(context).size.height / 12;
    var fontSize = MediaQuery.of(context).size.height / 90;
    return new Row(
      children: <Widget>[
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: buttonHeight,
            child: new FlatButton(
              onPressed: () {
                setState(() {
                  buttonIndex = 0;
                  amount = 5000;
                });
              },
              highlightColor: blueColor,
              child: Text(
                '100 Leads/50Rs\nRs. 5000',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0)),
              color: buttonIndex != 0 ? pinkColor : blueColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: buttonHeight,
            child: new FlatButton(
              onPressed: () {
                setState(() {
                  buttonIndex = 1;
                  amount = 8000;
                });
              },
              highlightColor: blueColor,
              child: Text(
                '200Leads/40Rs\nRs. 8000',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: fontSize, color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0)),
              color: buttonIndex != 1 ? pinkColor : blueColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12.0),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: buttonHeight,
            child: new FlatButton(
              onPressed: () {
                setState(() {
                  buttonIndex = 2;
                  amount = 15000;
                });
              },
              highlightColor: blueColor,
              child: Text(
                '500Lead/30Rs\nRs. 15,000',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: fontSize, color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0)),
              color: buttonIndex != 2 ? pinkColor : blueColor,
            ),
          ),
        ),
      ],
    );
  }

  getUserData() async {
    var user = await FirebaseAuth.instance.currentUser();
    await Firestore.instance
        .collection("users")
        .document(user.uid)
        .get()
        .then((value) {
      setState(() {
        userName = value.data['name'];
      });
    });
  }

  getIncomeDialog() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            actionsPadding: EdgeInsets.all(0),
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Stack(
                children: [
                  Container(
                    child: Center(child: Image.asset("assets/haksn.png",fit: BoxFit.cover,)),
                  ),
                  ListView(
                    children: [
                      RadioListTile(
                        activeColor: Colors.white,
                        groupValue: incomeRange,
                        value: "12k-15k",
                        onChanged: (val) {
                          setState(() {
                            incomeRange = val;
                            incomeRangeController.text = val;
                          });
                          Navigator.of(context).pop();
                        },
                        title: Text(
                          "12k-15k",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      RadioListTile(
                        activeColor: Colors.white,
                        groupValue: incomeRange,
                        value: "15k-30k",
                        onChanged: (val) {
                          setState(() {
                            incomeRange = val;
                            incomeRangeController.text = val;
                          });
                          Navigator.of(context).pop();
                        },
                        title: Text(
                          "15k-30k",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      RadioListTile(
                        activeColor: Colors.white,
                        groupValue: incomeRange,
                        value: "30k-50k",
                        onChanged: (val) {
                          setState(() {
                            incomeRange = val;
                            incomeRangeController.text = val;
                          });
                          Navigator.of(context).pop();
                        },
                        title: Text(
                          "30k-50k",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      RadioListTile(
                        activeColor: Colors.white,
                        groupValue: incomeRange,
                        value: "More than 50k",
                        onChanged: (val) {
                          setState(() {
                            incomeRange = val;
                            incomeRangeController.text = val;
                          });
                          Navigator.of(context).pop();
                        },
                        title: Text(
                          "More than 50k",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  getLeadDialog() {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            actionsPadding: EdgeInsets.all(0),
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 1.5,
              child: Stack(
                children: [
                  Container(
                    child: Center(child: Image.asset("assets/haksn.png",fit: BoxFit.cover,)),
                  ),
                  ListView(
                    children: [
                      RadioListTile(
                        activeColor: Colors.white,
                        groupValue: leadProduct,
                        value: "Personal Loan.",
                        onChanged: (val) {
                          setState(() {
                            leadProduct = val;
                            leadProductController.text = val;
                          });
                          Navigator.of(context).pop();
                        },
                        title: Text("Personal Loan.",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                      ),
                      RadioListTile(
                        activeColor: Colors.white,
                        groupValue: leadProduct,
                        value: "Business Loan.",
                        onChanged: (val) {
                          setState(() {
                            leadProduct = val;
                            leadProductController.text = val;
                          });
                          Navigator.of(context).pop();
                        },
                        title: Text("Business Loan.",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                      ),
                      RadioListTile(
                        activeColor: Colors.white,
                        groupValue: leadProduct,
                        value: "MSME Loan.",
                        onChanged: (val) {
                          setState(() {
                            leadProduct = val;
                            leadProductController.text = val;
                          });
                          Navigator.of(context).pop();
                        },
                        title: Text("MSME Loan.",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                      ),
                      RadioListTile(
                        activeColor: Colors.white,
                        groupValue: leadProduct,
                        value: "Student/Education Loan.",
                        onChanged: (val) {
                          setState(() {
                            leadProduct = val;
                            leadProductController.text = val;
                          });
                          Navigator.of(context).pop();
                        },
                        title: Text("Student/Education Loan.",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                      ),
                      RadioListTile(
                        activeColor: Colors.white,
                        groupValue: leadProduct,
                        value: "Daily Basis/Private Loan.",
                        onChanged: (val) {
                          setState(() {
                            leadProduct = val;
                            leadProductController.text = val;
                          });
                          Navigator.of(context).pop();
                        },
                        title: Text("Daily Basis/Private Loan.",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  /*

  initiatePayment() async{
    var orderId=DateTime.now().millisecondsSinceEpoch.toString();
    String token=await cashFreeToken().getToken(orderId, amount);
    var options = {
      'token': token,
      'stage': "PROD",
      'appId': "57663ad830b5854b39d3205f136675",
      'orderId': orderId,
      'orderAmount': amount,
      'orderNote': "TestNote",
      'orderCurrency': "INR",
      'customerName': fullName,
      'customerPhone': phoneNumber,
      'customerEmail': emailID,
      'notifyUrl': '',
      "paymentModes": ''
    };
    _cashfree.doPayment(options);
  }

  void _handleCashfreePaymentSuccess(
      CashfreePaymentSuccessResponse response) async {
    print("Cashfree payment success orderId:${response.orderId}");
    uploadData(response.referenceId,response.paymentMode,response.orderId);
    showDialog(context: context,builder: (_){
      return getSuccessDialog(response.referenceId);
    });
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

  uploadData(String refID,String paymentMode, String orderId) async {
    await Firestore.instance.collection("BusinessLeads").add({
      "persontype": leadType,
      "fullname": fullName,
      "companyname": companyName,
      "phonenum": phoneNumber,
      "emailid": emailID,
      "leadproduct": leadProduct,
      "leadlocation": place,
      "incomerange": incomeRange,
      "leadrequired": leadRequired[buttonIndex],
      "referenceId":refID,
      "paymentMode":paymentMode,
      "orderId":orderId,
    });
  }

   getSuccessDialog(String refId) {
    return  Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Container(

        height: MediaQuery.of(context).size.height/2,
        width: MediaQuery.of(context).size.width/1.2,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/teelpe25.png"),
                fit: BoxFit.cover
            )
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Dear $fullName"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Congratulations!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: blueColor),)

                    ],
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text("Payment Successful. Your Payment Reference Number is:"),
                        InkWell(
                            onTap: () {
                              Clipboard.setData(new ClipboardData(text: refId));
                              scaffoldKey.currentState.showSnackBar(
                                  SnackBar(content: new Text("Copied to Clipboard"),));
                            },
                            child: SelectableText(refId,style: TextStyle(fontWeight: FontWeight.bold),)),
                        Text("\nOur Team will contact You As Soon As Possible and you will egt your required Leads at mail with 24Hrs-48Hrs.\n\nThanks.")

                      ],
                    )
                ),
              ],
            ),
          ],
        ),
      ),

    );
   }
}
