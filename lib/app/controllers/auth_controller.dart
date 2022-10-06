import 'package:chat_app_newversion/app/modules/chat_room/view/chat_room_view.dart';
import 'package:chat_app_newversion/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../data/models/users.dart';
import '../utils/size_config.dart';

class AuthController extends GetxController {
  var isSkipIntro = false.obs;
  var isAuth = false.obs;
  var isDark = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  var user = UserModel().obs;
  late Rx<User?> firebaseUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, (callback) => firstInitialized());
  }

  //IntialScreen
  Future<void> firstInitialized() async {
    await autologin().then((value) {
      if (value) {
        isAuth.value = true;
      }
    });
    await autologin().then((value) {
      if (value) {
        isSkipIntro.value = true;
      }
    });
  }

  Future<bool> skipIntro() async {
    final box = GetStorage();
    if (box.read('skipintro') != null || box.read('skipintro') == true) {
      return true;
    }
    return false;
  }

  // Login
  Future<bool> autologin() async {
    try {
      final isSignedIn = await FirebaseAuth.instance.currentUser;

      if (isSignedIn != null) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  _initializeUserModel(String userId) async {
    user.value = await FirebaseFirestore.instance
        .collection('usersCollection')
        .doc(userId)
        .get()
        .then((doc) => UserModel.fromSnapshot(doc));
  }

  Future<void> getData() async {
  }

  Login(String email, password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        String? userid = result.user!.email;
        _initializeUserModel(userid!);
        Get.offAllNamed(RouteClass.getHomeScreen());
        users.doc(userid).update({
          'lastSignIn': result.user!.metadata.lastSignInTime!.toIso8601String()
        });
        final currentUser = await users.doc(userid).get();
        final currentUserData = currentUser.data() as Map<String, dynamic>;

        user(UserModel.fromJson(currentUserData));

        user.refresh();
      });
    } on FirebaseAuthException catch (e) {
      String message = 'Error Occurred';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }
      Get.snackbar('Sign up', 'User messgae',
          margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(20)),
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'Login Account  Failed',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ));
    } catch (e) {
      print(e);
    }
  }

  SignUp(String email, password, name) async {
    try {
      var caseSearchList = setSearchParam(name);
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        String? userid = result.user!.email;
        _initializeUserModel(userid!);
        FirebaseFirestore.instance.collection('users').doc(userid).set({
          'name': name,
          'email': email,
          'status': '',
          'photourl': '',
          'CreationTime': result.user!.metadata.creationTime!.toIso8601String(),
          'LastSignIn': result.user!.metadata.lastSignInTime!.toIso8601String(),
          'caseSearch': caseSearchList,
        });
        final currentUser = await users.doc(userid).get();
        final currentUserData = currentUser.data() as Map<String, dynamic>;

        user(UserModel.fromJson(currentUserData));

        user.refresh();
      });
      final box = GetStorage();
      if (box.read('skipIntro') != null) {
        box.remove('skipIntro');
      }
      box.write('skipIntro', true);
    } on FirebaseAuthException catch (e) {
      String message = 'Error Occurred';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      Get.snackbar('Sign up', 'User messgae',
          margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(20)),
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            'Account Creation Failed',
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ));
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    auth.signOut();
    Get.offAllNamed(RouteClass.getloginScreen());
  }

  void editProfile(String name, String status, email) {
    users
        .doc(auth.currentUser!.email)
        .update({'name': name, 'status': status, 'email': email});

    user(UserModel(name: name, status: status));
    user.refresh();
  }

  setSearchParam(String name) {
    List<String> SearchList = [];
    String temp = '';
    for (int i = 0; i < name.length; i++) {
      temp += name[i];
      SearchList.add(temp);
    }
    return SearchList;
  }

  void addNewConnection(String friendEmail) async {
    bool flagNewConnection = false;
    var chatId;
    String date = DateTime.now().toIso8601String();
    CollectionReference chats = FirebaseFirestore.instance.collection("chats");
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    var currentUser = auth.currentUser;
    final docChats =
        await users.doc(auth.currentUser!.email).collection("chats").get();

    if (docChats.docs.isNotEmpty) {
      // There is Chats in This Account
      final checkConnection = await users
          .doc(currentUser!.email)
          .collection("chats")
          .where("connection", isEqualTo: friendEmail)
          .get();

      if (checkConnection.docs.isNotEmpty) {
        flagNewConnection = false;

        //chat_id from chats collection
        chatId = checkConnection.docs[0].id;
      } else {
        // There is No Connection Between the Two Users
        flagNewConnection = true;
      }
    } else {
      flagNewConnection = true;
    }

    if (flagNewConnection) {
      // if There is No Connection Between The Users (New Connection between Them)
      final chatsDocs = await chats.where(
        "connections",
        whereIn: [
          [
            currentUser!.email,
            friendEmail,
          ],
          [
            friendEmail,
            currentUser.email,
          ],
        ],
      ).get();

      if (chatsDocs.docs.isNotEmpty) {
        final chatDataId = chatsDocs.docs[0].id;
        final chatsData = chatsDocs.docs[0].data() as Map<String, dynamic>;

        await users.doc(currentUser.email).collection("chats").doc(chatDataId).set({
              "connection": friendEmail,
              "lastTime": chatsData["lastTime"],
              "total_unread": 0,
            }
          );

        chatId = chatDataId;

        user.refresh();
      } else {
        final newChatDoc = await chats.add({
          "connections": [
            auth.currentUser!.email,
            friendEmail,
          ],
        });

        chats.doc(newChatDoc.id).collection("chat");
        final chatDataId = chatsDocs.docs[0].id;

        await users.doc(currentUser.email).collection("chats").doc(chatDataId).set({
              "connection": friendEmail,
              "lastTime": date,
              "total_unread": 0,
        }, SetOptions(merge: true));

        chatId = newChatDoc.id;

        user.refresh();
      }
    }

    print(chatId);

    final updateStatusChat = await chats
        .doc(chatId)
        .collection("chat")
        .where("isRead", isEqualTo: false)
        .where("receiver", isEqualTo: auth.currentUser!.email)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chatId)
          .collection("chat")
          .doc(element.id)
          .update({"isRead": true});
    });

    await users
        .doc(auth.currentUser!.email)
        .collection("chats")
        .doc(chatId)
        .update({"total_unread": 0});

    Get.to(
      const ChatRoomView(),
      arguments: {
        "chat_id": "$chatId",
        "friendEmail": friendEmail,
      },
    );
  }

  void updatePhotoUrl(String url)async{
    users.doc(auth.currentUser!.email).update({
      "photourl": url
    });

    Get.defaultDialog(title: "Success ", middleText: "The Profile Photo has been changed Successfully");
  }
}
