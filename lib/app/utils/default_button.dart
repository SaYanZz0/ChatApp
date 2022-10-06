import 'package:chat_app_newversion/app/utils/size_config.dart';
import 'package:flutter/material.dart';

import 'constants.dart';



class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key, required this.text, required this.press,required this.width,
  }) : super(key: key);
  final text;
  final press;
  final width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: getProportionateScreenHeight(60),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ))
          ),
          onPressed:press,
          child: Text(text , style: TextStyle(fontSize: getProportionateScreenWidth(18)),)
      ),
    );
  }
}