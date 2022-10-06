import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';
import 'content/login_body.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text('Sign in' , style: TextStyle(fontSize: getProportionateScreenWidth(18) , color: Colors.black) ),
          centerTitle: true,
        ),
        body:const SignInBody()
    );
  }
}
