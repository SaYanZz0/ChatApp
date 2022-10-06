import 'package:chat_app_newversion/app/modules/search/controllers/search_controller.dart';
import 'package:chat_app_newversion/app/modules/search/view/content/search_body.dart';
import 'package:chat_app_newversion/app/utils/constants.dart';
import 'package:chat_app_newversion/app/utils/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    Get.lazyPut(()=>SearchController());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:Size.fromHeight(getProportionateScreenHeight(160)),
          child:AppBar(
            backgroundColor: kPrimaryColor,
            leading: IconButton(onPressed: (){Get.back();}, icon:const Icon(Icons.arrow_back_ios_new)),
            title: const Text('Search'),
            centerTitle: true,
            flexibleSpace: Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20) , vertical: getProportionateScreenHeight(30)),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextFormField(
                  controller: controller.searchC,
                  onChanged: (value) {
                    controller.search(value , FirebaseAuth.instance.currentUser!.email);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        width: 1,
                      ),
                    ),
                    hintText: "Search new friend here..",
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                    suffixIcon: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {},
                      child:const Icon(
                        Icons.search,
                        color:kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
      ),
      body: SearchBody(),
    );
  }
}
