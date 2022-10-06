import 'package:chat_app_newversion/app/modules/home/view/contents/home_view_body.dart';
import 'package:chat_app_newversion/app/routes/app_pages.dart';
import 'package:chat_app_newversion/app/utils/constants.dart';
import 'package:chat_app_newversion/app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text('Chats' , style: TextStyle(fontSize: getProportionateScreenWidth(18)),),
        actions: [
          Padding(
            padding:EdgeInsets.only(right: getProportionateScreenWidth(15)),
            child: CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: IconButton(onPressed: () { Get.toNamed(RouteClass.getprofileScreen());}, icon: const Icon(Icons.person)),
            ),
          )
        ],
      ),
      body: const HomeBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
          onPressed:(){
            Get.toNamed(RouteClass.getSearchScreen());
          },
        child: const Icon(Icons.search),
      ),
    );
  }
}
