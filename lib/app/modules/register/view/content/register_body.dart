
import 'package:chat_app_newversion/app/modules/register/view/content/register_form.dart';
import 'package:chat_app_newversion/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenWidth(30),),
          Text('Register Account' , style:TextStyle(fontSize: getProportionateScreenWidth(17) , color: Colors.black) ,textAlign: TextAlign.center,),
          const Text('Compile your Details or continue with social media' ,textAlign: TextAlign.center,),
          SizedBox(height: getProportionateScreenHeight(50),),
          const SignUpForm(),
          SizedBox(height: getProportionateScreenWidth(40),),
          InkWell(
            onTap: (){Get.toNamed(RouteClass.getloginScreen());},
            child: const Text('Already have an Account' , style: TextStyle(color:kPrimaryColor),),
          )
        ],
      ),
    );
  }
}