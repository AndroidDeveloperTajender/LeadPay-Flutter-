import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/NavBar/NavBar.dart';

import '../colors.dart';
//import 'package:telepeapp/colors.dart';
//import 'package:flutter_instagram_image_picker/InstagramAuth.dart';
//import 'package:flutter_instagram_image_picker/flutter_instagram_image_picker.dart';
//import 'package:flutter_instagram_image_picker/screens.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicSelection extends StatefulWidget {
  @override
  _ProfilePicSelectionState createState() => _ProfilePicSelectionState();
}

class _ProfilePicSelectionState extends State<ProfilePicSelection> {

  final scaffoldkey=GlobalKey<ScaffoldState>();
  StorageReference ref;
  File image;
  String profilePic;
  final FirebaseStorage _storage =
  FirebaseStorage(storageBucket: 'gs://fundbooking-94e14.appspot.com');
  StorageUploadTask _uploadTask;
  final picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldkey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Image.asset(
                      "assets/backkkll.png",
                      height: 30,
                      width: 30,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  Center(
                    child: new Text(
                      'Choose Photo',
                      style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  Center(
                    child: IconButton(
                      icon: Icon(Icons.done,size: 30,),
                      onPressed: uploadImage,
                    ),

                  )
                ],
              ),
              Padding(
                padding: new EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 6, top: 16.0),
              ),
              new Container(
                height: 250.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(18.0),
                    color: greyColor),
                child: (image!=null)?Center(child: Image.file(image)):Center(
                  child: new Image.asset(
                    'assets/l2.png',
                    color: Colors.grey,
                  ),
                ),
              ),
//              Padding(
//                padding: new EdgeInsets.only(top: 14.0),
//              ),
//              getInstaCard(),
//              Padding(
//                padding: new EdgeInsets.only(top: 14.0),
//              ),
//              getFbCard(),
              Padding(
                padding: new EdgeInsets.only(top: 14.0),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    'Gallery',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.grey,
                        letterSpacing: 1.2),
                  )),
              Padding(
                padding: new EdgeInsets.only(top: 6.0),
              ),
              new Container(
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    size: 100,
                  ),
                  onPressed: getImage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getInstaCard() {
    return new Card(
      elevation: 15.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
              'assets/insta.png',
              scale: 3.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0),
            ),
            new Text(
              'Instagram',
              style: new TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2),
            ),
            Padding(
              padding: EdgeInsets.only(left: 70.0),
            ),
            FlatButton(
              onPressed: () async {
//                var accessToken;
//                accessToken = await InstagramAuth().accessToken;
//                if(accessToken == null) {
//                  accessToken = await Navigator.push(context, MaterialPageRoute(builder: (_) => InstagramWebViewLoginPage()));
//                  if(accessToken == null) return ;
//                }
//
//                Navigator.push(context, MaterialPageRoute(builder: (context)=> InstagramImagePicker(
//                  accessToken,
//                  showLogoutButton: true,
//                  onDone: (items){ Navigator.pop(context);},
//                  onCancel: ()=> Navigator.pop(context),
//                )
//                )
//                );
              },
              child: new Text(
                'Import',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              color: blueColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            )
          ],
        ),
      ),
    );
  }

  getFbCard() {
    return new Card(
      elevation: 15.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
              'assets/lalla.png',
              scale: 3.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.0),
            ),
            new Text(
              'Facebook',
              style: new TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2),
            ),
            Padding(
              padding: EdgeInsets.only(left: 70.0),
            ),
            FlatButton(
              onPressed: () {},
              child: new Text(
                'Import',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              color: blueColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            )
          ],
        ),
      ),
    );
  }

  Future getImage() async{
    final pickedImage=await picker.getImage(source: ImageSource.gallery,imageQuality: 50);
    setState(() {
      image=File(pickedImage.path);
    });
  }

   uploadImage() async{
     scaffoldkey.currentState.showSnackBar(SnackBar(content: Text("Please Wait, Uploading!"),));
     String imgPath = 'images/${DateTime.now().millisecondsSinceEpoch}.png';
     setState(() {
       _uploadTask=_storage.ref().child(imgPath).putFile(image);
     });
     profilePic=await (await _uploadTask.onComplete).ref.getDownloadURL();
     var user=await FirebaseAuth.instance.currentUser();
     await Firestore.instance.collection("users").document(user.uid).updateData({
       "profilepic":profilePic,
     });

     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavBar()), (route) => false);
  }
}
