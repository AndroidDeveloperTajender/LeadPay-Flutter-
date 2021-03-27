import 'package:flutter/material.dart';
import 'package:leadgram2/colors.dart';
class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

        children: [

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/pages/31-100.jpg"),
                fit: BoxFit.fill,
                //colorFilter: ColorFilter.mode(Color.fromRGBO(192, 234, 218,1).withOpacity(0.6), BlendMode.softLight),
              ),
            ),
          ),
          getContents(),
           ],
      ),

    );
  }
  getContents() {
    return Column(
      children: [
        SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset( "assets/logo.png",height: 80,width: 100,),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40,right: 32,left: 32),
          child:Column(
            children: [
              Image.asset('assets/supportkreditpay.png',fit:BoxFit.cover,)
            ],
          ),
        )
      ],
    );
  }

/*
  getContents() {
    return Column(

      children: [
        SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset( "assets/logo.png",height: 100,width: 100,),
          ],
        ),
        Align(
            alignment: Alignment(0,-.5),
            child: Text("\n\nSupport",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
        Align(
            alignment: Alignment(0,-.4),
            child: Text("\nIf you need any support related to services",style: TextStyle(fontWeight: FontWeight.bold,color: violateColor))),
        Align(
            alignment: Alignment(0,-.3),
            child: Text("\nthen please mail to",style: TextStyle(fontWeight: FontWeight.bold,color: violateColor))),
        Align(
            alignment: Alignment(0,-.2),
            child: Text("\nsupport@kreditpay.in",style: TextStyle(fontWeight: FontWeight.bold,color: blueColor),)),
        Align(
            alignment: Alignment(0,-.1),
            child: Text("\nOur team will reply soon")),
        Align(
          alignment: Alignment(0,0),
          child: Text("\nThanks by KreditPay",style: TextStyle(color: blueColor,fontWeight: FontWeight.w500),),),
      ],
    );
  }

  */
}
