import 'package:chat_app_newversion/app/modules/chat_room/view/chat_room_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final auth = FirebaseAuth.instance.currentUser;

  chatsStream() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(auth!.email)
        .collection("chats")
        .orderBy("lastTime" , descending: true)
        .snapshots();
  }

  goToChatRoom(String chatId, String friendemail) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    CollectionReference chats = FirebaseFirestore.instance.collection("chats");
    final currentMail = FirebaseAuth.instance.currentUser!.email;


    Get.to(
        const ChatRoomView(),
        arguments: {
          "chat_id": chatId,
          "friendEmail": friendemail
        }
    );
    final updateStatusChat = await chats
        .doc(chatId)
        .collection("chat")
        .where("isRead", isEqualTo: false)
        .where("receiver", isEqualTo:currentMail )
        .get();

    updateStatusChat.docs.forEach((element)async{
      await chats
          .doc(chatId)
          .collection("chat")
          .doc(element.id)
          .update({"isRead": true});
    });

    await users
        .doc(currentMail)
        .collection("chats")
        .doc(chatId)
        .update({"total_unread": 0});
  }
}
