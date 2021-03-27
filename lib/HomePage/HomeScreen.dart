

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:leadgram2/HomePage/MyGridView.dart';
import 'package:leadgram2/model/banks.dart';
import 'package:leadgram2/model/personalloanmodel.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:leadgram2/ApplicationForm/ApplicationPage1.dart';
import 'package:leadgram2/HomePage/Notifications.dart';
import 'package:leadgram2/ReferAndEarn/ReferEarn.dart';
import 'package:leadgram2/Support/Support.dart';
import 'package:leadgram2/colors.dart';
import 'package:leadgram2/drawer.dart';
import 'package:leadgram2/token_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _username = "";
  var data;
  bool loading = true;
  final somethingWentWrong = new SnackBar(content: Text('Please Selcet At-Least One Products'));
  final somethingWentok=new SnackBar(content:Text('enter'));
  String pllist;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var shadows = [
    Shadow( // bottomLeft
        offset: Offset(-1.0, -1.0),
        color: Colors.white
    ),
    Shadow( // bottomRight
        offset: Offset(1.0, -1.0),
        color: Colors.white
    ),
    Shadow( // topRight
        offset: Offset(1.0, 1.0),
        color: Colors.white
    ),
    Shadow( // topLeft
        offset: Offset(-1.0, 1.0),
        color: Colors.white
    ),
  ];
  int i = 0;
  final carouselController = PageController();
  int _currentPage = 0;
  int _currentPage2 = 0;
  final allowNotifications = personalloanmodel(name: 'All Select');

  String name;
  Timer _carouselTimer;
  final notifications =[
    personalloanmodel(name:"Low Salary Pl(Min 15k)"),
    personalloanmodel(name:"Without Salary Slips PL"),
  personalloanmodel(name: "Proprietor Employee PL"),
  personalloanmodel(name:  "Partnership Employee PL"),
  personalloanmodel(name: "-1 Cibil Employee PL"),
  personalloanmodel(name:    "High Profile PL"),
  ];
  var tmpArray = [];
  //InfiniteScrollController clientScroll=InfiniteScrollController(initialScrollOffset: 0.0);
  final clientScroll = PageController(viewportFraction: 1 / 3, initialPage: 1);
  Timer clientTimer;
  bool isNotification = false;
  int notificationCounter = 0;
  final List<banks> _allCities = banks.allCities();

  @override
  void initState() {
    getData();
    getUser();

/*
    Timer(Duration(seconds: 5),
            () =>
        //    NewyearDialog(context)
    );*/


    _carouselTimer = Timer.periodic(Duration(seconds: 7), (Timer timer) {
      if (_currentPage < 6) {
        _currentPage++;
      }
      else {
        _currentPage = 0;
      }
      carouselController.animateToPage(
          _currentPage, duration: Duration(milliseconds: 500),
          curve: Curves.easeIn);
    });
    clientTimer = Timer.periodic(Duration(seconds: 8), (Timer timer) {
      if (_currentPage2 < 14) {
        _currentPage2++;
      }
      else {
        _currentPage2 = 0;
      }
      clientScroll.animateToPage(
          _currentPage2, duration: Duration(seconds: 8), curve: Curves.linear);
    });

    super.initState();
  }


  getCard(String img, String Name) {
    var imageSize = MediaQuery
        .of(context)
        .size
        .height / 10;
    var fontSize = MediaQuery
        .of(context)
        .size
        .height / 70;
    return Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(img, height: imageSize, width: imageSize,),
              Text(Name, style: TextStyle(color: Colors.blue,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              Text('No Cibil Check\n3 EMI Free Support', style: TextStyle(
                  fontSize: fontSize, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,)
            ],
          ),
        )
    );
  }


  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Draw(context: context),
      body: getBody(),
    );
  }

  loadingbar() async {
    return CircularProgressIndicator();
  }

  SafeArea getBody() {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Image.asset(
              "assets/homebgs.png",
              fit: BoxFit.fill,
            ),
          ),
          getContents(),
        ],
      ),
    );
  }

  getContents() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(flex: 10,

            child: getHeader()),
        Expanded(
          flex: 40,
          child: getCarousel(),
        ),
        Expanded(
          flex: 35,
          child: getLoans(),
        ),
        Expanded(
          flex: 50,
          child: ClientsBanner(),
          //getClients(),
        ),
        //getFeedBack(),
        Expanded(
          flex: 10,
          child: Covi19(),
          //getClients(),
        )
      ],
    );
  }



  ClientsBanner(){
    return SizedBox(
      height: 5,
      child: Row(
        children: [
          Expanded(flex:25,child:Padding(padding:const EdgeInsets.all(4),
            child: Text("Our Clients:-",style: TextStyle(fontSize: 14,color: Colors.blue),),)),
          Expanded(flex:75,child: Padding(padding: const EdgeInsets.only(top:80,right: 10,left: 10,bottom: 80),
            child:ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[

                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo1.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo2.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo3.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo4.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo5.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo6.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo7.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo8.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo9.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo10.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo11.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo12.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo13.png", width: 100.0, height:100.0) ,
                ),
                Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset("assets/Logo/Logo14.png", width: 100.0, height:100.0) ,
                ),
              ],
            ),
          ))
        ],
      )

    );
  }

  Covi19(){
    return SizedBox(
      height:0,
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: new Text("COVID-19, Stay Home -Stay Safe :- LEADGRAM working in 150+ Countries,  Support All Currencies, Trusted by Thousands Of Applicants World Wide,  Easy & Safe Apply , All Type Of Profiles Can Apply Now, Lowest Interest Rates Applied"),)
        ],
      ),
    );
  }


  getClients() {
    return SizedBox(
      height: 10,
      child: Row(
        children: [
          Expanded(
            flex: 100,
            child: PageView.builder(
              controller: clientScroll,
              itemCount: partnerLogos.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext bc,int index){
                return partnerLogos[index];

              },
            ),
          ),
        ],
      ),
    );
  }

  getBanks() {
    var imagesize = MediaQuery
        .of(context)
        .size
        .height / 12;
    var font1 = MediaQuery
        .of(context)
        .size
        .height / 100;
    const double padding1 = 4.0;
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 2.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationPage1()));

             // showAlertDialog(context);
            },
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.top,
              children: [
                TableRow(
                    children: [
                      Image.asset("assets/Logo/Logo1.jpg", height: imagesize,
                        width: imagesize,),
                      Image.asset("assets/Logo/Logo10.png", height: imagesize,
                        width: imagesize,),
                      Image.asset("assets/Logo/Logo11.png", height: imagesize,
                        width: imagesize,),
                    ]
                ),
                TableRow(
                    children: [
                      Image.asset("assets/Logo/Logo3.jpg", height: imagesize,
                        width: imagesize,),
                      Image.asset("assets/Logo/Logo5.png", height: imagesize,
                        width: imagesize,),
                      Image.asset("assets/Logo/Logo6.png", height: imagesize,
                        width: imagesize,),
                    ]
                ),
                TableRow(
                    children: [
                      Image.asset("assets/Logo/Logo7.jpg", height: imagesize,
                        width: imagesize,),
                      Image.asset("assets/Logo/Logo4.jpg", height: imagesize,
                        width: imagesize,),
                      Image.asset("assets/Logo/Logo9.png", height: imagesize,
                        width: imagesize,),
                    ]
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }

  getHomePageBody(BuildContext context) {
    return new MyGridView(allCities: _allCities);


//    if (MediaQuery.of(context).orientation != Orientation.portrait)
//    bool check = true ;
//    if(check == false) {
//       return ListView.builder(
//         itemCount: _allCities.length,
//         itemBuilder: _getListItemUI,
//         padding: EdgeInsets.all(0.0),
//       );
//     } else{
//     }
  }

  Padding getHeader() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
            child: Image.asset("assets/9k.png", height: 50, width: 50,),
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
            },),
          Text("${name}", style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
//          Text(" Hello  ",style: TextStyle(fontSize:20,shadows: shadows
//          ),),
          Spacer(flex: 4,),

          //(loading)?Text("Loading.."):SizedBox(width:MediaQuery.of(context).size.width/4,child: AutoSizeText(_username,maxLines:1,minFontSize:5,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
          InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Support())),

              child: Image.asset("assets/supportheadertoolicon.png", height: 35, width: 35,)),
          Spacer(flex: 1,),
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => NotificationsPage()));
              },
              child: (isNotification)
                  ? Badge(
                  badgeContent: Text(notificationCounter.toString()),
                  child: Image.asset("assets/notificationheadericon.png", height: 35, width: 35,))
                  : Image.asset("assets/notificationheadericon.png", height: 35, width: 35,)),
          Spacer(flex: 1,),

        ],
      ),

    );
  }

  getCarousel() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: SizedBox(
        height: 400,
        width: 400,
        child: Container(
          /*
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/teelpe10.png")
          )
        ),*/
          child: PageIndicatorContainer(

            padding: const EdgeInsets.all(5.0),
            child: PageView(

              controller: carouselController,
              children: [
                Image.asset("assets/BANNER/banner1.jpg", fit: BoxFit.fill),
                Image.asset("assets/BANNER/banner2.jpg", fit: BoxFit.fill,),
                Image.asset("assets/BANNER/banner3.jpg", fit: BoxFit.fill,),
                Image.asset("assets/BANNER/banner4.jpg", fit: BoxFit.fill,),
              ],
            ),
            length: 4,
            indicatorSpace: 4.0,
            indicatorSelectorColor: Colors.blue,
          ),
        ),
      ),
    );
  }

  getLoans() {
    var imagesize=MediaQuery.of(context).size.height/25;
    var font1=MediaQuery.of(context).size.height/100;
    const double padding1=4.0;
    return Padding(
      padding: const EdgeInsets.only(right:30.0,left:30.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                //1 st row
                TableRow(
                    children:[
                      Padding(padding: const EdgeInsets.all(0.0),
                      child: GestureDetector(
                          onTap: (){
                            // showAlertDialog(context);
                            tmpArray.clear();
                            OpenPLDialog(context);

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationPage1()));
                          },
                      child:Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(120.0),
                        ),
                        child:Padding(
                            padding: const EdgeInsets.all(padding1),
                            child: Column(
                              children: [
                                Image.asset("assets/Intro/pl.png",height: imagesize,width: imagesize,),
                                Center(child: Text("Personal Loan",
                                    style: TextStyle(fontSize: font1,color: blueColor,
                                      fontWeight: FontWeight.bold,),textAlign: TextAlign.center)),
                                Padding(
                                    padding: EdgeInsets.only(bottom:10.0),
                                    child:Text("(No Cibil Check)",style: TextStyle(fontSize: font1),)
                                ),
                              ],
                            )
                        ) ,
                      ) ,)
                      ),
          Padding(padding: const EdgeInsets.all(0.0),
            child: GestureDetector(
                onTap: (){
                  // showAlertDialog(context);
                  OpenBLDialog(context);

                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationPage1()));
                },
                child:    Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(120.0),
                  ),
                  child:Padding(
                      padding: const EdgeInsets.all(padding1),
                      child: Column(
                        children: [
                          Image.asset("assets/Intro/bl.png",height: imagesize,width: imagesize,),
                          Center(child: Text("Business Loan",style: TextStyle(fontSize: font1,color: blueColor,fontWeight: FontWeight.bold),textAlign: TextAlign.center)),
                          Padding(
                              padding: EdgeInsets.only(bottom:10.0),
                              child:Text("(No Cibil Check)",style: TextStyle(fontSize: font1),)),
                        ],
                      )
                  ),
                ),
            ),
          ),

                    ]
                ),

                TableRow(
                    children:[
                      Padding(padding: const EdgeInsets.all(0.0),
                          child: GestureDetector(
                            onTap: (){
                              // showAlertDialog(context);
                              OpenPRLDialog(context);

                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationPage1()));
                            },
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(120.0),
                              ),
                              child:Padding(
                                  padding: const EdgeInsets.all(padding1),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/Intro/prl.png",height: imagesize,width: imagesize,),
                                      Center(child: Text("Property Loan",style: TextStyle(fontSize: font1,color: blueColor,fontWeight: FontWeight.bold,),textAlign: TextAlign.center)),
                                      Padding(
                                          padding: EdgeInsets.only(bottom:10.0),
                                          child:Text("No Cibil Check",style: TextStyle(fontSize: font1),)),
                                    ],
                                  )
                              ) ,
                            ),
                          )),
      Padding(padding: const EdgeInsets.all(0.0),
        child: GestureDetector(
            onTap: (){
              // showAlertDialog(context);
              OpenInsuranceDialog(context);

              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationPage1()));
            },
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(120.0),
              ),
              child:Padding(
                  padding: const EdgeInsets.all(padding1),
                  child: Column(
                    children: [
                      Image.asset("assets/Intro/insurance.png",height: imagesize,width: imagesize,),
                      Center(child: Text("Insurance",style: TextStyle(fontSize: font1,color: blueColor,fontWeight: FontWeight.bold),textAlign: TextAlign.center)),
                      Padding(
                          padding: EdgeInsets.only(bottom:10.0),
                          child:Text("No Cibil Check",style: TextStyle(fontSize: font1),)),
                    ],
                  )
              ) ,
            ),
        )),

                    ]
                ),
                //2d row
                TableRow(
                    children:[
                      Padding(padding: const EdgeInsets.all(0.0),
                          child: GestureDetector(
                            onTap: (){
                              // showAlertDialog(context);
                              OpenBankAccountDialog(context);

                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationPage1()));
                            },
                            child:  Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(120.0),
                              ),
                              child:Padding(
                                  padding: const EdgeInsets.all(padding1),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/Intro/ba.png",height: imagesize,width: imagesize,),
                                      Center(child: Text("Bank Account",style: TextStyle(fontSize: font1,color: blueColor,fontWeight: FontWeight.bold),textAlign: TextAlign.center)),
                                      Padding(
                                          padding: EdgeInsets.only(bottom:10.0),
                                          child:Text("No Cibil Check",style: TextStyle(fontSize: font1),)),
                                    ],
                                  )
                              ) ,
                            ),)),
                      Padding(padding: const EdgeInsets.all(0.0),
                          child: GestureDetector(
                            onTap: (){
                              // showAlertDialog(context);
                              OpenCreditCardsDialog(context);

                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationPage1()));
                            },
                            child:Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(120.0),
                              ),
                              child:Padding(
                                  padding: const EdgeInsets.all(padding1),
                                  child: Column(
                                    children: [
                                      Image.asset("assets/Intro/cc.png",height: imagesize,width: imagesize,),
                                      Center(child: Text("Credit Cards",style: TextStyle(fontSize: font1,color: blueColor,fontWeight: FontWeight.bold),textAlign: TextAlign.center)),
                                      Padding(
                                          padding: EdgeInsets.only(bottom:10.0),
                                          child:Text("No Cibil Check",style: TextStyle(fontSize: font1),)),
                                    ],
                                  )
                              ) ,
                            ) ,
                          )),

                    ]
                ),

              ],
            ),
          ),
        ),
        
    );
  }
 /* getCheckboxItems(){

    values.forEach((key, value) {
      if(value == true)
      {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();
  }*/
  OpenPLDialog(BuildContext context) {


    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () => Future.value(true),
              child:Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child:Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Column(
                      children: [
                        Padding(padding: const EdgeInsets.all(5),
                          child: Text("Personal Loan",style: TextStyle(color: Colors.black,fontSize: 18),),),
                        Container(

                         // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                          child: CheckboxGroup(
                            labels: <String>[
                              "Low Salary Pl(Min 15k)",
                              "Without Salary Slips PL",
                              "Proprietor Employee PL",
                              "Partnership Employee PL",
                              "-1 Cibil Employee PL",
                              "High Profile PL",
                            ],

                            onChange: (bool isChecked, String label, int index) =>
                             //   print("isChecked: $isChecked   label: $label  index: $index"),
                            pllist=label.toString(),
                            //   labelsss=label ,
                            onSelected: (List<String> checked) =>
                                print("checked: ${checked.toString()}"),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          height: 40,
                          child:MaterialButton(
onPressed: (){
  Navigator.of(context).pop();
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ApplicationPage1()));
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
                                    "Submit",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              )
                          ) ,
                        )
                      ],
                    ),
                  )
                  
              )
          );
        }
    );
  }


  Widget buildToggleCheckbox(personalloanmodel notification) => buildCheckbox(
      notification: notification,
      onClicked: () {
        final newValue = !notification.isChecked;
        setState(() {
          allowNotifications.isChecked = newValue;
          notifications.forEach((notification) {
            notification.isChecked = newValue;
          });
        });
      });
  Widget buildSingleCheckbox(personalloanmodel notification) => buildCheckbox(
    notification: notification,
    onClicked: () {
      setState(() {
        final newValue = !notification.isChecked;
        notification.isChecked = newValue;

        if (!newValue) {
        //  allowNotifications.value = false;
        } else {
          final allow =
          notifications.every((notification) => notification.isChecked);
         // allowNotifications.value = allow;
        }
      });
    },
  );


  Widget buildCheckbox({
    @required personalloanmodel notification,
    @required VoidCallback onClicked,
  }) =>
      ListTile(
        onTap: onClicked,
        leading: Checkbox(
          value: notification.isChecked,
          onChanged: (value) => onClicked(),
        ),
        title: Text(
          notification.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );

  OpenBLDialog(BuildContext context) {
    List<String> labelsss=[""];
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () => Future.value(true),
              child:Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                 child:Container(
                  height: MediaQuery.of(context).size.height / 1.9,
              width: MediaQuery.of(context).size.width / 1.2,

           child: Column(
                    children: [
                      Padding(padding: const EdgeInsets.all(5),
                        child: Text("Business Loan",style: TextStyle(color: Colors.black,fontSize: 18),),),

                      Container(

                     //   decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                        child: CheckboxGroup(

                      //    checked: <String>[ "Both Rente Profile BL",],
                          labels: <String>[
                            "Both Rente Profile BL",
                            "Saving A/C BL",
                            "Without ITR/GST/CA BL",
                            "-1 Credit Scare BL",
                            "Low Banking BL",
                            "Without Vintage BL",
                            "High Profile BL",
                            
                          ],
                          onChange: (bool isChecked, String label, int index) =>
                              print("isChecked: $isChecked   label: $label  index: $index"),
                          //   labelsss=label ,
                          onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 40,
                        child:MaterialButton(

                            onPressed: () {

                              //           if(labelsss.size>0){
                              // scaffoldKey.currentState.showSnackBar(somethingWentWrong);
                              // }else{
                              Navigator.of(context).pop();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ApplicationPage1()));
                              //   }

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
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                        ) ,
                      )
                    ],
                  )

          )

              )
          );
        }
    );
  }

  OpenPRLDialog(BuildContext context) {
    List<String> labelsss=[""];
    return showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
          //    onWillPop: () => Future.value(true),
              child:Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child:Container(
          height: MediaQuery.of(context).size.height / 1,
          width: MediaQuery.of(context).size.width / 1.2,

child:
          Column(
                    children: [
                      Padding(padding: const EdgeInsets.all(5),
                        child: Text("Property Loan",style: TextStyle(color: Colors.black,fontSize: 18),),),

                      Container(

                        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                        child: CheckboxGroup(
//checked:<String> ["Laal Dora LAP",],
                          labels: <String>[
                          "Laal Dora LAP",
                            "Unautorize LAP",
                            "Without Map LAP",
                            "Commercial LAP",
                            "Industrial LAP",
                            "Rasidential LAP",
                            "Cash Income LAP",
                            "Rentol Income LAP",
                            "Khasra/Khatuni LAP",
                            "Form House LAP",
                            "All Type of Plots LAP",
                            "Builder Floor LAP",
                            "Home Loan (ALL TYPE)",
                            "Builder LAP",
                          ],
                          onChange: (bool isChecked, String label, int index) =>
                              print("isChecked: $isChecked   label: $label  index: $index"),
                          //   labelsss=label ,
                          onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 40,
                        child:MaterialButton(

                            onPressed: () {

                              //           if(labelsss.size>0){
                              // scaffoldKey.currentState.showSnackBar(somethingWentWrong);
                              // }else{
                              Navigator.of(context).pop();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ApplicationPage1()));
                              //   }

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
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                        ) ,
                      )
                    ],
                  )
                  )
              )
          );
        }
    );
  }


  OpenInsuranceDialog(BuildContext context) {
    List<String> labelsss=[""];
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () => Future.value(true),
              child:Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child:
          Container(
          height: MediaQuery.of(context).size.height / 2.8,
          width: MediaQuery.of(context).size.width / 1.2,
child:
          Column(
                    children: [
                      Padding(padding: const EdgeInsets.all(5),
                        child: Text("Insurance",style: TextStyle(color: Colors.black,fontSize: 18),),),
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                        child: CheckboxGroup(
                      //    checked:<String> [   "Life Insurance",],
                          labels: <String>[
                           "Life Insurance",
                            "Health Insurance",
                            "Car Insurance",
                            "Term Insurance",
                          ],
                          onChange: (bool isChecked, String label, int index) =>
                              print("isChecked: $isChecked   label: $label  index: $index"),
                          //   labelsss=label ,
                          onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 40,
                        child:MaterialButton(

                            onPressed: () {

                              //           if(labelsss.size>0){
                              // scaffoldKey.currentState.showSnackBar(somethingWentWrong);
                              // }else{
                              Navigator.of(context).pop();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ApplicationPage1()));
                              //   }

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
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                        ) ,
                      )
                    ],
                  )
          )
              )
          );
        }
    );
  }


  OpenBankAccountDialog(BuildContext context) {
   // List<String> labelsss=[""];
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () => Future.value(true),
              child:Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child:
          Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width / 1.2,
child:
          Column(
                    children: [
                      Padding(padding: const EdgeInsets.all(5),
                        child: Text("Bank Account",style: TextStyle(color: Colors.black,fontSize: 18),),),

                      Container(

                        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                        child: CheckboxGroup(
//checked: <String>["Saving A/C",],
                          labels: <String>[
                           "Saving A/C",
                            "Current A/C",
                            "Demat A/C",

                          ],
                          onChange: (bool isChecked, String label, int index) =>
                              print("isChecked: $isChecked   label: $label  index: $index"),
                          //   labelsss=label ,
                          onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 40,
                        child:MaterialButton(

                            onPressed: () {

                              //           if(labelsss.size>0){
                              // scaffoldKey.currentState.showSnackBar(somethingWentWrong);
                              // }else{
                              Navigator.of(context).pop();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ApplicationPage1()));
                              //   }

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
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                        ) ,
                      )
                    ],
                  )
          )
              )
          );
        }
    );
  }


  OpenCreditCardsDialog(BuildContext context) {
    List<String> labelsss=[""];
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () => Future.value(true),
              child:Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child:
          Container(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width / 1.2,
child:
          Column(
                    children: [
                      Padding(padding: const EdgeInsets.all(5),
                        child: Text("Credit Cards",style: TextStyle(color: Colors.black,fontSize: 18),),),

                      Container(

                        decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                        child: CheckboxGroup(

                         // checked: <String>["Self Employee Credit Cards",],
                          labels: <String>[
                          "Self Employee Credit Cards",
                            "Salaried Credit Cards",
                            "Card to Card Credit Cards",
                            "FD Agaist Credit Cards",
                            "Saving A/C on Credit Cards",


                          ],
                          onChange: (bool isChecked, String label, int index) =>
                              print("isChecked: $isChecked   label: $label  index: $index"),
                          //   labelsss=label ,
                          onSelected: (List<String> checked) => print("checked: ${checked.toString()}"),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 40,
                        child:MaterialButton(

                            onPressed: () {

                              //           if(labelsss.size>0){
                              // scaffoldKey.currentState.showSnackBar(somethingWentWrong);
                              // }else{
                              Navigator.of(context).pop();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ApplicationPage1()));
                              //   }

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
                                  "Submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            )
                        ) ,
                      )
                    ],
                  )
          )
              )
          );
        }
    );
  }

  getFeedBack() {
    return Row(
      children: [
        Expanded(
          flex: 50,
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: 30,
                          child: Container(
                            color: blueColor,
                          ),
                        ),
                        Expanded(
                          flex: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                "assets/ka.png", height: 20, width: 20,),
                              SizedBox(height: 100, width: 100,),
                              Image.asset(
                                "assets/ka1.png", height: 20, width: 20,),

                            ],
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment(-0.5, -.6),
                      child: Image.asset("assets/prof.png", height: 60,
                        width: 60,
                        color: Colors.black,),
                    ),
                    Align(
                      alignment: Alignment(0.5, -.7),
                      child: Text(
                        "Name", style: TextStyle(color: Colors.white),),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 50,
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/thanks.png"),
                              fit: BoxFit.fill
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Thanks Telepe Message", style: TextStyle(
                              shadows: shadows, fontWeight: FontWeight.bold),),
                          Text("Name", style: TextStyle(
                              shadows: shadows, fontWeight: FontWeight.bold),),
                          Text("Age", style: TextStyle(
                              shadows: shadows, fontWeight: FontWeight.bold),),
                          Text("Place", style: TextStyle(
                              shadows: shadows, fontWeight: FontWeight.bold),),
                          Text("Loan Amount", style: TextStyle(
                              shadows: shadows, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _getDialog() {
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
            ),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.2,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "You Have to Submit All Correct Details and Documents!",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: blueColor),),
                              ],
                            )
                          ],
                        ),
                      ),

                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text("Open", style: TextStyle(
                            color: violateColor, fontWeight: FontWeight.bold),),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => ApplicationPage1()));


                          // Navigator.push(context, CupertinoPageRoute(builder: (context)=>ApplicationPage5(applicationData: applicationData,)));
                        },
                        color: pinksColor,
                      )
                    ],
                  ),
                ],
              ),
            ),

          );
        }
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel", style: TextStyle(color: Colors.black),),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue", style: TextStyle(color: Colors.black),),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ApplicationPage1()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      title: Text("Information"),
      content: Text("You Have to Submit All Correct Details and Documents!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogs(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel", style: TextStyle(color: Colors.black),),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue", style: TextStyle(color: Colors.black),),
      onPressed: () {
        Navigator.of(context).pop();
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplicationPage1()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      title: Text("Information"),
      content: Text("You Have to Submit All Correct Details and Documents!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );


    getData() async {
      var user = await FirebaseAuth.instance.currentUser();
      await Firestore.instance.collection("FundBookingLoanApplications").where(
          "uid", isEqualTo: user.uid).snapshots().listen((event) {
        event.documentChanges.forEach((element) {
          if (element.type == DocumentChangeType.modified) {
            setState(() {
              isNotification = true;
              notificationCounter++;
            });
          }
        });
      });
    }


    NewyearDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return WillPopScope(
              onWillPop: () => Future.value(true),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child:    Container(
                  height: 500,
                  width: 200,
                  child: Stack(
                    children: [
                      Image(image: new AssetImage("assets/Logo/newyear.gif")),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 430.0, left: 140.0),
                          child: Column(
                            children: [
                              FlatButton(
                                child: Text(
                                  "Apply & Get Loan",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ), color: Colors.blue,
                                onPressed: () {
                                  //  showAlertDialog(context);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ))
                    ],
                  ),
                ),

              ),
            );
          });
    }

    void dispose() {
      _carouselTimer.cancel();
      clientTimer.cancel();
      super.dispose();
    }

    getUser() async {
      var user = await FirebaseAuth.instance.currentUser();
      await Firestore.instance.collection("users").document(user.uid)
          .get()
          .then((val) {
        name = val.data['name'].toString();
      });
      setState(() {
        loading = false;
      });
    }
  }

  getData() async{
    var user=await FirebaseAuth.instance.currentUser();
    await Firestore.instance.collection("FundBookingLoanApplications").where("uid",isEqualTo: user.uid).snapshots().listen((event) {
      event.documentChanges.forEach((element) {
        if(element.type==DocumentChangeType.modified){
          setState(() {
            isNotification=true;
            notificationCounter++;
          });
        }
      });
    });
  }

  NewyearDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future.value(true),
            child: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                height: 500,
                width: 200,
                child: Stack(
                  children: [
                    Image(image: new AssetImage("assets/Logo/newyear.gif")),
                    Padding(
                        padding: const EdgeInsets.only(top:430.0,left: 140.0),
                        child: Column(
                          children: [
                            FlatButton(
                              child: Text(
                                "Apply & Get Loan",
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold),
                              ), color: Colors.blue,
                              onPressed: () {
                                //  showAlertDialog(context);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }

  void dispose() {
    _carouselTimer.cancel();
    clientTimer.cancel();
    super.dispose();
  }

  getUser() async{
    var user=await FirebaseAuth.instance.currentUser();
    await Firestore.instance.collection("users").document(user.uid).get().then((val) {
      name=val.data['name'].toString();
    });
    setState(() {

      loading=false;
    });
  }

getNewYear() {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 450,
        width: 400,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Logo/newyear.gif"),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Column(
              children: [

                Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        FlatButton(
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight
                                .bold),
                          ), color: Colors.blue,
                          onPressed: () {

                          },
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

}