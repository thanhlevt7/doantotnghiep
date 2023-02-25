import 'dart:convert';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/register/otp_register_page.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as https;
import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Random random = Random();
  final _formKey = GlobalKey<FormState>();
  final _isLoading = LoadingBloc();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final displayNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(onListen);
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    displayNameController.dispose();
    phoneController.dispose();
    fullNameController.dispose();

    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: _form(size),
        ),
      ),
    );
  }

  Widget _form(size) => Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade600, Colors.teal.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      "Đăng ký",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(30.0),
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          _input(
                              icon: const Icon(Icons.email),
                              suffixIcon: emailController.text.isEmpty
                                  ? Container(
                                      width: 0,
                                    )
                                  : IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () => emailController.clear(),
                                    ),
                              text: "Nhập email",
                              controller: emailController,
                              validator: (value) {
                                if (value.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@gmail+\.com+")
                                        .hasMatch(value)) {
                                  return 'Email không hợp lệ';
                                }
                              },
                              type: TextInputType.text,
                              phone: FilteringTextInputFormatter
                                  .singleLineFormatter),
                          const SizedBox(height: 15),
                          _input(
                              icon: const Icon(Icons.lock),
                              text: "Nhập mật khẩu",
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Không được bỏ trống';
                                }
                              },
                              type: TextInputType.text,
                              phone: FilteringTextInputFormatter
                                  .singleLineFormatter),
                          const SizedBox(height: 15),
                          _input(
                              icon: const Icon(Icons.lock),
                              text: "Nhập tên hiển thị",
                              controller: displayNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Không được bỏ trống';
                                }
                              },
                              type: TextInputType.text,
                              phone: FilteringTextInputFormatter
                                  .singleLineFormatter),
                          const SizedBox(height: 15),
                          _input(
                              icon: const Icon(Icons.lock),
                              text: "Nhập họ tên",
                              controller: fullNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Không được bỏ trống';
                                }
                              },
                              type: TextInputType.text,
                              phone: FilteringTextInputFormatter
                                  .singleLineFormatter),
                          const SizedBox(height: 15),
                          _input(
                            icon: const Icon(Icons.phone_android),
                            text: "Nhập số điện thoại",
                            controller: phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Không được bỏ trống';
                              }
                              if (value.length != 10) {
                                return 'Phải 10 số';
                              }
                            },
                            type: TextInputType.number,
                            phone: FilteringTextInputFormatter.digitsOnly,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: SizedBox(
                              height: 50,
                              width: 200,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(buttonColor),
                                ),
                                onPressed: () {
                                  submit(context, emailController.text);
                                },
                                child: const Text('Đăng ký',
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Text(
                                "Quay lại",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _input(
          {icon,
          suffixIcon,
          text,
          controller,
          Function validator,
          type,
          phone}) =>
      TextFormField(
          inputFormatters: [phone],
          controller: controller,
          obscureText: false,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade500,
          ),
          keyboardType: type,
          onFieldSubmitted: (value) {},
          decoration: InputDecoration(
            prefixIcon: icon,
            suffixIcon: suffixIcon,
            floatingLabelStyle: TextStyle(
              fontSize: 22,
              color: Colors.grey.shade500,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.teal, width: 2.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.teal, width: 2.0),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.red),
            ),
            errorStyle: const TextStyle(fontSize: 15),
            labelText: text,
            labelStyle: TextStyle(
              fontSize: 22,
              color: Colors.grey.shade500,
            ),
          ),
          validator: (validator));

  void submit(BuildContext context, String email) async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState.save();
    _isLoading.loadingSink.add(true);

    await sendEmail(email);
  }

  Future sendEmail(String email) async {
    final otp = random.nextInt(899999) + 100000;
    RepositoryUser.otp = otp;
    var client = https.Client();
    var data = await client
        .post(Uri.parse('http://10.0.2.2:8000/api/users/check/$email'));
    const serviceId = 'service_yed4dhz';
    const templateId = 'template_tmzua9o';
    const userId = 'MsE9IzXWqJEcqdVgd';
    if (data.statusCode == 201) {
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      await https.post(url,
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'template_params': {
              'otp': otp,
              'user_name': 'name',
              'user_email': email,
            },
          }));
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDiaLogCustom(
              json: "assets/done.json",
              text: "Kiểm tra email của bạn.",
            );
          });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpRegisterPage(
            pass: passwordController.text,
            displayname: displayNameController.text,
            fullname: fullNameController.text,
            phone: phoneController.text,
            otp: otp,
            email: emailController.text,
          ),
        ),
      );
    } else if (data.statusCode == 200) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDiaLogCustom(
              json: "assets/error.json",
              text: "Email đã đăng ký.",
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDiaLogCustom(
              json: "assets/error.json",
              text: "Đã xảy ra lỗi.",
            );
          });
    }
  }
}
