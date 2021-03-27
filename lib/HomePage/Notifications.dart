

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/colors.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationData> displayInfo=List();
  bool loading=true;
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:  Stack(
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
          Padding(
            padding: const EdgeInsets.only(top: 40,left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(child: Image.asset("assets/leftarrow.png",height: 40,width: 40,fit: BoxFit.cover,),onPressed: (){
                  Navigator.pop(context);
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

  getContents() {
    return Column(
      children: [
        SizedBox(height:50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png",height: 70,width: 70,),
          ],
        ),
        Text("Notifications",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold ),),
        SizedBox(height: 20,),
        SizedBox(height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width/1.2,
        child: getList(),)
      ],
    );
  }

   getData() async {
     var user = await FirebaseAuth.instance.currentUser();
     var data = await Firestore.instance.collection(
         "LeadGramApplication")
         .where("uid", isEqualTo: user.uid)
         .getDocuments();
     if (data == null) {
       Text("You Dont Have Any Notificaiton.");

     } else{
       for (var doc in data.documents) {
         print(doc.data['applicationnumber']);
         displayInfo.add(NotificationData(
             doc.data['applicationnumber'],
             doc.data['loan_application_status']
         ));
       }
       setState(() {
         loading=false;
       });
   }

   }

  getList() {
    return (loading)?Center(child: CircularProgressIndicator()):ListView.builder(
        itemCount: displayInfo.length,
        itemBuilder: (bc,index){
          var item=displayInfo[index];
          if(item==null){
            return Center(child: Text("No Notifications to show"));
          }
          return Card(
            elevation: 5,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Dear User, Thanks for applying loan.\nYour Application Number is: \n"),
                  SelectableText(item.applicationNumber.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                  Text("\nYour Application status is: ${item.applicationStatus}"),

                ],
              ),
            ),
          );
        });
  }
}

class NotificationData{
  final int applicationNumber;
  final String applicationStatus;
  NotificationData(this.applicationNumber,this.applicationStatus);
}