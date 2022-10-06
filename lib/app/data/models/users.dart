import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NAME = "name";
  static const EMAIL = "email";
  static const UID = 'uid';
  static const CREATIONTIME = 'CreationTime';
  static const LASTSIGNINTIME = 'LastSignIn';
  static const PHOTOURL = 'photourl';
  static const STATUS = 'status';

  late String? name;
  late String? email;
  late String? uid;
  late String? keyName;
  late String? creationTime;
  late String? lastSignIn;
  late String? photoUrl;
  late String? status;

  UserModel({this.uid, this.name, this.email , this.photoUrl , this.keyName , this.status, this.creationTime ,this.lastSignIn});

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = (snapshot.data as dynamic)[NAME];
    email = (snapshot.data as dynamic)[EMAIL];
    uid = (snapshot.data as dynamic)[UID];
    creationTime = (snapshot.data as dynamic)[CREATIONTIME];
    lastSignIn = (snapshot.data as dynamic)[LASTSIGNINTIME];
    photoUrl = (snapshot.data as dynamic)[PHOTOURL];
    status = (snapshot.data as dynamic)[STATUS];
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json["uid"],
    name: json["name"],
    keyName: json["keyName"],
    email: json["email"],
    creationTime: json["creationTime"],
    lastSignIn: json["lastSignInTime"],
    photoUrl: json["photoUrl"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "name": name,
    "keyName": keyName,
    "email": email,
    "creationTime": creationTime,
    "lastSignInTime": lastSignIn,
    "photoUrl": photoUrl,
    "status": status,
  };
}
