import 'dart:async';

import 'package:chat_app_newversion/app/modules/chat_room/controllers/chat_room_controller.dart';
import 'package:chat_app_newversion/app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/size_config.dart';

class ChatRoomBody extends GetView<ChatRoomController> {
  const ChatRoomBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ChatRoomController());
    final current = FirebaseAuth.instance.currentUser!.email;
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection("chats")
                  .doc(Get.arguments["chat_id"])
                  .collection("chat")
                  .orderBy("time")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var alldata = snapshot.data!.docs;
                  Timer(Duration.zero, () {
                    controller.scrollC
                        .jumpTo(controller.scrollC.position.maxScrollExtent);
                  });

                  return ListView.builder(
                      controller: controller.scrollC,
                      itemCount: alldata.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              Text(
                                alldata[index]["groupTime"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              ItemChat(
                                msg: alldata[index]["msg"],
                                isSender: alldata[index]["sender"] == current
                                    ? true
                                    : false,
                                time: alldata[index]["time"],
                              )
                            ],
                          );
                        } else {
                          if (alldata[index]["groupTime"] ==
                              alldata[index - 1]["groupTime"]) {
                            return ItemChat(
                              msg: alldata[index]["msg"],
                              isSender: alldata[index]["sender"] == current
                                  ? true
                                  : false,
                              time: alldata[index]["time"],
                            );
                          } else {
                            return Column(
                              children: [
                                Text(
                                  "${alldata[index]["groupTime"]}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ItemChat(
                                  msg: "${alldata[index]["msg"]}",
                                  isSender: alldata[index]["sender"] == current
                                      ? true
                                      : false,
                                  time: "${alldata[index]["time"]}",
                                ),
                              ],
                            );
                          }
                        }
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
        Row(
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                  vertical: getProportionateScreenWidth(10)),
              child: TextFormField(
                controller: controller.chatC,
                focusNode: controller.focusNode,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.newchat(controller.chatC.text,
                              Get.arguments as Map<String, dynamic>);
                          controller.chatC.text = '';
                        },
                        icon: const Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        )),
                    hintText: "Write Something To your friend !",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            )),
          ],
        ),
      ],
    );
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat(
      {Key? key, required this.isSender, required this.msg, required this.time})
      : super(key: key);
  final bool isSender;
  final String msg;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(10),
          vertical: getProportionateScreenWidth(5)),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(5),
                vertical: getProportionateScreenWidth(5)),
            decoration: BoxDecoration(
                borderRadius: isSender
                    ? const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)
                )
                    : const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                color: isSender? kPrimaryColor : kSecondaryColor.withOpacity(0.1)
            ),
            child: Text(msg),
          ),
          Text(
            DateFormat.jm().format(DateTime.parse(time)),
            style: TextStyle(
                color: kSecondaryColor,
                fontSize: getProportionateScreenWidth(10)),
          )
        ],
      ),
    );
  }
}
