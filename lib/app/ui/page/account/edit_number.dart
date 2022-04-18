import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_meet/app/controller/auth_controller.dart';
import 'package:uni_meet/app/ui/page/account/verify_number.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';

import '../../components/app_color.dart';

class EditNumber extends StatefulWidget {
  const EditNumber({Key? key,required this.isLogOut}) : super(key: key,);
  final bool isLogOut;
  @override
  _EditNumberState createState() => _EditNumberState();
}

class _EditNumberState extends State<EditNumber> {
  bool? _isagreed = false;
  var _enterPhoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool cuteMin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      widget.isLogOut
          ? Text("로그인",style: TextStyle(color: Colors.black),)
          :Text("회원가입",style: TextStyle(color: Colors.black),),),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(
                flex: 2,
              ),
              Text(
                "로고",
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                "휴대폰 번호를 입력해주세요",
                style: TextStyle(
                    color: CupertinoColors.systemGrey.withOpacity(0.7),
                    fontSize: 20),
              ),
                Row(
                    children: [
                  Column(
                    children: [
                      Text(
                        "010",
                        style: TextStyle(
                            color: CupertinoColors.secondaryLabel, fontSize: 25),
                      ),
                      cuteMin?SizedBox():SizedBox(height: 23,),
                    ],
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        cursorColor: app_red,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: app_red))),
                        controller: _enterPhoneNumber,
                        validator: (number) {
                          if (number!.trim().length == 8)
                            return null;
                          else
                            return '번호를 다시 한 번 확인해주세요!';
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: CupertinoColors.secondaryLabel, fontSize: 25),
                      ),
                    ),
                  ),
                ]),
              Spacer(
                flex: 1,
              ),
              if(widget.isLogOut==false) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("이용 약관 및 개인정보 처리 방침"),
                  TextButton(onPressed: () async {
                    final url = "https://naver.com/";
                    if(await canLaunch(url)){
                      await launch(
                        url,forceWebView:true,
                        enableJavaScript:true,
                      );
                    }
                  }, child: Text("전문보기"))
                ],
              ),
              if(widget.isLogOut==false) Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text("확인했습니다"),
                  Checkbox(
                    checkColor: Colors.black,
                    activeColor: Colors.white,
                    value:_isagreed,
                    onChanged: (value){
                      setState(() {

                        _isagreed = value;

                      });
                    },
                  )
                ]

              ),
              BigButton(
                  onPressed: () {
                      if (_formKey.currentState!.validate()){
                        if(widget.isLogOut == true || _isagreed == true){
                        Get.to(VerifyNumber(number: "+8210" + _enterPhoneNumber.text.trim()));
                        }
                      }else {
                        cuteMin = false;
                        setState(() {});
                      }
                  },
                  btnText: "코드 전송하기"),
              Spacer(
                flex: 4,
              ),
            ],
          ),
        ));
  }
}
