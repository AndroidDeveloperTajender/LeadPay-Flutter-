import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:leadgram2/ApplicationForm/ApplicationPage1.dart';
import 'package:leadgram2/drawer.dart';

import '../HomePage/HomeScreen.dart';

class loans extends StatefulWidget {
  @override
  _loansState createState() => _loansState();
}

class _loansState extends State<loans> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var imageSize=MediaQuery.of(context).size.height/10;
    var fontSize=MediaQuery.of(context).size.height/70;
    getCard(String img,String Name){
      return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(img,fit: BoxFit.fill,),
                //Text(Name,style: TextStyle(color: Colors.blue,fontSize: fontSize,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
               // Text('No Cibil Check\n3 EMI Free Support',style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
              ],
            ),
          )
      );
    }
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/a1.jpg"),
                  fit: BoxFit.fill,
                  //colorFilter: ColorFilter.mode(Color.fromRGBO(192, 234, 218,1).withOpacity(0.6), BlendMode.softLight),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Container(
                height: 40,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(child: Image.asset("assets/leftarrow.png",height: 50,width: 50,),onPressed: (){
                      Navigator.pop(context);
                    },),
                    Spacer(flex: 1,),
                    Text(
                      'LOANS',
                      style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                    Spacer(flex: 2,),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height/12,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationPage1()));
                    },
                    child: Table(
                      children: [
                        TableRow(
                            children: [
                              Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: getCard("assets/homeicon1.jpg"," ")
                            ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: getCard("assets/homeicon2.jpg"," ")
                              ),]
                        ),
                        TableRow(
                            children: [Padding(
                              padding: const EdgeInsets.only(right: 10,top: 15),
                              child: getCard("assets/homeicon3.jpg"," ")
                            ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10,top: 15),
                                child: getCard("assets/homeicon4.jpg","")
                              ),]
                        ),
                        TableRow(
                            children: [Padding(
                              padding: const EdgeInsets.only(right: 10,top: 15),
                              child:getCard("assets/homeicon5.jpg","")
                            ),

                              Padding(
                                padding: const EdgeInsets.only(left: 10,top: 15),
                                child:getCard("assets/homeicon6.jpg","")
                              ),]
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
        ),
      ),
    );
  }

}
