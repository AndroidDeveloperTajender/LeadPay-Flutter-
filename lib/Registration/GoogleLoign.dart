import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leadgram2/Registration/termsandconditions.dart';


import 'authentication.dart';

class GoogleLoign extends StatefulWidget{
  @override
  _LoginGoogleSignin createState() => _LoginGoogleSignin();

}

class _LoginGoogleSignin extends State<GoogleLoign>{
  bool checkbox = true;
  final key = new GlobalKey<ScaffoldState>();
  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn= GoogleSignIn();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignin=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/69-100.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                Image.asset("assets/teelpe15.png",height: 80,width: 80,),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    "TELEPAY",
                    style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),

                Text(
                  "Please Login and Signup on TelePay  ",style: TextStyle(color: Colors.black,fontSize: 17),
                ),


                Image.asset("assets/logging.png",height: 250,width: 200),
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
                      "I Agree the ",
                      style: TextStyle(fontSize: 10),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) => TermsPage()));
                        },
                        child: Text(
                          "Terms and conditions and privacy policy",
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 10),
                        ))
                  ],
                ),
                (!checkbox)?Text("Required to accept!",style: TextStyle(fontSize: 8,color: Colors.red),):Container(),
                Center(
                  child: Padding(padding: const EdgeInsets.all(15),
                    child: SignInButton(
                      Buttons.GoogleDark,
                      text: "Sign up with Google",
                      onPressed: () async {
                        bool res= await  AuthService().loginwithGoogleSingUp(context);
                        if(!res)
                          print('error logging in with google');
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  bool isSignin=false;
  Future<void> handleSignIn() async{
    GoogleSignInAccount googleSignInAccount=await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;
    AuthCredential credential=GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    AuthResult result=await _auth.signInWithCredential(credential);
    _user=result.user;
    setState((){
      isSignin=true;
    });
  }

  Future <void>googleSignOut() async{
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState((){
        isSignin=false;
      });
    });
  }
}
