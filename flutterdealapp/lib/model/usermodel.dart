// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? username;
  String? email;
  String? gender;
  String? phonenumber;
  String? urlprofileimage;
  String? bio;
  int? dealcount;
  int? dealsucceed;
  int? ondeal;
  UserModel({
    this.uid,
    this.username,
    this.email,
    this.gender,
    this.phonenumber,
    this.urlprofileimage,
    this.bio,
    this.dealcount,
    this.dealsucceed,
    this.ondeal,
  });
  



  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? gender,
    String? phonenumber,
    String? urlprofileimage,
    String? bio,
    int? dealcount,
    int? dealsucceed,
    int? ondeal,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phonenumber: phonenumber ?? this.phonenumber,
      urlprofileimage: urlprofileimage ?? this.urlprofileimage,
      bio: bio ?? this.bio,
      dealcount: dealcount ?? this.dealcount,
      dealsucceed: dealsucceed ?? this.dealsucceed,
      ondeal: ondeal ?? this.ondeal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'email': email,
      'gender': gender,
      'phonenumber': phonenumber,
      'urlprofileimage': urlprofileimage,
      'bio': bio,
      'dealcount': dealcount,
      'dealsucceed': dealsucceed,
      'ondeal': ondeal,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      phonenumber: map['phonenumber'] != null ? map['phonenumber'] as String : null,
      urlprofileimage: map['urlprofileimage'] != null ? map['urlprofileimage'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      dealcount: map['dealcount'] != null ? map['dealcount'] as int : null,
      dealsucceed: map['dealsucceed'] != null ? map['dealsucceed'] as int : null,
      ondeal: map['ondeal'] != null ? map['ondeal'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, username: $username, email: $email, gender: $gender, phonenumber: $phonenumber, urlprofileimage: $urlprofileimage, bio: $bio, dealcount: $dealcount, dealsucceed: $dealsucceed, ondeal: $ondeal)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.username == username &&
      other.email == email &&
      other.gender == gender &&
      other.phonenumber == phonenumber &&
      other.urlprofileimage == urlprofileimage &&
      other.bio == bio &&
      other.dealcount == dealcount &&
      other.dealsucceed == dealsucceed &&
      other.ondeal == ondeal;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      username.hashCode ^
      email.hashCode ^
      gender.hashCode ^
      phonenumber.hashCode ^
      urlprofileimage.hashCode ^
      bio.hashCode ^
      dealcount.hashCode ^
      dealsucceed.hashCode ^
      ondeal.hashCode;
  }
  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc):
  uid = doc.data()!["uid"],
  username = doc.data()!["username"],
  gender = doc.data()!["gender"],
  email = doc.data()!["email"],
  phonenumber = doc.data()!["phonenumber"],
  urlprofileimage = doc.data()!["urlprofileimage"],
  bio = doc.data()!["bio"],
  dealcount = doc.data()!["dealcount"],
  dealsucceed = doc.data()!["dealsucceed"],
  ondeal = doc.data()!["ondeal"];

}
