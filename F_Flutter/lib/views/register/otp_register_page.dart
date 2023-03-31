import 'dart:async';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/login/signIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../function.dart';

class OtpRegisterPage extends StatefulWidget {
  const OtpRegisterPage(
      {this.otp,
      Key key,
      this.email,
      this.pass,
      this.phone,
      this.fullname,
      this.displayname})
      : super(key: key);
  final int otp;
  final String email;
  final String pass;
  final String phone;
  final String fullname;
  final String displayname;
  @override
  State<OtpRegisterPage> createState() => _OtpRegisterPageState();
}

class _OtpRegisterPageState extends State<OtpRegisterPage> {
  var temp = 0;
  int start = 30;
  bool wait = false;
  Random random = Random();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade600, Colors.teal.shade200],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 0.5,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          centerTitle: true,
          title: const Text(
            "Xác thực OTP",
          )),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Text(
                "Xác thực mã OTP",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
              ),
            ),
            Column(
              children: [
                const Text("Mã xác thực đã được gửi qua Email:"),
                const SizedBox(height: 6),
                Text(
                  widget.email,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            PinCodeTextField(
              autofocus: true,
              controller: otpController,
              hideCharacter: false,
              highlight: true,
              maxLength: 6,
              maskCharacter: "•",
              pinBoxRadius: 10,
              onTextChanged: (text) {},
              onDone: (text) {
                setState(() {
                  checkOtp(text);
                });
              },
              pinBoxWidth: MediaQuery.of(context).size.height * 0.07,
              pinBoxHeight: MediaQuery.of(context).size.height * 0.065,
              hasUnderline: false,
              wrapAlignment: WrapAlignment.spaceAround,
              pinBoxDecoration:
                  ProvidedPinBoxDecoration.defaultPinBoxDecoration,
              pinBoxBorderWidth: 1.0,
              pinBoxColor: Colors.white,
              pinTextStyle: const TextStyle(fontSize: 15),
              pinTextAnimatedSwitcherDuration:
                  const Duration(milliseconds: 300),
              highlightAnimation: false,
              highlightPinBoxColor: Colors.white,
              highlightAnimationBeginColor: Colors.white,
              highlightAnimationEndColor: Colors.white,
              keyboardType: TextInputType.number,
              pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 2),
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Bạn chưa nhận được mã ? ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                InkWell(
                  onTap: wait
                      ? null
                      : () {
                          RepositoryUser.sendEmail(
                              widget.email, RepositoryUser.templateRegister);
                          startTimer();
                          if (mounted) {
                            setState(() {
                              start = 30;
                              wait = true;
                            });
                          }
                        },
                  child: Text(
                    "Gửi lại OTP",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: wait ? Colors.grey : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "$start giây",
              style: TextStyle(
                  fontSize: 18, color: wait ? Colors.red : Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    checkOtp(otpController.text);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Xác nhận',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }

  void checkOtp(otp) {
    if (RepositoryUser.otp.toString() == otp) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDiaLogCustom(
              json: "assets/done.json",
              text: "Đăng ký tài khoản thành công.",
            );
          });
      _submit(context, widget.email, widget.pass, widget.displayname,
          widget.fullname, widget.phone);
    } else {
      Fluttertoast.showToast(
          msg: "Mã otp không hợp lệ",
          textColor: Colors.red,
          backgroundColor: Colors.white,
          fontSize: 20);
    }
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
            wait = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            start--;
          });
        }
      }
    });
  }

  void _submit(context, email, password, displayname, fullname, phone) async {
    await RepositoryUser.register(
        email, password, displayname, fullname, phone);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInPage(),
      ),
    );
  }
}
