import 'package:chat_app_newversion/app/modules/introduction/view/content/introduction_body.dart';
import 'package:flutter/material.dart';

class IntroductionView extends StatelessWidget {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: IntroductionBody(),
    );
  }
}
