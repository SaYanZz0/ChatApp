import 'package:chat_app_newversion/app/modules/chat_room/view/content/chat_room_body.dart';
import 'package:chat_app_newversion/app/utils/constants.dart';
import 'package:chat_app_newversion/app/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leadingWidth: getProportionateScreenWidth(75),
          leading: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  )),
              CircleAvatar(
                child: StreamBuilder<DocumentSnapshot<Object?>>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(Get.arguments["friendEmail"])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        var dataF =
                            snapshot.data!.data() as Map<String, dynamic>;
                        if (dataF["photourl"] == "") {
                          return Image.asset("assets/images/219983.png");
                        } else {
                          return Image.network(dataF["photourl"]);
                        }
                      }
                      return Image.asset("assets/images/219983.png");
                    }),
              ),
            ],
          ),
          title: StreamBuilder<DocumentSnapshot<Object?>>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(Get.arguments["friendEmail"])
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var dataF = snapshot.data!.data() as Map<String, dynamic>;
                  return
                      Text(
                        dataF["name"],
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      );
                }
                return
                    Text("is Loading ...",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.w600,
                            color: Colors.white)
                    );
              }),
        centerTitle: false,
      ),
      body: const ChatRoomBody(),
    );
  }
}
