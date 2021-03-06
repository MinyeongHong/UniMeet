import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:uni_meet/secret/secret_keys.dart';

import '../data/model/firestore_keys.dart';
import 'package:http/http.dart' as http;
import 'auth_controller.dart';

class NotificationController extends GetxController{
  static NotificationController get to => Get.find();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void onInit() async {
    /// 첫 빌드시, 권한 확인하기 아이폰은 무조건 받아야 하고, 안드로이드는 상관 없음. 따로 유저가 설정하지 않는 한,자동 권한 확보 상태
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true
    );
    _onMessage();
    super.onInit();
  }

  /// 디바이스 고유 토큰을 얻기 위한 메소드, 처음 한번만 사용해서 토큰을 확보하자.
  /// 이는 파이어베이스 콘솔에서 손쉽게 디바이스에 테스팅을 할 때 쓰인다.
  // void _getToken() async{
  //   String? token= await messaging.getToken();
  //   try{
  //     print("토큰은"+token!);
  //     FirebaseFirestore.instance
  //         .collection(COLLECTION_USERS)
  //         .doc(AuthController.to.user.value.uid)
  //         .update({KEY_USER_TOKEN: token}); //바꾸기
  //   } catch(e) {
  //     print("토큰 에러 "+ e.toString());
  //   }
  //
  // }
  /// ----------------------------------------------------------------------------

  /// * 안드로이드에서 foreground 알림 위한 flutter_local_notification 라이브러리 *
  ///
  /// 1. channel 생성 (우리의 알림을 따로 전달해줄 채널을 직접 만든다)
  /// 2. 그 채널을 우리 메인 채널로 정해줄 플러그인을 만들어준다.
  /// - 준비 끝!!
// 1.
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'MOMODU', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
  // 2.
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  void _onMessage() async{
    /// * local_notification 관련한 플러그인 활용 *
    ///
    /// 1.  위에서 생성한 channel 을 플러그인 통해 메인 채널로 설정한다.
    /// 2. 플러그인을 초기화하여 추가 설정을 해준다.
    // 1.
    await _notifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    // 2.
    await _notifications.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: IOSInitializationSettings()),
        onSelectNotification: (String? payload) async {});

    //background 상태
    FirebaseMessaging.instance.getInitialMessage();
    //forground 상태
/*
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      var androidNotiDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
      );
      var iOSNotiDetails = const IOSNotificationDetails();
      var details =
      NotificationDetails(android: androidNotiDetails, iOS: iOSNotiDetails);
      if (notification != null) {
        _notifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          details,
        );
      }
    });
 */
  //앱이 완전히 종료된 상태

  }


  Future<bool> SendNewCommentNotification(
      {required String Title,required String receiver_token}) async {
    String url = "https://fcm.googleapis.com/fcm/send";
    // 임시
    String _firebaseKey =firebase_FCM_key;

    await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$_firebaseKey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': '${Title}에 새 댓글이 달렸습니다.',
            'title': 'MOMODU'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            "screen": "AlarmPage",
          },
          'to':"$receiver_token",
        },
      ),
    );

    return true;
  }

  Future<bool> SendNewChatNotification(
      {required String info,required String receiver_token}) async {
    String url = "https://fcm.googleapis.com/fcm/send";
    // 임시
    String _firebaseKey =firebase_FCM_key;

    await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$_firebaseKey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': info+'님이 새로운 채팅방을 개설했어요!',
            'title': 'MOMODU'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to':"$receiver_token",
        },
      ),
    );

    return true;
  }

  Future<bool> SendSuccessUniCheck({required String receiver_token}) async {
    String url = "https://fcm.googleapis.com/fcm/send";
    // 임시
    String _firebaseKey =firebase_FCM_key;

    await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$_firebaseKey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': '학생 인증이 완료되었습니다! 게시판과 채팅을 이용해보세요',
            'title': 'MOMODU'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to':"$receiver_token",
        },
      ),
    );

    return true;

  }

  Future<bool> SendFailUniCheck({required String receiver_token}) async {
    String url = "https://fcm.googleapis.com/fcm/send";
    // 임시
    String _firebaseKey =firebase_FCM_key;

    await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$_firebaseKey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': '학생 인증에 실패하였습니다! 다시 한번 시도해주세요',
            'title': 'MOMODU'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to':"$receiver_token",
        },
      ),
    );

    return true;

  }

  Future<bool> SendNewChat({required String Sender, required String Sender_token,required List<dynamic>? receiver_token}) async {
    String url = "https://fcm.googleapis.com/fcm/send"; // 임시
    String _firebaseKey = firebase_FCM_key;

    List<String> token_List =[];

    for(int i=0; i<receiver_token!.length; i++){

      if(receiver_token[i]!= Sender_token) token_List.add(receiver_token[i].toString());
    }
    await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$_firebaseKey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': '$Sender님의 새 채팅 메세지',
            'title': '모모두'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },

          'registration_ids':token_List,
        },
      ),
    );

    return true;
  }
}