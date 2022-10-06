

import 'package:chat_app_newversion/app/modules/edit_profile/controller/edit_controller.dart';
import 'package:chat_app_newversion/app/utils/constants.dart';
import 'package:chat_app_newversion/app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'content/edit_profile_body.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios_new , color: Colors.black,)),
        title: const Text('Edit Profile' ,style: TextStyle(color: Colors.black),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.save_as_outlined , color: Colors.black,))
        ],
      ) ,
      body: EditProfile() ,
    ) ;
  }
}
