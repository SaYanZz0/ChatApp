import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  late TextEditingController searchC;
  var searchList = [].obs;
  final current = FirebaseAuth.instance.currentUser!.email;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  void search(String data , email) async {
    searchList = [].obs;
    print("Search : ${data}");
    if(data.isEmpty){
      searchList = [].obs;
    }else{
       var keyNmaeResult = await firestore.collection("users").where("caseSearch" , arrayContains: data.toLowerCase()).where('email' , isNotEqualTo: email).get();
       print("TOTAL DATA : ${keyNmaeResult.docs.length}");
       if(keyNmaeResult.docs.isNotEmpty){
         for(int i = 0 ; i < keyNmaeResult.docs.length ; i++){
             searchList.add(keyNmaeResult.docs[i].data());
         }
         print("Query Result :");
         print(searchList);
       }else{
         print("There is No Data");
       }
    }
    searchList.refresh();
  }

  @override
  void onInit() {
    searchC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }
}