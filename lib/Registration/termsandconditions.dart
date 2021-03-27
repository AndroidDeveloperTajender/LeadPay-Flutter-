import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:leadgram2/Registration/extraterms.dart';
import 'package:leadgram2/colors.dart';

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(var context) {
    return SafeArea(
      child: SingleChildScrollView(
        child:Stack(
      children: [
      Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        "assets/backgroundhome.jpeg",
        fit: BoxFit.fill,
      ),
    ),
    getContents(context),
    ],
    ),
      ),

    );
  }

  getContents(var context) {
    var font1=MediaQuery.of(context).size.height/80;
    var font2=MediaQuery.of(context).size.height/70;
    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/fulllogo.png",
              height: 75,
              width: 75,
            ),
          ],
        ),



        SizedBox(
          height: 20,
        ),



        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Text(
              "\n\n    About Us (KreditPay):-",
              style: TextStyle(color: blueColor, fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 1,
            ),

          ],
        ),
        SizedBox(height: 20,),

        Padding(
          padding: EdgeInsets.all(4),
          child: Text("                           KreditPay is a kind of services provider platform who is providing the online solution for financial Services. KreditPay is A Trade name and App Name. This platform generating leads from the market from different different type of loan application and providing the services to users by help of financial services provider of financial consultant or Bank, this platform generating leads and sale out in the market on cost per basis.",textAlign: TextAlign.justify,style: TextStyle(fontSize: font2),),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "\n     TERMS AND CONDITIONS",
              style: TextStyle(color: blueColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),


        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Text(
              "\n    Dear Users,",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Text("KreditPay is a financial services provider application platform and we have generated only leads on paid basis. Also we are not any bank and nbfc or any kind of Financial Institutions. We cannot provide the loan else we only generate the leads from our platform and we can refer to other banking sector who is interested for your services, we refer leads only to the banking sector financial consultant and financial services provider they can be reach at you and guide for better product servicing.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Eligibility criteria:-",style: TextStyle(fontSize:font1,color: blueColor,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("For any kind of loan application apply user should have very good CIBIL score and credit history in past,should be Indian residents, 21+ ages, and may should salaried or self-employed",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Credit Score Policy:-",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("KreditPay is not authorized to check your credit history so that please don't worry about that, but if we will transfer your lead to any financial sector service provider or Institutions or Financial Service consultant so that they can check your credit history for better servicing for your loan process application, in that case we are not responsible for any kind of credit history up and down and effect.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Emi Free:-",style: TextStyle(fontSize: font1,
                  color: blueColor,fontWeight: FontWeight.bold),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("KreditPay using free free EMI for our application uses we are using free EMI free word is just for a self-attraction line we are not responsible if any user will not get any Moratorium period due to lock down from the bank for any financial sector for any Financial Institutions we are just lead generator so we are is not responsible for any kind of providing services.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Low Cibil Score:-",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Low CIBIL score is also a self-attraction line where we are using in our application platform for attracting to users for getting any loan application should be a good credit history and any applicant cannot claim for any type of our services if they will not getting satisfied.",textAlign: TextAlign.justify,
            style: TextStyle(fontSize: font1),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Application Fee:-",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Application fees and any kind of other fees when is taken by our platform for application that it is clearly nonrefundable amount, if any applicant will not getting there refund back then we are not responsible for refund, our platform and company just a kind of application leads generator in the market we are not responsible for any kind of refunds and application. Also if any user will not get loan status for required loan and calls or replies from our platform or any other Financial Institutions from banks or any other financial service provider then we cannot also responsible.",textAlign: TextAlign.justify,
            style: TextStyle(fontSize: font1),),
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("DATA POLICY:",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("KreditPay will not sell any user database to any third party in the market your database hundred percent secured and safe with us that we can use your contact details and above details with loan providers companies like bank or financial sectors for providing better services to you.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font1),),
        ),


        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Loan Process and Products:-",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("KreditPay is a kind of online way for applies all listed loan products."
              "KreditPay generate user database only and sell to those financial service providers who is interested for provide the services of loans, we are not any bank or financial sector and we will not provide any kind of loan to users in the market.",textAlign: TextAlign.justify,
            style: TextStyle(fontSize: font1),),
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Payments: -",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("KreditPay take some application charges from the user while the applied Loan products, amount charges will filtered genuinely of our users that you are a needy and genuine user and this application charges is not refundable from KreditPay Platform and company",textAlign: TextAlign.justify,
            style: TextStyle(fontSize: font1),),
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Refund Policy: -",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("KreditPay has not any refund policy of the application fees in any circumstances.",textAlign: TextAlign.justify,
            style: TextStyle(fontSize: font1),),
        ),

        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("Mail us at: Support@kreditpay.in",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: MaterialButton(
                onPressed: (){
                  var nav = Navigator.of(context);
                  nav.pop();
               //   Navigator.push(context, CupertinoPageRoute(builder: (context)=>RegistrationPage()));
                },
                child: Text("AGREE",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
                color: yellowColor,
                minWidth: 50,
              ),
            ),
            SizedBox(width: 30,),
          ],
        )
      ],
    );
  }
}
