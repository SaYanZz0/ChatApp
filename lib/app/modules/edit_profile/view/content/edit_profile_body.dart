import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:chat_app_newversion/app/controllers/auth_controller.dart';
import 'package:chat_app_newversion/app/modules/edit_profile/controller/edit_controller.dart';
import 'package:chat_app_newversion/app/utils/constants.dart';
import 'package:chat_app_newversion/app/utils/default_button.dart';
import 'package:chat_app_newversion/app/utils/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends GetView<EditProfileController> {
  EditProfile({Key? key}) : super(key: key);
  final authC = Get.find<AuthController>();
  TextEditingController emailC = TextEditingController();
  TextEditingController usernameC = TextEditingController();
  TextEditingController statusC = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.email).get().then((snap) {
      usernameC.text = snap.data()!['name'];
      statusC.text = snap.data()!['status'];
    });
    Get.lazyPut(() => EditProfileController());
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(
            FirebaseAuth.instance.currentUser!.email).snapshots(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else if (snapshot.connectionState == ConnectionState.active) {
            return Padding(
                padding:
                EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Form(
                  key: formkey,
                  child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(50),
                        ),
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
                                child: data!['photourl'] == '' ? Image.asset(
                                    'assets/images/219983.png') : Image.network(
                                    data['photourl']),
                              ),
                            )
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(40),
                        ),
                        TextFormField(
                          controller: emailC,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: data["email"],
                            // If  you are using latest version of flutter then lable text and hint text shown like this
                            // if you r using flutter less then 1.20.* then maybe this is not working properly
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                gapPadding: 5),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                gapPadding: 5),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        TextFormField(
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.name,
                          controller: usernameC,
                          validator: (val) {
                            if (val!.isEmpty && val.length < 4) {
                              return 'Username must be at least 4 characters';
                            }
                            return null;
                          },
                          onSaved: (val) => usernameC.text = val!,
                          decoration: InputDecoration(
                            hintText: data["name"],
                            labelText: "Username",
                            // If  you are using latest version of flutter then lable text and hint text shown like this
                            // if you r using flutter less then 1.20.* then maybe this is not working properly
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                gapPadding: 5),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                gapPadding: 5),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        TextFormField(
                          cursorColor: Colors.black,
                          textInputAction: TextInputAction.done,
                          onSaved: (val) => statusC.text = val!,
                          controller: statusC,
                          decoration: InputDecoration(
                            labelText: "Status",
                            hintText: data["status"],
                            // If  you are using latest version of flutter then lable text and hint text shown like this
                            // if you r using flutter less then 1.20.* then maybe this is not working properly
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                gapPadding: 5),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                gapPadding: 5),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GetBuilder<EditProfileController>(
                                builder: (c) =>
                                c.PickedImg != null ?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: getProportionateScreenHeight(90),
                                      width: getProportionateScreenWidth(120),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: getProportionateScreenHeight(
                                                110),
                                            width: getProportionateScreenHeight(
                                                80),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(100),
                                                image: DecorationImage(
                                                    image: FileImage(
                                                        File(c.PickedImg!.path)
                                                    ),
                                                    fit: BoxFit.cover
                                                )
                                            ),
                                          ),
                                          Positioned(
                                            top: -10,
                                              right: -5,
                                              child: IconButton(onPressed: () {
                                                controller.resetImage();
                                              }, icon: const Icon(Icons.close))
                                          )
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          controller.uploadImage(authC.auth.currentUser!.uid).then((result){
                                            if(result != null){
                                              authC.updatePhotoUrl(result);
                                            }
                                          });
                                        },
                                        child: const Text("Upload" , style: TextStyle(fontWeight: FontWeight.bold),)
                                    )
                                  ],
                                )
                                    : const Text('No Image')
                            ),
                            const Text('Choose an Image'),
                            TextButton(
                              onPressed: () {
                                controller.selectImage();
                              },
                              child: const Text(
                                'Chosen...',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        DefaultButton(text: 'Update', press: () {
                          FirebaseFirestore.instance.collection('users').doc(
                              FirebaseAuth.instance.currentUser!.uid).update({
                            'name': usernameC.text,
                            'status': statusC.text
                          });
                          Get.defaultDialog(
                              title: 'Success',
                              middleText: 'Edit Profile Successfully'
                          );
                        }, width: double.infinity)
                      ]
                  ),
                )
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        }
    );
  }
}
