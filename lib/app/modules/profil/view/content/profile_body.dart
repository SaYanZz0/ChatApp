import 'package:avatar_glow/avatar_glow.dart';
import 'package:chat_app_newversion/app/controllers/auth_controller.dart';
import 'package:chat_app_newversion/app/modules/profil/controllers/profile_controller.dart';
import 'package:chat_app_newversion/app/routes/app_pages.dart';
import 'package:chat_app_newversion/app/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBody extends GetView<ProfileController> {
  ProfileBody({Key? key}) : super(key: key);
  final AuthC = Get.find<AuthController>();
  String? auth = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(auth)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            return Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                Column(
                  children: [
                    AvatarGlow(
                        endRadius: 75,
                        glowColor: Colors.black,
                        duration: const Duration(seconds: 2),
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: (snapshot.data! as dynamic)['photourl'] == '' ? Image.asset('assets/images/219983.png'):Image.network((snapshot.data! as dynamic)['photourl']),
                          ),
                        )
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(20),
                    ),
                    Text(
                      (snapshot.data! as dynamic)['name'],
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(20),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      (snapshot.data! as dynamic)['email'],
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(18)),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(10)),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.note_add_outlined),
                        title: Text(
                          'Update Status',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15)),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward)),
                      ),
                      ListTile(
                        onTap: () {
                          Get.toNamed(RouteClass.getEditProfileScreen());
                        },
                        leading: const Icon(Icons.person),
                        title: Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15)),
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward)),
                      ),
                      ListTile(
                        onTap: () {
                         AuthC.isDark.isTrue? Get.changeTheme(ThemeData.light()) : Get.changeTheme(ThemeData.dark());                          },
                        leading: const Icon(Icons.palette_outlined),
                        title: Text(
                          'Change Theme',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(15)),
                        ),
                        trailing: const Text('Light'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(80),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chat App',
                        style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white54
                                : Colors.black54),
                      ),
                      Text(
                        'v.1.0',
                        style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white54
                                : Colors.black54),
                      )
                    ],
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
