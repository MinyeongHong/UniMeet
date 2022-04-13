import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_meet/app/data/model/firestore_keys.dart';

class AppUserModel {
  String? uid;
  bool? auth;
  String? gender;
  String? name;
  int? age;
  String? mbti;
  String? university;
  String? major;
  String? nickname;
  bool? black;
  List<dynamic>? blackList;
  String? token;
  String? imagePath;
  String? phone;
  List<dynamic>? chatroomList;
  // DocumentReference? reference;

  AppUserModel(
      {this.uid,
      this.auth,
      this.gender,
      this.name,
      this.age,
      this.mbti,
      this.university,
      this.major,
        this.nickname,
        this.black,
      this.blackList,
        this.token,
      this.imagePath,
      this.phone,
      this.chatroomList,
      // this.reference,
      });

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      uid: json[KEY_USER_UID] == null ? '' : json[KEY_USER_UID] as String,
      auth: json[KEY_USER_AUTH] == null ? false : json[KEY_USER_AUTH] as bool,
      gender: json[KEY_USER_GENDER] == null ? 'MAN' : json[KEY_USER_GENDER] as String,
      name: json[KEY_USER_NAME] == null ? '' : json[KEY_USER_NAME] as String,
      age: json[KEY_USER_AGE] == null ? 20 : json[KEY_USER_AGE] as int,
      mbti: json[KEY_USER_MBTI] == null ? '' : json[KEY_USER_MBTI] as String,
      nickname: json[KEY_USER_NICKNAME]== null ? '' : json[KEY_USER_NICKNAME] as String,
      university:
          json[KEY_USER_UNIVERSITY] == null ? '' : json[KEY_USER_UNIVERSITY] as String,
      major: json[KEY_USER_MAJOR] == null ? '' : json[KEY_USER_MAJOR] as String,
      black: json[KEY_USER_BLACK] == null ? false : json[KEY_USER_BLACK] as bool,
      blackList: json[KEY_USER_BLACKLIST] == null ? [] : json[KEY_USER_BLACKLIST] as List,
      token: json[KEY_USER_TOKEN] == null ? '' : json[KEY_USER_TOKEN] as String,
      imagePath: json[KEY_USER_IMAGEPATH] == null ? '' : json[KEY_USER_IMAGEPATH] as String,
      phone: json[KEY_USER_PHONE] == null ? '' : json[KEY_USER_PHONE] as String,
      chatroomList:
          json[KEY_USER_CHATROOMLIST] == null ? [] : json[KEY_USER_CHATROOMLIST] as List,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      KEY_USER_UID: uid,
      KEY_USER_AUTH: auth,
      KEY_USER_GENDER: gender,
      KEY_USER_NAME: name,
      KEY_USER_AGE: age,
      KEY_USER_MBTI: mbti,
      KEY_USER_UNIVERSITY: university,
      KEY_USER_MAJOR: major,
      KEY_USER_NICKNAME: nickname,
      KEY_USER_BLACK: black,
      KEY_USER_BLACKLIST: blackList,
      KEY_USER_TOKEN: token,
      KEY_USER_IMAGEPATH: imagePath,
      KEY_USER_PHONE: phone,
      KEY_USER_CHATROOMLIST: chatroomList,
    };
  }

  AppUserModel copyWith({
    String? uid,
    bool? auth,
    String? gender,
    String? name,
    int? age,
    String? mbti,
    String? university,
    String? major,
    String? nickname,
    bool? black,
    List<dynamic>? blackList,
    String? token,
    String? imagePath,
    String? phone,
    List<dynamic>? chatroomList,
  }) {
    return AppUserModel(
      uid: uid ?? this.uid,
      auth: auth ?? this.auth,
      gender: gender ?? this.gender,
      name: name ?? this.name,
      age: age ?? this.age,
      nickname: nickname ?? this.nickname,
      mbti: mbti ?? this.mbti,
      university: university ?? this.university,
      major: major ?? this.major,
      black: black ?? this.black,
      blackList: blackList ?? this.blackList,
      token: token ?? this.token,
      imagePath: imagePath ?? this.imagePath,
      phone: phone ?? this.phone,
      chatroomList: chatroomList ?? this.chatroomList,
    );
  }
}
