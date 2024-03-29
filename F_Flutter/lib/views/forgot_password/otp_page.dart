import 'dart:async';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/forgot_password/change_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:math';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../constant.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({this.otp, Key key, this.email}) : super(key: key);
  final int otp;
  final String email;
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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
            "Xác thực OTP ",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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
              ],
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
                  onTap: () {
                    if (RepositoryUser.delay > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(milliseconds: 200),
                          content: Text(
                            "Vui lòng đợi sau ${RepositoryUser.delay} giây",
                            style: const TextStyle(fontSize: 20),
                          )));
                    } else {
                      RepositoryUser.sendEmail(widget.email, templateForgot);
                      RepositoryUser.delay = 30;
                      EasyLoading.showSuccess('Đã gửi otp');
                      startTimer();
                    }
                  },
                  child: const Text(
                    "Gửi lại OTP",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
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
                    setState(() {
                      checkOtp(otpController.text);
                    });
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
          ],
        ),
      ),
    );
  }

  void checkOtp(otp) {
    if (RepositoryUser.otp.toString() == otp) {
      EasyLoading.showSuccess('Mã otp hợp lệ ');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangePassword(
            email: widget.email,
          ),
        ),
      );
    } else {
      EasyLoading.showError('Mã otp không hợp lệ ');
    }
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (RepositoryUser.delay == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
          });
        }
      } else {
        if (mounted) {
          setState(() {
            RepositoryUser.delay--;
          });
        }
      }
    });
  }

  Widget textFieldOTP({bool first, last, controller}) {
    return SizedBox(
      height: 85,
      width: 70,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          controller: controller,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(25)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(25)),
          ),
        ),
      ),
    );
  }
}
