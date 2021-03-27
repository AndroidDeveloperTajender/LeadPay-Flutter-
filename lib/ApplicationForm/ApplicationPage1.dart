import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leadgram2/ApplicationForm/ApplicationPage3.dart';
import 'package:leadgram2/colors.dart';
import 'PlaceSelect.dart';

final placeController = TextEditingController(text: "Select Place");
String place = "";

class ApplicationPage1 extends StatefulWidget {
  ApplicationPage1({Key key,this.maps}):super(key:key);
  final Map<String,dynamic> maps;

  @override
  _ApplicationPage1State createState() => _ApplicationPage1State();
}

class _ApplicationPage1State extends State<ApplicationPage1> {
  DateTime selectedDate = DateTime.now();
  bool rent = false;
  bool own = true;
  String mobileNum = "";
  String fullname = "";
  String emailid = "";
  String dob = "";
  String rentAmount = "0";
  String married = "";
  String address = "";
  final dateController = TextEditingController(text: "DOB");
  final marriageController = TextEditingController(text: "Marriage Status");
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AssetImage background;
  var salary=true;
  var businessman=false;
  var student=false;
//  var working=false;
 // var notworking=false;
  String companyName="";
  String experience="";
  String income="";
  String grosssalary="";
  String persontypes="";
  String grosssalaryandincome="";
//  String loanpurpose="";
  String persontype="";
  String company="";
  String experienced="";
  String monthlyincome="";


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "assets/Intro/commonbg.png",
                  fit: BoxFit.cover,
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logo.png",
                          height: 80,
                          width: 100,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/step1.png",
                          height:  MediaQuery.of(context).size.height / 6.5,
                          width:  MediaQuery.of(context).size.width / 1,
                        ),
                      ],
                    ),

                 /*   new Padding(
                      padding: const EdgeInsets.all(5.0),

                      child: Center(
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 30,
                                  width: MediaQuery.of(context).size.width / 1.6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle, color: pinksColor),
                                        child: Center(
                                          child: Text("1",
                                            style: TextStyle(color: Colors.white),),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          color: greyColor,
                                          height: 2,
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle, color: violateColor),
                                        child: Center(
                                          child: Text("2",
                                            style: TextStyle(color: Colors.white), ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          color: greyColor,
                                          height: 2,
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle, color: violateColor),
                                        child: Center(
                                          child: Text("3",
                                            style: TextStyle(color: Colors.white),),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          color: greyColor,
                                          height: 2,
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle, color: violateColor),
                                        child: Center(
                                          child: Text("4",
                                            style: TextStyle(color: Colors.white),),
                                        ),
                                      ),



                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Personal/\nIncome",
                                        style: TextStyle(
                                            color: blueColor, fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center),

                                    Text("Loan\nSelect",
                                        style: TextStyle(fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center),
                                    Text("Verify/\nAccount",
                                        style: TextStyle(fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center),
                                    Text("Get Loan",
                                        style: TextStyle(fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),*/
                    Padding(padding: const EdgeInsets.only(left: 20,right: 20),child:
                    Card(
                      elevation: 8,
                      shape:   RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child:Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child:Padding(
                              padding: const EdgeInsets.all(8.0),

                              child:Column(
                                children: [
                                  Text(
                                    "Application Form",
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: TextFormField(
                                        maxLines: 1,
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        onChanged: (val) {
                                          setState(() {
                                            fullname = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: lightblackColor),
                                                borderRadius: BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: lightblackColor),
                                                borderRadius: BorderRadius.circular(10)),
                                            hintText: "  Full Name",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: TextFormField(
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        onChanged: (val) {
                                          setState(() {
                                            mobileNum = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: lightblackColor),
                                                borderRadius: BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: lightblackColor),
                                                borderRadius: BorderRadius.circular(10)),
                                            hintText: "  Mobile Number",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: TextFormField(
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        onChanged: (val) {
                                          setState(() {
                                            emailid = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: lightblackColor),
                                                borderRadius: BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: lightblackColor),
                                                borderRadius: BorderRadius.circular(10)),
                                            hintText: "  Email ID",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                  /*     SizedBox(
                                    width: MediaQuery.of(context).size.width / 1.5,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(top: 8.0, right: 4),
                                            child: Container(
                                              height: 50,
                                              child: InkWell(
                                                  onTap: () => _selectDate(context),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: greyColor,
                                                        borderRadius:
                                                        BorderRadius.circular(10)),
                                                    height: 45,
                                                    width: 150,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 80,
                                                            child: Center(
                                                                child: Text(
                                                                  dateController.text,
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight.bold),
                                                                )
                                                            )
                                                        ),
                                                        Expanded(
                                                            flex: 50,
                                                            child: Icon(Icons.calendar_today)
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0, left: 4),
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width / 2.5,
                                              child: InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PlaceSelect()));
                                                  },
                                                  child: Container(

                                                    decoration: BoxDecoration(

                                                        color: greyColor,
                                                        borderRadius:
                                                        BorderRadius.circular(10)),
                                                    height: 45,
                                                    width: 150,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 80,
                                                            child: Center(
                                                                child: Text(
                                                                  placeController.text,
                                                                  style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontWeight:
                                                                      FontWeight.bold),
                                                                ))),
                                                        Expanded(
                                                            flex: 20,

                                                            child: Icon(

                                                                Icons.keyboard_arrow_down))
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                 StatefulBuilder(
                                    builder: (BuildContext context, StateSetter SetState) {
                                      return SizedBox(
                                        width: MediaQuery.of(context).size.width / 1.5,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                  height: 50,
                                                  width:
                                                  MediaQuery.of(context).size.width / 2.5,
                                                  child: InkWell(
                                                      onTap: getMarriedDialog,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: greyColor,
                                                            borderRadius:
                                                            BorderRadius.circular(10)),
                                                        height: 45,
                                                        width: 150,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                flex: 80,
                                                                child: Center(
                                                                    child: Text(
                                                                      marriageController.text,
                                                                      style: TextStyle(
                                                                          fontSize: 12,
                                                                          fontWeight:
                                                                          FontWeight.bold),
                                                                    ))),
                                                            Expanded(
                                                                flex: 20,
                                                                child: Icon(Icons
                                                                    .keyboard_arrow_down))
                                                          ],
                                                        ),
                                                      ))),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(6.0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                          materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                          value: rent,
                                                          onChanged: (bool val) {
                                                            setState(() {
                                                              rent = val;
                                                              own = false;
                                                            });
                                                          },
                                                          activeColor: lightblackColor,
                                                          checkColor: Colors.white,
                                                        ),
                                                        Text("Rented"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Checkbox(
                                                          materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                          value: own,
                                                          activeColor: lightblackColor,
                                                          checkColor: Colors.white,
                                                          onChanged: (bool val) {
                                                            setState(() {
                                                              own = val;
                                                              rent = false;
                                                            });
                                                          },
                                                        ),
                                                        Text("Owned"),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  (rent)
                                      ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: TextFormField(
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        onChanged: (val) {
                                          setState(() {
                                            rentAmount = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: lightblackColor),
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                BorderSide(color: lightblackColor),
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            hintText: "  Monthly Rent",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  )
                                      : Container(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 80,
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: TextFormField(
                                        maxLines: 2,
                                        validator: (val) {
                                          if (val.isEmpty) {
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        onChanged: (val) {
                                          setState(() {
                                            address = val;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: lightblackColor),
                                                borderRadius: BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: lightblackColor),
                                                borderRadius: BorderRadius.circular(10)),
                                            hintText: "  Address",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 80,
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child:      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Checkbox(
                                            value: salary,
                                            onChanged: (val){
                                              setState(() {
                                                salary=val;
                                                background=AssetImage("assets/teelpe15.jpg");
                                                businessman=false;
                                                student=false;
                                                //  notworking=false;
                                                //    working=false;
                                              });
                                            },
                                            activeColor: lightblackColor,
                                            checkColor: Colors.white,
                                          ),
                                          Text("Salary"),
                                          Checkbox(
                                            value: businessman,
                                            onChanged: (val){
                                              setState(() {
                                                businessman=val;
                                                background=AssetImage("assets/teelpe16.jpg");
                                                salary=false;
                                                student=false;
                                                //    notworking=false;
                                                //    working=false;
                                              });
                                            },
                                            activeColor: lightblackColor,
                                            checkColor: Colors.white,
                                          ),
                                          Text("Businessman"),

                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: TextFormField(
                                        validator: (val){
                                          if(val.isEmpty){
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        onChanged: (val) {
                                          setState(() {
                                            companyName = val;
                                          });

                                          /*
                                                    if (!notworking) {
                                                      setState(() {
                                                        companyName = val;
                                                      });
                                                    }
                                                    else {
                                                      setState(() {
                                                        income = val;
                                                      });
                                                    }

                                                     */
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: lightblackColor
                                                ),
                                                borderRadius: BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: lightblackColor
                                                ),
                                                borderRadius: BorderRadius.circular(10)),
                                            hintText:  "  Company Name",
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: TextFormField(
                                        validator: (val){
                                          if(val.isEmpty){
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        onChanged: (val){
                                          setState(() {
                                            experience=val;
                                          });

                                          /*
                                                    if(!notworking){
                                                      setState(() {
                                                        experience=val;
                                                      });
                                                    }
                                                    else{
                                                      setState(() {
                                                        fatherage=val;
                                                      });
                                                    }

                                                     */
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: lightblackColor
                                                ),
                                                borderRadius: BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: lightblackColor
                                                ),
                                                borderRadius: BorderRadius.circular(10)),
                                            hintText: (salary )?"  Total Work Experience":(businessman)?("  Company Work Experience"):null,
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width / 1.5,
                                      child: TextFormField(
                                        validator: (val){
                                          if(val.isEmpty){
                                            return "Required";
                                          }
                                          return null;
                                        },
                                        onChanged: (val){
                                          if(salary){
                                            setState(() {
                                              grosssalaryandincome=val;
                                            });
                                          }
                                          if(businessman){
                                            setState(() {
                                              grosssalaryandincome=val;
                                            });
                                          }

                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: lightblackColor
                                                ),
                                                borderRadius: BorderRadius.circular(10)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: lightblackColor
                                                ),
                                                borderRadius: BorderRadius.circular(10)),
                                            hintText: (salary )?"  Gross Salary":(businessman)?("  Monthly Income"):null,
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.bold,),
                                            filled: true,
                                            fillColor: Colors.white),
                                      ),
                                    ),
                                  ),*/
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        height: 40,
                                        child:MaterialButton(

                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => ApplicationPage1()));
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
                                                  "Reset",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),
                                                ),
                                              ),
                                            )
                                        ) ,
                                      ),

                                      SizedBox(
                                        width: 120,
                                        height: 40,
                                        child:  MaterialButton(

                                            onPressed: () {
                                              bool goAhead = true;
                                              if (marriageController.text == "Marriage Status" ||
                                                  placeController.text == "Select Place" ||
                                                  dateController.text == "DOB") {
                                                goAhead = false;
                                                scaffoldKey.currentState.showSnackBar(SnackBar(
                                                  content: Text("Please fill all details!"),
                                                ));
                                              }

                                              /* if (rentAmount == "0") {
                                              rentAmount = "Owned";
                                            }*/

                                              if (formKey.currentState.validate()) {

                                                var details;

                                                /*   if(salary){
                                                persontypes="Salaried Person";
//                                            var info;
//                                            info['persontype']="Salaried Person";
//                                            info['company']=companyName;
//                                            info['experience']=experience;
//                                            info['grosssalary']=grosssalary;
//                                            details=info;
                                              }
                                        if(working){
                                          var info=widget.map;
                                          info['persontype']="Working Student";
                                          info['company']=companyName;
                                          info['experience']=experience;
                                          info['grosssalary']=grosssalary;
                                          details=info;
                                        }
                                        */
                                                /*
                                              if(businessman){
                                                // var info=widget.map;

                                                persontypes="Businessman";
//                                            var info;
//                                            info['persontypes']="Businessman";
//                                            info['company']=companyName;
//                                            info['experience']=experience;
//                                            info['monthlyincome']=income;
//                                            details=info;

                                              }*/


                                                Navigator.push(
                                                    context,
                                                    CupertinoPageRoute(
                                                        builder: (context) => ApplicationPage3(
                                                            map: {

                                                              "fullname": fullname,
                                                              "mobilenum": mobileNum,
                                                              "emailid": emailid,
                                                              "address": address,
                                                            }
                                                        )));
                                              }   },
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
                                                  "Next",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),
                                                ),
                                              ),
                                            )
                                        ),
                                      )

                                      ,
                                    ],
                                  )
                                ],
                              ) ,
                            ),
                          )) ,
                    )  ,)

                     ,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
        );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
        dob = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  getMarriedDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    groupValue: married,
                    value: "Married",
                    title: Text("Married"),
                    onChanged: (val) {
                      setState(() {
                        married = val;
                        marriageController.text = val;
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                  RadioListTile(
                    groupValue: married,
                    value: "Not Married",
                    title: Text("Not Married"),
                    onChanged: (val) {
                      setState(() {
                        married = val;
                        marriageController.text = val;
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                ],
              ));
        });
  }
}
