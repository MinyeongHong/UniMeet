import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uni_meet/app/ui/page/account/widget/big_button.dart';
import 'package:uni_meet/root_page.dart';
import '../../components/app_color.dart';


enum Status {Waiting,Error}

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({Key? key, this.number}) : super(key: key);
  final number;
  @override
  _VerifyNumberState createState() => _VerifyNumberState(number);
}

class _VerifyNumberState extends State<VerifyNumber> {
  final phoneNumber;
  var _status = Status.Waiting;
  var _verificationId ;
  TextEditingController _textEditingController_1 = TextEditingController();
  TextEditingController _textEditingController_2 = TextEditingController();
  TextEditingController _textEditingController_3 = TextEditingController();
  TextEditingController _textEditingController_4 = TextEditingController();
  TextEditingController _textEditingController_5 = TextEditingController();
  TextEditingController _textEditingController_6 = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  _VerifyNumberState(this.phoneNumber);

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
  }

  Future _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneCuthCredentials) async {},
        verificationFailed: (verificationFailed) async {},
        codeSent: (verificationId,resendingToken) async {
          setState(() {
            _verificationId = verificationId;
          });

        },
        codeAutoRetrievalTimeout:  (verificationId) async {}
    );
  }

  Future _sendCodeToFirebase({String? code}) async {
    if(_verificationId != null){
      var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code!);

      await _auth
          .signInWithCredential(credential)
          .then((value){
        Logger().d('????????? ?????????.');

        Get.offAll(RootPage());
            //Get.offAll(() => EditInfo(uid: _auth.currentUser!.uid));
      })
          .whenComplete(() {})
          .onError((error, stackTrace) {
            Logger().d('????????? ????????? ??????.');
            setState(() {
              _status = Status.Error;
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){FocusScope.of(context).unfocus();},
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("?????? ??????",style: TextStyle(color: Colors.black),),
          automaticallyImplyLeading: false,
        ),
        body: Padding(padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 2,),
            Image.asset("assets/images/logo.png"),
            Spacer(flex: 3,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 60,
                  width: 50,
                  child: TextFormField(
                    controller: _textEditingController_1,
                    onChanged: (value){
                      if(value.length==1) FocusScope.of(context).nextFocus();
                    },
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    cursorColor: app_red,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        focusColor: app_red,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: app_red),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        )

                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 50,
                  child: TextFormField(
                    controller: _textEditingController_2,
                    onChanged: (value){
                      if(value.length==1) FocusScope.of(context).nextFocus();
                    },
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    cursorColor: app_red,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        focusColor: app_red,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: app_red),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        )

                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 50,
                  child: TextFormField(
                    controller: _textEditingController_3,
                    onChanged: (value){
                      if(value.length==1) FocusScope.of(context).nextFocus();
                    },
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    cursorColor: app_red,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        focusColor: app_red,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: app_red),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        )

                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 50,
                  child: TextFormField(
                    controller: _textEditingController_4,
                    onChanged: (value){
                      if(value.length==1) FocusScope.of(context).nextFocus();
                    },
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    cursorColor: app_red,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        focusColor: app_red,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: app_red),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        )

                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 50,
                  child: TextFormField(
                    controller: _textEditingController_5,
                    onChanged: (value){
                      if(value.length==1) FocusScope.of(context).nextFocus();
                    },
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    cursorColor: app_red,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        focusColor: app_red,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: app_red),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        )

                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 50,
                  child: TextFormField(
                    controller: _textEditingController_6,
                    onChanged: (value){
                      //if(value.length==1) FocusScope.of(context).nextFocus();
                    },
                    style: Theme.of(context).textTheme.headline6,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    cursorColor: app_red,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        focusColor: app_red,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: app_red),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        )

                    ),
                  ),
                ),
              ],
            ),
            _status != Status.Error
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("????????? 6?????? ????????? ??????????????????",style: TextStyle(color: CupertinoColors.systemGrey.withOpacity(0.7),fontSize: 20),),
                )
            :Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("????????? ???????????? ????????????",style: TextStyle(color: Colors.redAccent,fontSize: 20),),
            ),

            Spacer(flex: 2,),
            BigButton(onPressed: () async {
              await _sendCodeToFirebase(
                  code:_textEditingController_1.text+_textEditingController_2.text
                      +_textEditingController_3.text+_textEditingController_4.text
                      +_textEditingController_5.text+_textEditingController_6.text);
            }, btnText: '????????????',),
            Spacer(flex: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("??????????????? ?????? ???????????????????",style: TextStyle(color: CupertinoColors.systemGrey.withOpacity(0.7)),),
                TextButton(
                    child: Text("???????????????",style: TextStyle(color: Colors.black),),
                    onPressed: () async {
                      setState(() {
                        Get.back();
                      });
                      _verifyPhoneNumber();
                    }
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("????????? ?????? ??? ?????????????",style: TextStyle(color: CupertinoColors.systemGrey.withOpacity(0.7)),),
                MaterialButton(
                    child: Text("???????????????"),
                    onPressed: () async {
                      setState(() {
                        _status = Status.Waiting;
                      });
                      _verifyPhoneNumber();
                    }
                ),
              ],
            ),

            Spacer(flex: 2,),
          ],
        ),)
      ),
    );
  }
}
