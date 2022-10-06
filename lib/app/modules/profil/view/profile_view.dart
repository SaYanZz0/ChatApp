import 'package:chat_app_newversion/app/controllers/auth_controller.dart';
import 'package:chat_app_newversion/app/modules/profil/view/content/profile_body.dart';
import 'package:chat_app_newversion/app/utils/constants.dart';
import 'package:chat_app_newversion/app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back_ios_new , color: Colors.black,)),
        actions: [
          IconButton(onPressed: (){AuthController().signOut();}, icon:const Icon(Icons.logout , color: Colors.black,))
        ],
      ),
      body: ProfileBody(),
    );
  }
}
