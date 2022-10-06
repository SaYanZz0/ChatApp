
import 'package:chat_app_newversion/app/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class HomeBody extends GetView<HomeController> {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>HomeController());
    return  StreamBuilder<QuerySnapshot>(
      stream: controller.chatsStream(),
      builder: (context, snapshot1) {
        if(snapshot1.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (snapshot1.hasData && snapshot1.data != null) {
          var listDocsChats =snapshot1.data!.docs;
          print("List of Connections");
          print(listDocsChats);
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: listDocsChats.length,
            itemBuilder: (context, index) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users").doc(listDocsChats[index]["connection"]).snapshots(),
                builder: (context, snapshot2) {
                  print("List Docs Chats");
                  print(listDocsChats[index]["connection"]);
                  if(snapshot2.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else {
                    return
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(
                        horizontal:getProportionateScreenWidth(20),
                        vertical: getProportionateScreenWidth(10),
                      ),
                      onTap: (){
                          controller.goToChatRoom(listDocsChats[index].id ,listDocsChats[index]["connection"] );
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.black26,
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(100),
                          child: (snapshot2.data as dynamic)["photourl"] == ""
                              ? Image.asset(
                            "assets/images/219983.png",
                            fit: BoxFit.cover,
                          )
                              : Image.network(
                            "${(snapshot2.data as dynamic)["photourl"]}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        "${(snapshot2.data as dynamic)["name"]}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: listDocsChats[index]
                      ["total_unread"] ==
                          0
                          ? const SizedBox()
                          : Chip(
                        backgroundColor: Colors.red[900],
                        label: Text(
                          "${listDocsChats[index]["total_unread"]}",
                          style: const TextStyle(
                              color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
              );
            } ,
          );
        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
