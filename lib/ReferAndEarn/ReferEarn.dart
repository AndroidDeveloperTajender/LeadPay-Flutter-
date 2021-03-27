import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:leadgram2/NavBar/NavBar.dart';
import 'package:leadgram2/colors.dart';
import 'package:share/share.dart';
import 'package:leadgram2/drawer.dart';
class refer extends StatefulWidget {

  @override
  _referState createState() => _referState();
}

class _referState extends State<refer> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var dynamicLink="";
  String username="";
  final textController=TextEditingController(text: 'www.hhh/xye.com/123');
  @override
  void initState() {
    getDynamicLink();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var fontSize=MediaQuery.of(context).size.height/80;
    return Scaffold(
      drawer: Draw(),
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backkk.png"),
                fit: BoxFit.cover,
                //colorFilter: ColorFilter.mode(Color.fromRGBO(192, 234, 218,1).withOpacity(0.6), BlendMode.softLight),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height/1.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height/20,),
                Center(
                  child: Container(
                    height: 100,
                    child: Image.asset('assets/teelpe15.png'),
                  ),
                ),
                Text('Refer and Earn',style: TextStyle(fontWeight: FontWeight.bold,fontSize: fontSize+5,color: Colors.black87),),
                SizedBox(height: 15,),
                Text('Congratulations',style: TextStyle(color: blueColor,fontSize: fontSize+5,fontWeight: FontWeight.w700),),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 20,),
                    Text("Dear ",style: TextStyle(color: blueColor,fontSize: fontSize),),
                    Text((username=="")?"User":username,style: TextStyle(color: blueColor,fontSize: fontSize),),
                  ],
                ),
                SizedBox(height: 10,),
                Text('Thanks for Choosing',style: TextStyle(color: Colors.black87,fontSize: fontSize,fontWeight: FontWeight.w400),),
                SizedBox(height: 10,),
                Text('Referal program of Telepe',style: TextStyle(color: Colors.black87,fontSize: fontSize,fontWeight: FontWeight.w700),),
                SizedBox(height: 10,),
                Text('(Earn Unlimted by just refer)',style: TextStyle(color: blueColor,fontSize: fontSize,fontWeight: FontWeight.w500),),
                SizedBox(height: 5,),
                Text('Your Link',style: TextStyle(color: Colors.black87,fontSize: fontSize),),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: greyColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.3,
                      child: Row(
                        children: [
                         Expanded(
                           flex: 80,
                           child:  (dynamicLink=="")?Text("Loading"):Center(
                             child: SelectableText(dynamicLink),
                           ),
                         ),
                          Expanded(
                            flex: 20,
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.share,color: Colors.black,),
                                onPressed: (){
                                  Share.share(dynamicLink);},
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(child: Text('Earn upto 2 Lakh by just refer this\n link to your circle.',style: TextStyle(color: Colors.black87,fontSize: 15),)),
                SizedBox(
                  height: 10,
                ),
                Text('Collect Tele points and transfer to your bank.',style: TextStyle(color: Colors.black87,fontSize: fontSize),),
                SizedBox(height: 8,),
                Text('More refer = More Earning',style: TextStyle(color: blueColor,fontSize: fontSize,fontWeight: FontWeight.bold),),
                SizedBox(height: 7,),
                Text('10 Refer = 10 User= 10*50 = 500 TP',style: TextStyle(color: Colors.black87,fontSize: fontSize,fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Text('1 TP=1 INR,1 User Services = 50 TP',style: TextStyle(color: blueColor,fontSize: fontSize,fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(child: Image.asset("assets/backkkll.png",height: 50,width: 50,),onPressed: (){
                  setState(() {
                    currentIndex=2;
                  });
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavBar()));
                },),
                Padding(padding: new EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),),
//              Center(
//                child: Text('My Account', style: new TextStyle(color: Colors.white, fontSize: 25.0),),
//              ),
              ],
            ),
          ),
        ],

      ),
    );
  }

  getDynamicLink() async{
    var user=await FirebaseAuth.instance.currentUser();
    Uri imageLink=Uri.parse("https://firebasestorage.googleapis.com/v0/b/telepe-1533a.appspot.com/o/banner%2Fbannertelepe5.png?alt=media&token=9513dd31-81e0-4998-857f-0d49cd2e10c6");
    final DynamicLinkParameters parameters=DynamicLinkParameters(
      uriPrefix: "https://telepe.page.link",
      link: Uri.parse("https://www.telepe.in/invitedBy=${user.uid}"),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      androidParameters: AndroidParameters(
        packageName: "com.cws.telepeapp",
        minimumVersion: 125
      ),
      socialMetaTagParameters:  SocialMetaTagParameters(
        imageUrl: imageLink,
        title: 'TelePe Finance',
        description: "(Get Loan Apply UpTo \u20b9 5,00,000 within 10 Minutes).\nIf You are:\n1. Bad Cibil Users.\n2. Low Income/Salary.\n3. Need MSME Loan.\n4. Student\n5. Both Rented\n6. Need Fund for App/Web.\n\nDon't Worry Apply Now By Simply using this link.",
      ),
    );
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    //final Uri dynamicUrl = await parameters.buildUrl();
    setState(() {
      dynamicLink=shortUrl.toString();
    });
    await Firestore.instance.collection("users").document(user.uid).get().then((val) {
      setState(() {
        username=val.data['name'];
      });
    }
    );
  }
}