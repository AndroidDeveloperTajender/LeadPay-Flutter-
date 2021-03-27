

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:leadgram2/Registration/Registration.dart';
import 'package:leadgram2/Registration/mpinlogin.dart';

import 'package:page_indicator/page_indicator.dart';
import 'package:leadgram2/colors.dart';

class IntroPage extends StatefulWidget {
  
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  Timer _timer;
  int _currentPage=0;
  final pageView= PageController(
    initialPage: 0
  );
  final pageViewMain= PageController(
      initialPage: 0
  );

 @override
  void initState() {
    _timer=Timer.periodic(Duration(seconds: 5),(Timer timer){
      if(_currentPage<6){
        _currentPage++;
      }
      else{
        _currentPage=0;
      }
      pageView.animateToPage(_currentPage, duration: Duration(milliseconds: 350), curve: Curves.easeIn);

    });
    super.initState();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FlatButton(

            child: Text("Skip",style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0,decoration: TextDecoration.underline)),
            onPressed: (){
              _timer.cancel();
              pageView.animateToPage(6, duration: Duration(milliseconds: 350), curve: Curves.easeIn);
            },
          )
        ],
      ),
        body: getBody(),
    );
  }

  getBody() {
//    return PageView(
//      controller: pageViewMain,
//      children: [
//        getPage1(),
//
//      ],
//    );
  return  PageIndicatorContainer(
    child: PageView(
      controller: pageView,
      children: [
        getPage2(),
        getPage3(),
        //getPage4(),
        getPage5(),
       // getPage6(),
        //getPage7()
      ],
    ),
    length: 3,
    align: IndicatorAlign.bottom,
    indicatorColor: Colors.white,
    indicatorSelectorColor: Colors.white,
  );
  }

  getPage1() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/backgroundbg.jpg",fit: BoxFit.cover,),
        ),
        Align(
          alignment: Alignment(0,-.45),
          child: Image.asset("assets/telepegif.gif",height: 125,width: 125,),
        ),
      ],
    );
  }

  getPage2() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/Intro/intro1.png",fit: BoxFit.cover,),
        ),



/*
        Align(
          alignment: Alignment(0,0.7),
          child: Padding(padding: const EdgeInsets.only(left:20,right: 20),
      child:  Text(
        "Get Loan Up to Rs 500000 in 10 Mins Only, All Types of Profiles Can Apply the Loans at KREDIT PAY",style: TextStyle(color: lightblackColor,fontSize: 16,fontWeight: FontWeight.bold),
      ),
    )
        )
*/
      ],
    );
  }
  getPage3() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/Intro/intro2.png",fit: BoxFit.cover,),
        ),
        /*
        Align(
          alignment: Alignment(0,0.7),
          child:Padding(padding: const EdgeInsets.only(left: 20,right: 20),
        child:  Text(
          "Your Credit Score Is Low or Have Low Income Do not worry, Apply Loan at KREDIT PAY. ",style: TextStyle(color: lightblackColor,fontSize: 16,fontWeight: FontWeight.bold),
        ),
    )


        )
*/
      ],
    );
  }
  getPage4() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/Intro/intro2.jpg",fit: BoxFit.cover,),
        ),
        Align(
          alignment: Alignment(0,0.7),
          child:Padding(padding: const EdgeInsets.only(left: 20,right: 20),
    child:  Text(
      "If You Are Getting Low Salary, Late Salary, or working in an unlisted Company, You can Also Apply Here.",style: TextStyle(color: lightblackColor,fontSize: 16,fontWeight: FontWeight.bold),
    ),
    )

        )




      ],
    );
  }
  getPage5() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/Intro/intro3.png",fit: BoxFit.cover,),
        ),
       /* Align(
          alignment: Alignment(0,0.7),
          child: Padding(padding: const EdgeInsets.only(left: 20,right: 20),
    child: Text(
      "Without ITR / Without GST Profiles can Also Take Benefits from KREDIT PAY, Apply and Get Now.",style: TextStyle(color: lightblackColor,fontSize: 16,fontWeight: FontWeight.bold),
    ),)
        )*/
               Align(
            alignment: Alignment(0,.10),
            child:Text("")
        ),
        Align(
          alignment: Alignment(0,.90),
          child:  MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            color: lightblackColor,
            minWidth: MediaQuery.of(context).size.width/1.5,
            child: Text("Register",style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RegistrationPage()), (route) => false);
            },
          ),
        )
      ],
    );

  }
  getPage6() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/Intro/intro2.jpg",fit: BoxFit.cover,),
        ),
        Align(
          alignment: Alignment(0,0.5),
          child: Text(
            "Low Salary/Income can Apply",style: TextStyle(color: lightblackColor,fontSize: 12,fontWeight: FontWeight.bold),
          ),
        )
      ],
    );

  }
  getPage7() {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/Intro/intro1.jpg",fit: BoxFit.cover,),
        ),
        Align(
          alignment: Alignment(0,0.5),
          child: Text(
            "Quick & Convenient Application",style: TextStyle(color: lightblackColor,fontSize: 12,fontWeight: FontWeight.normal),
          ),
        ),
        Align(
          alignment: Alignment(0,.6),
          child:Text("100% Paperless")
        ),
        Align(
          alignment: Alignment(0,.65),
          child:  MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            color: lightblackColor,
            minWidth: MediaQuery.of(context).size.width/1.5,
            child: Text("Register",style: TextStyle(color: Colors.white),),
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>RegistrationPage()), (route) => false);
            },
          ),
        )
      ],
    );
  }
}
