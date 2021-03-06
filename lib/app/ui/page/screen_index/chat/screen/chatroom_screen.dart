import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/controller/chat_controller.dart';
import 'package:uni_meet/app/data/model/chat_model.dart';
import 'package:uni_meet/app/data/repository/chat_repository.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';
import 'package:uni_meet/app/ui/page/screen_index/index_screen.dart';
import 'package:uni_meet/app/ui/page/screen_index/message_popup.dart';
import 'package:uni_meet/app/ui/page/screen_index/widgets/profile_widget.dart';
import 'package:uni_meet/app/ui/widgets/input_bar.dart';
import 'package:uni_meet/app/ui/page/screen_index/chat/widget/chatText.dart';

import '../../../../../controller/notification_controller.dart';

class ChatroomScreen extends StatefulWidget {
  String chatroomKey;

  ChatroomScreen({required this.chatroomKey, Key? key}) : super(key: key);

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ChatController.to.getOldMessages();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      Size _size = MediaQuery.of(context).size;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: BackButton(
              color: Colors.grey[800],
            ),
            actions: [],
          ),
          endDrawer: SafeArea(
            child: Drawer(
                child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("????????????"),
                              content: Text(
                                "????????? ????????? ???????????? ??????????????????! \n????????? ????????? ????????? ?????? ????????? ?????? ???????????? ??? ????????????.",
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      await FlutterClipboard.copy(
                                          widget.chatroomKey);
                                      Get.back();
                                    },
                                    child: Text(
                                      "????????????",
                                    ))
                              ],
                            );
                          });
                    },
                    child: Text(
                      "????????????",
                      style: TextStyle(color: Colors.white),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text("????????????"),
                ),
                // Expanded(child: FutureBuilder(
                //   future: ChatRepository.getChatterInfo(ChatController.to.chat_chatroomModel.value.allUser!),
                //     builder: (context, snapshot) {
                //   return Container();
                // },
                // )),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: ChatController.to.chat_chatroomModel.value.allUser!.length,
                //     itemBuilder: (BuildContext context,int index){
                //       return ListTile(
                //         onTap: ()async {await ChatRepository.getChatterInfo(widget.chatroomKey);},
                //         title:Text("?????????",style: TextStyle(fontSize: 10),)
                //       );
                //     },
                //   )
                // ),
                Obx(() => Expanded(
                        child: ListView.builder(
                      itemCount: ChatController.to.chatterInfo.length,
                      itemBuilder: (BuildContext context, int index) {
                        var chatterInfo = ChatController.to.chatterInfo[index];
                        return ListTile(
                            onTap: () async {
                              if(chatterInfo.gender=='Gender.MAN'){
                                chatterInfo.gender = '??????';
                              }else if(chatterInfo.gender=='Gender.WOMAN'){
                                chatterInfo.gender = '??????';
                              }
                              Get.dialog(AlertDialog(
                                title: SizedBox(),
                                content: ProfileWidget(
                                    university: chatterInfo.university!,
                                    grade: '${chatterInfo.grade} ??????',
                                    mbti: chatterInfo.mbti!,
                                    gender: chatterInfo.gender!,
                                    nickname: chatterInfo.nickname!,
                                    localImage: chatterInfo.localImage!),
                              ));
                            },
                            leading: ExtendedImage.asset(
                              'assets/images/momo${ChatController.to.chatterInfo[index].localImage}.png',
                            ),
                            title: Text(
                              ChatController.to.chatterInfo[index].nickname!,
                              style: TextStyle(fontSize: 14),
                            ));
                      },
                    ))),
                TextButton(
                    child: Text("????????????"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return MessagePopup(
                              title: "????????????",
                              message:
                                  "?????? ???????????? ????????????????????????? ?????? ??? 2~3??? ?????? ???????????? ????????? ????????? ???????????? ???????????????.\n?????? ???????????? ??????/????????? ???????????? ????????? ?????? ??? ???????????????. ",
                              okCallback: () async {
                                await FirebaseStorage.instance
                                    .ref('report/chatroom/' +
                                        widget.chatroomKey.toString())
                                    .putString(DateTime.now().toString());
                                //??????.. ????????????..
                                Get.back();
                                Get.snackbar("??????", "??????????????? ?????????????????????.");
                              },
                              cancelCallback: () {
                                Get.back();
                              },
                            );
                          });
                    }),
                TextButton(
                  child: Text("?????????"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("?????????"),
                            content: Text("???????????? ??????????????????????"),
                            actions: [
                              IconButton(
                                  onPressed: () async {
                                    await ChatRepository()
                                        .exitChatroom(widget.chatroomKey);
                                    // await ChatController.to.exitRoom(widget.chatroomKey);
                                    Get.offAll(IndexScreen());
                                  },
                                  icon: Icon(Icons.exit_to_app))
                            ],
                          );
                        });
                  },
                ),
              ],
            )),
          ),
          body: SafeArea(
            child: Column(
              children: [
                // _postInfo(),
                Expanded(
                    child: Container(
                  color: Colors.white,
                  child: Obx(() => ListView.separated(
                      reverse: true,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        bool isMine = ChatController
                                .to.chat_chatList[index].writer!
                                .split('_')[2] ==
                            AuthController.to.user.value.nickname;
                        return ChatText(
                          size: _size,
                          isMine: isMine,
                          chatModel: ChatController.to.chat_chatList[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 3,
                        );
                      },
                      itemCount: ChatController.to.chat_chatList.length)),
                )),
                InputBar(
                    textEditingController: _chatController,
                    onPress: onPress,
                    hintText: '???????????? ???????????????.')
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> onPress() async {
    ChatModel chat = ChatModel(
      writer:
          '${AuthController.to.user.value.university}_${AuthController.to.user.value.grade}_${AuthController.to.user.value.nickname}_${AuthController.to.user.value.localImage}_${AuthController.to.user.value.mbti}_${AuthController.to.user.value.gender}',
      message: _chatController.text,
      createdDate: DateTime.now(),
    ); // ????????? ???????
    // await ChatRepository().createNewChat(widget.chatroomKey, chat);
    if (_chatController.text.trim() != '') ChatController.to.addNewChat(chat);
    _chatController.clear();

    Get.put(NotificationController()).SendNewChat(
        Sender: AuthController.to.user.value.nickname.toString(),
        Sender_token: AuthController.to.user.value.token.toString(),
        receiver_token: ChatController.to.chat_chatroomModel.value.allToken);
  }

// MaterialBanner _postInfo() {
//   return MaterialBanner(
//       padding: EdgeInsets.zero,
//       content: Column(
//         children: [
//           ListTile(
//             leading: Icon(Icons.wysiwyg),
//             title: RichText(
//               text: TextSpan(
//                   text: '???????????? 3:3 ?????????????   ',
//                   style: TextStyle(color: Colors.black),
//                   children: [
//                     TextSpan(
//                       text: '2022/04/11',
//                     )
//                   ]),
//             ),
//           )
//         ],
//       ),
//       actions: [Container()]);
// }
}
