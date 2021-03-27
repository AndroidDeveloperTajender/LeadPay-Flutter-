import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:leadgram2/NavBar/NavBar.dart';
import 'package:leadgram2/Registration/MobileLoginPage.dart';
import 'package:leadgram2/Registration/termsandconditions.dart';
import 'package:leadgram2/colors.dart';
import 'authentication.dart';
final placeController = TextEditingController();
String place="";
class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  GlobalKey<AutoCompleteTextFieldState<String>> autocompletekey =
  new GlobalKey();
  List<DropdownMenuItem> citieslist = [];
  bool checkbox = false;
  String mpin = "";
  String phoneNo, verificationId, smsCode,  name;
  bool codeSent = false;
  bool verified = false;
  String currentText = "";
  final key = new GlobalKey<ScaffoldState>();
  final OTPSnackBar = SnackBar(
    content: Text("OTP Sent!"),
  );
  final OTPVerifiedSnackBar = SnackBar(
    content: Text("Phone Number Verified! Please Enter M-pin & Register Your Account.."),
  );
  final formKey=GlobalKey<FormState>();
  String invitedBy="none";
  @override
  void initState() {
    getDynamicLink();
    AuthService().versionCheck(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: SingleChildScrollView(
        // physics:NeverScrollableScrollPhysics(),
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
            getContents(),
          ],
        ),
      ),
    );
  }

  getContents() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
          ),

          Image.asset("assets/logo.png",height: 125,width: 125,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "INSTANT,SIMPLE,FAST,ANYTIME",
                  style: TextStyle(color: yellowColor),
                ),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.only(left: 20,right: 20),
          child: Card(
            elevation: 8,
            shape:   RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                Column(
                  children: [

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: blueColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Align(
                          alignment: Alignment.center,
                          child:TextFormField(
                            validator: (val){
                              if(val.isEmpty){
                                return "Please Enter Name";
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                name = val;
                              });
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: whiteColor),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: textfiledcolor),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "  Full Name",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black),
                                filled: true,
                                fillColor: greyColor),
                          ),
                        ),
                      ),
                    ),
                    /*
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextFormField(
                    validator: (val){
                      if(val.isEmpty){
                        return "Please Select City";
                      }
                      return null;
                    },
                    controller: placeController,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationPage()));
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.black,),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "  Place",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        fillColor: greyColor,filled: true),
                  ),
//                FindDropdown(
//                  showClearButton: true,
//                  searchBoxDecoration: InputDecoration(
//                      enabledBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.black),
//                          borderRadius: BorderRadius.circular(10)),
//                      focusedBorder: OutlineInputBorder(
//                          borderSide: BorderSide(color: Colors.black),
//                          borderRadius: BorderRadius.circular(10)),
//                      hintText: "Search City",
//                      hintStyle: TextStyle(
//                          fontWeight: FontWeight.bold, color: Colors.black),
//                     ),
//                  items: cities,
//                  onChanged: (val) {
//                    place = val;
//                  },
//                ),
//
                ),
              ),*/
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                              maxLength: 10,
                              validator: (val){
                                if(val.isEmpty){
                                  return "Please Enter Phone Number";
                                }
                                return null;
                              },
                              onChanged: (val) {
                                setState(() {
                                  phoneNo = "+91" + val;
                                });
                              },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  counterText: "",
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: greyColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: greyColor),
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "  Mobile Number",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold, color: Colors.black),
                                  filled: true,
                                  fillColor: greyColor),
                            ),
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child:Align(
                          alignment: Alignment.center,
                          child:  TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                suffix: FlatButton(
                                  onPressed: () {
                                    codeSent
                                        ? AuthService()
                                        .signInWithOTP(smsCode, verificationId)
                                        : verifyPhone(phoneNo);
                                    if (verified) {
                                      key.currentState.showSnackBar(OTPVerifiedSnackBar);
                                    }
                                  },
                                  child: codeSent
                                      ? Text(
                                    "Submit OTP",
                                    style: TextStyle(color: blueColor),
                                  )
                                      : Text(
                                    "Get OTP",
                                    style: TextStyle(color: blueColor),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: greyColor),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: greyColor),
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "  OTP Code",
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.black),
                                filled: true,
                                fillColor: greyColor),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Set M-Pin",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
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
                      mpin = val;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Checkbox(
                      value: checkbox,
                      onChanged: (val) {
                        setState(() {
                          checkbox = val;
                        });
                      },
                    ),
                    Text(
                      "I Agree & Accepting all ",
                      style: TextStyle(fontSize: 8),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) => TermsPage()));
                        },
                        child: Text(
                          " T&C  and Privacy Policy Aggrement online.",
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 8),
                        ))
                  ],
                ),
                (!checkbox)?Text("Required to accept!",style: TextStyle(fontSize: 8,color: Colors.red),):Container(),
                SizedBox(height:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 35,
                      width: 80,
                      child: RaisedButton(
                        onPressed: () async {
                          if(formKey.currentState.validate()) {
                            if(checkbox){
                              if (verified) {
                                var user = await FirebaseAuth.instance.currentUser();
                                await Firestore.instance
                                    .collection("users")
                                    .document(user.uid)
                                    .setData({
                                  "name": name,
                                  //   "place": place,
                                  "phonenum": phoneNo,
                                  "mpin": mpin,
                                  "invitedBy":invitedBy,
                                  "referralDone":false,
                                  "telepePoints":0
                                });
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => NavBar()),
                                        (route) => false);
                              }
                            }
                            else{
                              key.currentState.showSnackBar(SnackBar(content: Text("Please Accept Terms and Conditions!"),));
                            }
                          }

                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
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
                              "Register",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    ,
                    /*  MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minWidth: 100,
                color: yellowColor,
                onPressed: () async {
                  if(formKey.currentState.validate()) {
                    if(checkbox){
                      if (verified) {
                        var user = await FirebaseAuth.instance.currentUser();
                        await Firestore.instance
                            .collection("users")
                            .document(user.uid)
                            .setData({
                          "name": name,
                       //   "place": place,
                          "phonenum": phoneNo,
                          "mpin": mpin,
                          "invitedBy":invitedBy,
                          "referralDone":false,
                          "telepePoints":0
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => NavBar()),
                                (route) => false);
                      }
                    }
                    else{
                      key.currentState.showSnackBar(SnackBar(content: Text("Please Accept Terms and Conditions!"),));
                    }
                  }

                },
                child: Text(
                  "Continue",
                  style: TextStyle(color: blueColor),
                ),
              ),*/
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(height:20),
                Padding(padding: const EdgeInsets.all(6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ",style: TextStyle(fontWeight: FontWeight.bold),),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>MobileLoginPage()));
                        },
                        child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,color: blueColor)))
                  ],
                ) ,)
               ,
              ],
            ),
          ),)

        ],
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
      
      setState(() {
        this.verified = true;

      /*  Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => NavBar()),
                (route) => false);*/
      });
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  void getDynamicLink() async{
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    if(deepLink!=null){
      setState(() {
        invitedBy=deepLink.queryParameters['invitedBy'];
      });
    }
    print(invitedBy);
  }

}
