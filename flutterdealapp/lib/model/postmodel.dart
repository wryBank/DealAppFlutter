// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? pid;
  String? uid;
  String? postby;
  String? title;
  String? detail;
  String? location_item;
  String? location_pick;
  String? postimage;
  double? latitude;
  double? longitude;
  Timestamp? postdate;
  String? profileImage;
  String? takeby;
  bool? isTake;
  double? pricePay;
  PostModel({
    this.pid,
    this.uid,
    this.postby,
    this.title,
    this.detail,
    this.location_item,
    this.location_pick,
    this.postimage,
    this.latitude,
    this.longitude,
    this.postdate,
    this.profileImage,
    this.takeby,
    this.isTake,
    this.pricePay
  });

  PostModel copyWith({
    String? pid,
    String? uid,
    String? postby,
    String? title,
    String? detail,
    String? location_item,
    String? location_pick,
    String? postimage,
    double? latitude,
    double? longitude,
    Timestamp? postdate,
    String? profileImage,
    String? takeby,
    bool? isTake,
    double? picePay,
  }) {
    return PostModel(
      pid: pid ?? this.pid,
      uid: uid ?? this.uid,
      postby: postby ?? this.postby,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      location_item: location_item ?? this.location_item,
      location_pick: location_pick ?? this.location_pick,
      postimage: postimage ?? this.postimage,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      postdate: postdate ?? this.postdate,
      profileImage: profileImage ?? this.profileImage,
      takeby: takeby ?? this.takeby,
      isTake: isTake ?? this.isTake,
      pricePay: picePay ?? this.pricePay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'uid': uid,
      'postby': postby,
      'title': title,
      'detail': detail,
      'location_item': location_item,
      'location_pick': location_pick,
      'postimage': postimage,
      'latitude': latitude,
      'longitude': longitude,
      'postdate': postdate?.millisecondsSinceEpoch,
      'profileImage': profileImage,
      'takeby': takeby,
      'isTake': isTake,
      'pricePay': pricePay,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      pid: map['pid'] != null ? map['pid'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      postby: map['postby'] != null ? map['postby'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
      location_item: map['location_item'] != null ? map['location_item'] as String : null,
      location_pick: map['location_pick'] != null ? map['location_pick'] as String : null,
      postimage: map['postimage'] != null ? map['postimage'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      postdate: map['postdate'] != null ? Timestamp.fromMillisecondsSinceEpoch(map['postdate'] as int) : null,
      profileImage: map['profileImage'] != null ? map['profileImage'] as String : null,
      takeby: map['takeby'] != null ? map['takeby'] as String : null,
      isTake: map['isTake'] != null ? map['isTake'] as bool : null,
      pricePay: map['pricePay'] != null ? map['pricePay'] as double : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(pid: $pid, uid: $uid, postby: $postby, title: $title, detail: $detail, location_item: $location_item, location_pick: $location_pick, postimage: $postimage, latitude: $latitude, longitude: $longitude, postdate: $postdate, profileImage: $profileImage, takeby: $takeby, isTake: $isTake, pricePay: $pricePay)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.pid == pid &&
      other.uid == uid &&
      other.postby == postby &&
      other.title == title &&
      other.detail == detail &&
      other.location_item == location_item &&
      other.location_pick == location_pick &&
      other.postimage == postimage &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.postdate == postdate &&
      other.profileImage == profileImage &&
      other.takeby == takeby &&
      other.isTake == isTake &&
      other.pricePay == pricePay;
  }

  @override
  int get hashCode {
    return pid.hashCode ^
      uid.hashCode ^
      postby.hashCode ^
      title.hashCode ^
      detail.hashCode ^
      location_item.hashCode ^
      location_pick.hashCode ^
      postimage.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      postdate.hashCode ^
      profileImage.hashCode ^
      takeby.hashCode ^
      isTake.hashCode ^
      pricePay.hashCode;
  }
  PostModel.fromJson(Map<String,Object?> json): this(
    pid: json['pid'] as String?,
    uid: json['uid'] as String?,
    postby: json['postby'] as String?,
    title: json['title'] as String?,
    detail: json['detail'] as String?,
    location_item: json['location_item'] as String?,
    location_pick: json['location_pick'] as String?,
    postimage: json['postimage'] as String?,
    latitude: json['latitude'] as double?,
    longitude: json['longitude'] as double?,
    postdate: json['postdate'] as Timestamp?,
    profileImage: json['profileImage'] as String?,
    takeby: json['takeby'] as String?,
    isTake: json['isTake'] as bool?,
    pricePay: json['pricePay'] as double?,
  );
  Map<String,Object?> toJson()=>{
    'pid':pid,
    'uid':uid,
    'postby':postby,
    'title':title,
    'detail':detail,
    'location_item':location_item,
    'location_pick':location_pick,
    'postimage':postimage,
    'latitude':latitude,
    'longitude':longitude,
    'postdate':postdate,
    'profileImage':profileImage,
    'takeby':takeby,
    'isTake':isTake,
    'pricePay':pricePay, 
  };
}
