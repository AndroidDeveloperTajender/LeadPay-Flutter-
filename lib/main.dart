import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leadgram2/Registration/authentication.dart';
import 'package:leadgram2/Registration/termsandconditions.dart';

//import 'package:telepeapp/HomePage/HomeScreen.dart';

import 'package:leadgram2/colors.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_){
    runApp(MyApp());
  }
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: yellowColor,
        primarySwatch: yellowColor,
       // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen()
      //AuthService().handleAuth(),

      //home: HomeScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    new Future.delayed(Duration(seconds: 3),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthService().handleAuth())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset("assets/5-100.jpg",fit: BoxFit.fill,),
        ),


      ],
    );
  }
}



