import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/NavBar/NavBar.dart';
import 'package:leadgram2/Registration/Registration.dart';
import 'package:leadgram2/Registration/authentication.dart';
import 'package:leadgram2/Registration/mpinlogin.dart';
import 'package:leadgram2/colors.dart';

class MobileLoginPage extends StatefulWidget {
  @override
  _MobileLoginPageState createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends State<MobileLoginPage> {

  bool checkbox=false;
  String _phoneNo, _smsCode, _verificationId;
  bool _codeSent = false;
  bool _verified = false;
  String status;
  final key = new GlobalKey<ScaffoldState>();
  final otpSnackBar = new SnackBar(content: Text('OTP Sent !'));
  final somethingWentWrong = new SnackBar(content: Text('Something Went Wrong ! Please try again later.'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: SafeArea(
        child: SingleChildScrollView(
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

              getContents(),
            ],
          ),
        ),
      ),
    );
  }

  getContents() {
    return  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 50,),

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

        Padding(padding: const EdgeInsets.only(left: 20,right: 20),child:
        Card(
          elevation: 8,
          shape:   RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Login by Mobile Number",
                  style: TextStyle(
                      color: blueColor, fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        _phoneNo ="+91"+val;
                      });
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: greyColor
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: greyColor
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "  Mobile Number",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        filled: true,
                        fillColor: greyColor

                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextField(
                    decoration: InputDecoration(
                        suffix: FlatButton(
                          onPressed: (){
                            _codeSent ? AuthService().signInWithOTP(_smsCode, _verificationId) : verifyPhone(_phoneNo);
                            if(_verified) {
                              print('OTP VERIFIED !!!!!!!!!!!!!');
                              key.currentState.showSnackBar(otpSnackBar);
                            }
                          },
                          child: _codeSent ? Text('') : Text("Get OTP Code",style: TextStyle(color: blueColor),),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: greyColor
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: greyColor
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "  OTP Code",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        filled: true,
                        fillColor: greyColor

                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 120,
                    height: 40,
                    child:MaterialButton(

                        onPressed: () {
                          if(_verified){
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavBar()), (route) => false);
                          }
                          key.currentState.showSnackBar(somethingWentWrong);
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
                        )
                    ) ,
                  )
                  ,
                  SizedBox(width: 40,)
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MPinLoginPage()));
                      },
                      child: Text("or Login by M-Pin ",style: TextStyle(fontWeight: FontWeight.bold),))

                ],
              ),
              SizedBox(height: 10,),
              Padding(padding: const EdgeInsets.all(6),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",style: TextStyle(fontWeight: FontWeight.bold),),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationPage()));
                      },
                      child: Text("Register",style: TextStyle(fontWeight: FontWeight.bold,color: blueColor)))
                ],
              ) ,)
              ,
            ],
          ),
        ),)


        ],

    );
  }

  Future<void> verifyPhone(String phoneNo) async {

    var firebaseAuth = await FirebaseAuth.instance;

    final PhoneVerificationCompleted verificationCompleted = (AuthCredential authCredentials) {
      AuthService().signIn(authCredentials);
//      AuthService().signInWithOTP(_smsCode, _verificationId);
      setState(() {
        this._verified = true;
      });
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavBar()), (route) => false);

      key.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 8),
        content: Text("Phone Number Instantly Verified!\nNo OTP Required. Proceed to Login")
        ,
      ));
    };

    final PhoneCodeSent _codeSent = (String verificationId, [int forceResendingToken]) async {
      this._verificationId = verificationId;
      setState(() {
        print('Code sent to $phoneNo');
        status = "\nEnter the code sent to " + phoneNo;
        this._codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verficationId) {
      this._verificationId = verficationId;
    };


    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      print('${authException.message}');
    };


    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout
    );

  }
}
