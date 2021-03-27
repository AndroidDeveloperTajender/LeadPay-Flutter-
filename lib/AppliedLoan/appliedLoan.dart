import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/AppliedLoan/Tracking.dart';
import 'package:leadgram2/drawer.dart';
import 'package:leadgram2/colors.dart';

import '../colors.dart';
import 'NotApply.dart';

class appliedLoan extends StatefulWidget {
  @override
  _appliedLoanState createState() => _appliedLoanState();
}

class _appliedLoanState extends State<appliedLoan> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int applicationNumber;
  final formKey=GlobalKey<FormState>();
  String username="";
  @override
  void initState() {
    checkUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: scaffoldKey,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/pages/32-100.jpg"),
                fit: BoxFit.cover,
                //colorFilter: ColorFilter.mode(Color.fromRGBO(192, 234, 218,1).withOpacity(0.6), BlendMode.softLight),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height/7,),
              Center(
                child: Container(
                  height: 80,
                  width: 100,
                  child: Image.asset("assets/fulllogo.png"),
                ),
              ),
              Text('\nDear $username',style: TextStyle(color: Colors.deepPurple,fontSize: 15),),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Thanks for submitting your loan application \n with KreditPay'),
                ],
              ),

              SizedBox(
                height: 15,
              ),
              Text('            Please Enter Your Application number\n                 to track your loan status'),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: 250,
                    child: Form(
                      key: formKey,
                      child: TextFormField(
                        validator: (val){
                          if(val.isEmpty){
                            return "Enter Application Number";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        onChanged: (val){
                          setState(() {
                            applicationNumber=int.parse(val);
                          });
                        },
                        textAlign: TextAlign.center,
                        decoration:InputDecoration(
                            counterText: "",
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
                            hintText: "Application Number",
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,),
                            filled: true,
                            fillColor: greyColor),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: RaisedButton(onPressed: ()async{
                  if(formKey.currentState.validate()){
                    checkNumber();
                  }
                },shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(12.0),
                  side: BorderSide(color:Colors.transparent ),),
                  color:Colors.blue ,
                  child: Text('Track',style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50,left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FlatButton(child: Image.asset("assets/backkkll.png",height: 40,width: 40,fit: BoxFit.cover,),onPressed: (){
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

  checkNumber() async{
    var user=await FirebaseAuth.instance.currentUser();
    var data=await Firestore.instance.collection("LeadGramApplication").where("applicationnumber",isEqualTo: applicationNumber).getDocuments();
    if(data.documents.isNotEmpty){
      var temp=data.documents[0];
      print(temp.runtimeType);
      Navigator.push(
            context, MaterialPageRoute(builder: (context) => Tracking(data: temp,)));
    }
    else {
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Application Number not found"),));
    }

  }

   checkUser() async{
     var user=await FirebaseAuth.instance.currentUser();
     var data=await Firestore.instance.collection("LeadGramApplication").where("uid",isEqualTo: user.uid).getDocuments();
     if(data.documents.isEmpty){
       Navigator.push(
         context, MaterialPageRoute(builder: (context) => NotApply()));
     }
     await Firestore.instance
         .collection("users")
         .document(user.uid)
         .get()
         .then((value) {
       setState(() {
         username = value.data['name'];
       });
     });
   }


}
