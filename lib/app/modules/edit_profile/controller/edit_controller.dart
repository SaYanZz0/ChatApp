
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController{
  TextEditingController emailC = TextEditingController();
  TextEditingController usernameC = TextEditingController();
  TextEditingController statusC = TextEditingController();
  late ImagePicker imagePic;

  XFile? PickedImg = null;

  FirebaseStorage storage = FirebaseStorage.instance;


  uploadImage(String uid)async{
    Reference storageRef = storage.ref("$uid.png");

    File file = File(PickedImg!.path);

    try{
      await storageRef.putFile(file);
      final photoUrl = await storageRef.getDownloadURL();
      resetImage();
      return photoUrl;
    }catch (err){
      print(err);
      return null;
    }
  }

  void selectImage()async{
    try{
      final dataImage = await imagePic.pickImage(source: ImageSource.gallery);
      if(dataImage != null){
        print(dataImage.name);
        print(dataImage.path);
        PickedImg = dataImage;
      }
    }catch (e){
      print(e);
      PickedImg = null;
      update();
    }
  }

  void resetImage(){
    PickedImg = null;
    update();
  }


  @override
  void onInit() {
    emailC = TextEditingController();
    usernameC= TextEditingController();
    statusC = TextEditingController();
    imagePic = ImagePicker();
    super.onInit();
  }

  @override
  onClose(){
    emailC.dispose();
    usernameC.dispose();
    statusC.dispose();
    super.onClose();
  }
}