import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';


class SplashContent extends StatelessWidget {
  SplashContent({
    Key? key, required this.text, required this.image,

  }) : super(key: key);
  final  text, image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Text(
            'FREEDOM',
            style: TextStyle(
                fontSize: getProportionateScreenHeight(40),
                color: kPrimaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
                text , style: const TextStyle(fontSize: 20), textAlign: TextAlign.center,)
          ),
          const Spacer(
          ),
          Image.asset(
            image,
            width:double.infinity,
          ),
        ],
      ),
    );
  }
}