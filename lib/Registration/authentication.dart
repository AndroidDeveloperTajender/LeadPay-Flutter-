import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leadgram2/HomePage/HomeScreen.dart';
import 'package:leadgram2/IntroPage/IntroPage.dart';
import 'package:leadgram2/LoadingScreen.dart';
import 'package:leadgram2/NavBar/NavBar.dart';
import 'package:leadgram2/Registration/mpinlogin.dart';


import 'package:leadgram2/colors.dart';
import 'package:package_info/package_info.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthService {
  FirebaseAuth auth=FirebaseAuth.instance;
  final googlesignin=GoogleSignIn();

  handleAuth(){
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          print(snapshot);
         // Toast.show(snapshot.toString(), context);
         if(snapshot.connectionState==ConnectionState.active){
           FirebaseUser user= snapshot.data;
           if(user==null){
             return IntroPage();
           }
           return MPinLoginPage();
         } else {
           return CircularProgressIndicator(
           );
           return Scaffold(
             backgroundColor: yellowColor,
             body: Center(child: Text("Initializing..",style: TextStyle(color: Colors.black),),),
           );
         }
        });
//  var user=FirebaseAuth.instance.currentUser();
//  if(user!=null){
//    return MPinLoginPage();
//  }
//  else
//    {
//      return IntroPage();
//    }
 }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }

  Future<bool> loginwithGoogleSingUp(BuildContext context)async{

    GoogleSignInAccount account=await googlesignin.signIn();
    if(account!=null){
      GoogleSignInAuthentication googleSignInAuthentication=await account.authentication;

      AuthCredential credential=GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      AuthResult result=await auth.signInWithCredential(credential);
      FirebaseUser user=await auth.currentUser();
      // CheckEmaild(account.email, result.user, context);
      Singup(result.user,context);
      return Future.value(true);
    }else{
      return Future.value(false);
    }
  }
  CheckEmaild(String uid, FirebaseUser users, BuildContext context) async {

    var data = await Firestore.instance.collection(
        "users")
        .where("emailid", isEqualTo: uid)
        .getDocuments();

    if(data==null){
      //    print("check already user id " +    data.);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => NavBar()),
              (route) => false);
      print('emailid :- '+uid);
    }else{
      print('docuemntsdetails');
      for(var doc in data.documents){
        var d=doc;
        print(d);
        print('docuemntsdetailss');
        if(d==null){

          Singup(users,context);
        }else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => NavBar()),
                  (route) => false);
          print('document :- ' + d.toString());
        }
      }
      // Singup(users,context);
      // print("check already user id s " +    data.toString());
    }

  }
  Singup(FirebaseUser user, BuildContext context) async{
    var user = await FirebaseAuth.instance.currentUser();

    await Firestore.instance
        .collection("users")
        .document(user.uid)
        .setData({
      "name":user.displayName,
      "phonenum": user.phoneNumber,
      "Uid": user.uid,
      "emailid":user.email,
      "referralDone":false,
      "cashgramPoints":0
    });
    print('Registration successfully.');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => NavBar()),
            (route) => false);
  }
  versionCheck(context) async {
    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      remoteConfig.getString('force_update_current_version');
      double newVersion = double.parse(remoteConfig
          .getString('force_update_current_version')
          .trim()
          .replaceAll(".", ""));
      if (newVersion > currentVersion) {
        _showVersionDialog(context);
      }
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }
  _showVersionDialog(context) async {
    const APP_STORE_URL =
        'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
    const PLAY_STORE_URL =
        'https://play.google.com/store/apps/details?id=com.kredit_pay';
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel),
              onPressed: () => _launchURL(APP_STORE_URL),
            ),
            FlatButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        )
            : new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel),
              onPressed: () => _launchURL(PLAY_STORE_URL),
            ),
            FlatButton(
              child: Text(btnLabelCancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}