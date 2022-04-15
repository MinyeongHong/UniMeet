import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_meet/app/ui/components/app_color.dart';
import 'package:uni_meet/app/ui/page/screen_index/home/screen/game_screen.dart';
import 'package:get/get.dart';

import '../../../../../controller/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("MOMODU"),
            actions: [
              IconButton(onPressed: (){},icon: Icon(Icons.notifications_none_rounded),)
            ]
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                        AssetImage('assets/images/momo'+AuthController.to.user.value.localImage.toString()+'.png'),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(AuthController.to.user.value.university.toString()
                            +" "
                            +AuthController.to.user.value.grade.toString()+"학번 | "
                            + AuthController.to.user.value.major.toString(),
                          style: TextStyle(color: app_systemGrey1),
                            ),

                        AuthController.to.user.value.auth!
                          ? Text("학생 인증 완료")
                          : Row(
                          children: [
                            Text("학생 인증 미완료  ",style: TextStyle(color: app_systemGrey1),),
                            TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.centerLeft
                                ),
                                onPressed:(){
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext child_context) {
                                        return AlertDialog(
                                          content: Text(
                                              "에브리타임 캡쳐 스크린을 선택 후, 전송하기를 눌러주세요.\n 24시간 이내로 확인 도와드릴게요!"),
                                          actions: [
                                            Center(
                                              child: Column(
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                      },
                                                      child: Text("파일 찾아보기")),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                      },
                                                      child: Text("전송하기")),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                }, child: Text("인증에 실패하셨나요?",style: TextStyle(color: app_red.withOpacity(0.8),),)),
                          ],
                        ),
                        Text(AuthController.to.user.value.nickname.toString()+"님",style: TextStyle(fontSize: 16),),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height:_size.height*0.2 ,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                    child: Image.asset("assets/images/game_banner.png"),
                  onTap: (){Get.to(GameScreen());}
                ),
              ),
              Text("공지사항",style: Theme.of(context).textTheme.titleLarge),
              Container(height: 70,),
              Text("내가 쓴 글",style: Theme.of(context).textTheme.titleLarge),
              Container(height: 70,),
            ],
          ),
        )
    );
    }
}
