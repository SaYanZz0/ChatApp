
import 'package:flutter/material.dart';

import '../../../../utils/size_config.dart';
import 'login_form.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenWidth(30),),
          Text('Welcome Back' , style: TextStyle(color: Colors.black , fontSize: getProportionateScreenWidth(18)),),
          const Text('Sign in with you email and password or Continue with Google sign in' , textAlign: TextAlign.center),
          SizedBox(height: getProportionateScreenHeight(50),),
          SignInForm()
        ],
      ),
    );
  }
}

