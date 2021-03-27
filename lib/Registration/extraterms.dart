

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../colors.dart';

class ExtraTermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(var context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/9.png",
              fit: BoxFit.cover,
            ),
          ),
          getContents(context),
        ],
      ),
    );
  }

  getContents(var context) {
    var font1=MediaQuery.of(context).size.height/120;
    var font2=MediaQuery.of(context).size.height/130;
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(
              flex: 2,
            ),
            Text(
              "EXTRA PRIVACY POLICY",
              style: TextStyle(color: blueColor, fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 1,
            ),
            Image.asset(
              "assets/teelpe15.png",
              height: 60,
              width: 60,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(
              flex: 1,
            ),
            Text(
              "1. All loan Products",
              style: TextStyle(color: blueColor, fontWeight: FontWeight.bold,fontSize: font1),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("                       Telepe.in having online way for apply all listed loan products online in easy way. Users have all option at one app.\nTelepe will generate user data base only and sell to their financial service providers who is interested to buy the genuine leads. Telepe.in is not an any Bank/Nbfc/financial institution and will not provide any loan direct to users.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("2. WHY TAKE PAYMENTS: ",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("Telepe take some application charges from the users while they apply them Telepe can judge that you are a needy and genuine user.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("3. THIS PAYMENT IS REFUNDABLE: ",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("“No, the application fees are not refundable in any circumstance/way.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("4.WHAT IS THE MEANING OF “INSTANT”: ",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("“Instant” meaning at this platform that user can apply any loan instant basis online by our Telepe app only. Here is does not mean that Telepe transfer the loan amount instantly in the account.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("5. STUDENT LOAN PROCESS: ",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("Students can apply this loan application on the behalf of him/her parents basis only. If students have family income as per bank requirements then they can apply and can get a call from service provider if any finance services provider may interest in your application. Telepe is not responsible for any kind of loan rejection / refund / calls / mails and other services. Telepe is only a lead generating platform.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("6. BUSINESS LEADS:",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("                                 If any financial company or service provider or any banker purchase any package from the Telepe for leads.\nProcess then you have to know about some rules/terms:\ni.	Telepe client take any lead success guarantee. This is depends on your convenience Skills/Products/Services…etc.\nii.	Any leads can sell here (Telepe) by many times.\niii.	Any refund process will not be accepted once package sell by Telepe.\niv.	Lead exchange only by Telepe after lead verification if needed.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("7. ELIGIBILITY CRITERIA:",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("I.	Resident Indian citizen only.\nII.	Salaried person ages 23+ years-58 years.\nIII.	Business person ages 23+ years-62 years.\nIV.	Good cibil score 700+.\nV.	No defaults / write off required.\nVI.	Maintain proper documents (all).\nVII.	PAN + Aadhar mandatory",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("8. BAD/LOW CIBIL/CREDIT SCORE: ",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("Telepe will not check any cibil score or credit history by online or any other way. But after user leads sell bank or any other 3rd party can check cibil / credit history so in that case Telepe is not responsible.\nWe are an online application generator for all type of credit history users and they can apply the loan. Including bad cibil / credit history users.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("SUGGESTION FOR LOW/BAD CIBIL: ",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("Please mention your credit / cibil history. If you have (or any other user) bad history of cibil / credit, then please do not apply for any loan.\nTelepe using line “bad / low cibil score” only to capture the market and for sales generation only. Telepe will not take only loan related responsibility for those users.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("9. PRIVATE LOAN/DAILY BASIS LOAN: ",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text("Telepe will refer to those customers / users who are interested for pay day/ daily basis/ private loan. If any users will RCV calls / MSG or any fund, then Telepe is not responsible.",textAlign: TextAlign.justify,
          style: TextStyle(fontSize: font2),),
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
                  nav.pop();
                },
                child: Text("AGREE",style: TextStyle(color: blueColor,fontWeight: FontWeight.bold,fontSize: font1),),
                color: yellowColor,
                minWidth: 100,
              ),
            ),
            SizedBox(width: 30,),
          ],
        )
      ],
    );
  }
}
