// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? userToken;
  String? username;
  String? email;
  String? gender;
  String? phonenumber;
  String? urlprofileimage;
  String? bio;
  int? dealcount;
  int? dealsuccess;
  int? ondeal;
  double? coin;
  double? lastLatitude;
  double? lastLongitude;
  UserModel({
    this.uid,
    this.userToken,
    this.username,
    this.email,
    this.gender,
    this.phonenumber,
    this.urlprofileimage,
    this.bio,
    this.dealcount,
    this.dealsuccess,
    this.ondeal,
    this.coin,
    this.lastLatitude,
    this.lastLongitude
  });
  



  UserModel copyWith({
    String? uid,
    String? userToken,
    String? username,
    String? email,
    String? gender,
    String? phonenumber,
    String? urlprofileimage,
    String? bio,
    int? dealcount,
    int? dealsuccess,
    int? ondeal,
    double? coin,
    double? lastLatitude,
    double? lastLongitude
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      userToken: userToken ?? this.userToken,
      username: username ?? this.username,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phonenumber: phonenumber ?? this.phonenumber,
      urlprofileimage: urlprofileimage ?? this.urlprofileimage,
      bio: bio ?? this.bio,
      dealcount: dealcount ?? this.dealcount,
      dealsuccess: dealsuccess ?? this.dealsuccess,
      ondeal: ondeal ?? this.ondeal,
      coin: coin ?? this.coin,
      lastLatitude: lastLatitude ?? this.lastLatitude,
      lastLongitude: lastLongitude ?? this.lastLongitude
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userToken': userToken,
      'username': username,
      'email': email,
      'gender': gender,
      'phonenumber': phonenumber,
      'urlprofileimage': urlprofileimage,
      'bio': bio,
      'dealcount': dealcount,
      'dealsuccess': dealsuccess,
      'ondeal': ondeal,
      'coin': coin,
      'lastLatitude': lastLatitude,
      'lastLongitude': lastLongitude
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      userToken: map['userToken'] != null ? map['userToken'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      phonenumber: map['phonenumber'] != null ? map['phonenumber'] as String : null,
      urlprofileimage: map['urlprofileimage'] != null ? map['urlprofileimage'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      dealcount: map['dealcount'] != null ? map['dealcount'] as int : null,
      dealsuccess: map['dealsuccess'] != null ? map['dealsuccess'] as int : null,
      ondeal: map['ondeal'] != null ? map['ondeal'] as int : null,
      coin: map['coin'] != null ? map['coin'] as double : null,
      lastLatitude: map['lastLatitude'] != null ? map['lastLatitude'] as double : null,
      lastLongitude: map['lastLongitude'] != null ? map['lastLongitude'] as double : null
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid,userToken:$userToken, username: $username, email: $email, gender: $gender, phonenumber: $phonenumber, urlprofileimage: $urlprofileimage, bio: $bio, dealcount: $dealcount, dealsuccess: $dealsuccess, ondeal: $ondeal, coin: $coin, lastLatitude: $lastLatitude, lastLongitude: $lastLongitude)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.userToken == userToken &&
      other.username == username &&
      other.email == email &&
      other.gender == gender &&
      other.phonenumber == phonenumber &&
      other.urlprofileimage == urlprofileimage &&
      other.bio == bio &&
      other.dealcount == dealcount &&
      other.dealsuccess == dealsuccess &&
      other.ondeal == ondeal &&
      other.coin == coin&&
      other.lastLatitude == lastLatitude &&
      other.lastLongitude == lastLongitude;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      username.hashCode ^
      userToken.hashCode ^
      email.hashCode ^
      gender.hashCode ^
      phonenumber.hashCode ^
      urlprofileimage.hashCode ^
      bio.hashCode ^
      dealcount.hashCode ^
      dealsuccess.hashCode ^
      ondeal.hashCode ^
      coin.hashCode^
      lastLatitude.hashCode^
      lastLongitude.hashCode;
      
  }
  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc):
  uid = doc.data()!["uid"],
  userToken = doc.data()!["userToken"],
  username = doc.data()!["username"],
  gender = doc.data()!["gender"],
  email = doc.data()!["email"],
  phonenumber = doc.data()!["phonenumber"],
  urlprofileimage = doc.data()!["urlprofileimage"],
  bio = doc.data()!["bio"],
  dealcount = doc.data()!["dealcount"],
  dealsuccess = doc.data()!["dealsuccess"],
  ondeal = doc.data()!["ondeal"],
  coin = doc.data()!["coin"],
  lastLatitude = doc.data()!["lastLatitude"],
  lastLongitude = doc.data()!["lastLongitude"];


}
