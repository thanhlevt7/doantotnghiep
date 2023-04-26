import 'dart:async';
import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/forgot_password/forgot_page.dart';
import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/views/home/home_page.dart';
import 'package:fluter_19pmd/views/register/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _isLoading = LoadingBloc();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _stateStreamController = StreamController<bool>();
  StreamSink<bool> get chooseSink => _stateStreamController.sink;
  Stream<bool> get chooseStream => _stateStreamController.stream;
  SharedPreferences logindata;
  bool newuser;
  String data;
  User name;
  int dem = 0;

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (RepositoryUser.delay == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
            dem = 0;
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

  @override
  void initState() {
    emailController.addListener(onListen);
    checkUserLogin();
    initial();
    super.initState();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      if (logindata.getString('data') != null) {
        RepositoryUser.info = userFromJson(logindata.getString('data'));
      }
    });
  }

  void checkUserLogin() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  void dispose() {
    emailController.removeListener(onListen);
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    _isLoading.dispose();
    _stateStreamController.close();
  }

  void onListen() => setState(() {});

  _submit(BuildContext context, TextEditingController email,
      TextEditingController password) async {
    _isLoading.loadingSink.add(true);
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      _isLoading.loadingSink.add(false);
      return;
    }
    _formKey.currentState.save();
    var check = await RepositoryUser.login(email, password);
    if (check == 200) {
      logindata.setBool('login', false);
      logindata.setString('data', RepositoryUser.dataLogin);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDiaLogCustom(
              text: "-Đăng nhập thành công.",
              json: "assets/done.json",
            );
          });
      _isLoading.loadingSink.add(false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      //tăng dem
      setState(() {
        dem++;
      });
      showDialog(
          context: context,
          builder: (context) {
            return AlertDiaLogCustom(
              text: "-Đăng nhập thất bại.",
              json: "assets/error.json",
            );
          });
      _isLoading.loadingSink.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _form(size),
      ),
    );
  }

  Widget _form(size) => Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: StreamBuilder<bool>(
              initialData: false,
              stream: _isLoading.loadingStream,
              builder: (context, state) {
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 800,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.teal.shade400, Colors.teal.shade200],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 150),
                          const Text(
                            "Đăng nhập",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(30.0),
                            width: 500,
                            // height: 420,
                            padding: const EdgeInsets.all(20.0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 12),
                                  _emailLogin(),
                                  const SizedBox(height: 20),
                                  _passwordLogin(),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ForgotPasswordPage(),
                                              ));
                                        },
                                        child: const Text(
                                          "Quên mật khẩu ?",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  (state.data)
                                      ? Center(
                                          child: Lottie.asset(
                                            "assets/loading.json",
                                            width: 70,
                                            height: 60,
                                          ),
                                        )
                                      : _buttonLogin(context, emailController,
                                          passwordController),
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpScreen(),
                                            ));
                                      },
                                      child: const Text(
                                        "Đăng ký",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      );

  Widget _emailLogin() => TextFormField(
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey.shade500,
        ),
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email_outlined),
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
            borderSide: BorderSide(color: Colors.teal, width: 2),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(color: Colors.teal),
          ),
          suffixIcon: emailController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => emailController.clear(),
                ),
          errorStyle: const TextStyle(fontSize: 15),
          labelText: "Nhập email",
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade500,
          ),
        ),
        validator: (value) {
          if (value.isEmpty ||
              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@gmail+\.com+")
                  .hasMatch(value)) {
            return 'Email không hợp lệ';
          }
          return null;
        },
      );

  Widget _passwordLogin() => StreamBuilder<bool>(
      initialData: true,
      stream: chooseStream,
      builder: (context, value) {
        return TextFormField(
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade500,
          ),
          controller: passwordController,
          obscureText: value.data,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_open),
            suffixStyle: TextStyle(
              color: Colors.grey.shade500,
            ),
            suffixIcon: InkWell(
              onTap: () {
                chooseSink.add(!value.data);
              },
              child: (value.data)
                  ? Icon(
                      Icons.visibility,
                      color: Colors.grey.shade500,
                    )
                  : Icon(
                      Icons.visibility_off,
                      color: Colors.grey.shade500,
                    ),
            ),
            floatingLabelStyle: TextStyle(
              fontSize: 22,
              color: Colors.grey.shade500,
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.teal, width: 2.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.teal, width: 2.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.teal, width: 2.0),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Colors.teal, width: 2.0),
            ),
            errorStyle: const TextStyle(fontSize: 16),
            labelStyle: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade500,
            ),
            labelText: "Nhập mật khẩu",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Không được bỏ trống';
            }
            return null;
          },
        );
      });

  Widget _buttonLogin(BuildContext context, TextEditingController email,
          TextEditingController password) =>
      InkWell(
        onTap: () async {
          // khi login sai thì tăng dem
          if (dem < 3) {
            _submit(context, email, password);
          } else {
            if (RepositoryUser.delay == 0) {
              setState(() {
                RepositoryUser.delay = 30;
              });
              startTimer();
            }

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              "Vui lòng đợi sau ${RepositoryUser.delay} giây",
              style: const TextStyle(fontSize: 20),
            )));
          }
        },
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            height: 50,
            width: 180,
            child: const Center(
                child: Text('Đăng nhập',
                    style: TextStyle(fontSize: 20, color: Colors.white))),
          ),
        ),
      );
}
