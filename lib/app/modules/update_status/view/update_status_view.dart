import 'package:chat_app_newversion/app/modules/update_status/controller/update_status_controller.dart';
import 'package:chat_app_newversion/app/utils/constants.dart';
import 'package:chat_app_newversion/app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateStatusView extends GetView<UpdateStatusController> {
  const UpdateStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Text(
          'Update Status',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20) , vertical: getProportionateScreenWidth(60)),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.black,
                decoration: InputDecoration(
              hintText: 'Enter a Status ',
              labelStyle: TextStyle(
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
              border: const OutlineInputBorder(
              ),
              focusedBorder: const OutlineInputBorder(
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(10),
              ),
            )),
            SizedBox(height: getProportionateScreenHeight(10),),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary:kPrimaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal:getProportionateScreenWidth(20),
                      vertical:getProportionateScreenWidth(10),
                    ),
                  ),
                  child: const Text('Update' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }
}
