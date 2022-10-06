import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatRoomController extends GetxController {
  int total_unread = 0;
  late TextEditingController chatC;
  late ScrollController scrollC;
  late FocusNode focusNode;
  var date = DateTime.now().toIso8601String();
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  final currentUser = FirebaseAuth.instance.currentUser!.email;

  Future<void> newchat( String chat , Map<String , dynamic> argument) async {
    CollectionReference chats = FirebaseFirestore.instance.collection("chats");

    chats.doc(argument["chat_id"]).collection("chat").add({
      "sender":currentUser ,
      "receiver":argument["friendEmail"] ,
      "msg": chat,
      "time":date,
      "isRead": false,
      "groupTime": DateFormat.yMMMMd("en_US").format(DateTime.parse(date))

    });
    
    Timer(
        Duration.zero, () {scrollC.jumpTo(scrollC.position.maxScrollExtent); }
    );
    await users
        .doc(currentUser)
        .collection("chats")
        .doc(argument["chat_id"])
        .update({
      "lastTime": date,
    });

    final checkChatsFriend = await users
        .doc(argument["friendEmail"])
        .collection("chats")
        .doc(argument["chat_id"])
        .get();

    if(checkChatsFriend.exists){
      final checkTotalUnread = await chats.doc(argument["chat_id"]).collection("chat").where("isRead" ,isEqualTo: false).where("sender" , isEqualTo: currentUser).get();
      total_unread = checkTotalUnread.docs.length;

      await users
          .doc(argument["friendEmail"])
          .collection("chats")
          .doc(argument["chat_id"])
          .update({"lastTime": date, "total_unread": total_unread});
    }else{
      // Not Exist on Friend DataBase !!

      await users
          .doc(argument["friendEmail"])
          .collection("chats")
          .doc(argument["chat_id"])
          .set({
        "connection":currentUser,
        "lastTime": date,
        "total_unread": 1,
      });
    }
  }


  @override
  void onInit() {
    chatC = TextEditingController();
    scrollC = ScrollController();
    focusNode = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    chatC.dispose();
    scrollC.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
