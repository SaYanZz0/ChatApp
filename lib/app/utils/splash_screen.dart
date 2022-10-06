
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:Get.isDarkMode ? Colors.black : Colors.white ,
        body: Center(
          child:SizedBox(
            width:Get.width * 0.75,
            height:Get.height * 0.75,
            child:Lottie.asset('assets/images/27649-lets-chat.json') ,
          ),
        ),
      ),
    );
  }
}
