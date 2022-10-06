
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'content/register_body.dart';


class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios_new ,color: Colors.black,)),
        title: const Text('Sign Up' , style: TextStyle(color: Colors.black),),
        centerTitle: true,
      ),
      body: const SignUpBody(
      ),
    );
  }
}
