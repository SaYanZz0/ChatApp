import 'package:chat_app_newversion/app/modules/search/controllers/search_controller.dart';
import 'package:chat_app_newversion/app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../controllers/auth_controller.dart';

class SearchBody extends GetView<SearchController> {
  SearchBody({Key? key}) : super(key: key);
  final AuthC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Obx(() => controller.searchList.isEmpty
        ? Center(
            child: Container(
              height: getProportionateScreenHeight(200),
              width: getProportionateScreenWidth(250),
              child: Lottie.asset('assets/images/77218-search-imm.json'),
            ),
          )
        : ListView.builder(
            itemCount: controller.searchList.length,
            itemBuilder: (context, index) {
              final result = controller.searchList[index];
              return ListTile(
                onTap: () {
                  AuthC.addNewConnection(result["email"]);
                },
                contentPadding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10),
                    horizontal: getProportionateScreenHeight(10)),
                title: Text(controller.searchList[index]['name']),
                leading: CircleAvatar(
                  radius: 30,
                  child: result["photourl"] == ''
                      ? Image.asset('assets/images/219983.png')
                      : Image.network(result["photourl"]),
                ),
              );
            },
          ));
  }
}
