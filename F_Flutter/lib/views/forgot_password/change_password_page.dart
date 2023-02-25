import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/login/signIn_screen.dart';
import 'package:flutter/material.dart';

import '../../function.dart';

// ignore: must_be_immutable
class ChangePassword extends StatefulWidget {
  ChangePassword({Key key, this.email}) : super(key: key);
  String email;
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final passwordNew = TextEditingController();
  final passwordNewConfirm = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.teal.shade600, Colors.teal.shade200],
                      begin: Alignment.bottomLeft,
                      end: Alignment.bottomRight))),
          centerTitle: true,
          title: const Text("Đổi mật khẩu")),
      body: Form(
        key: _formKey,
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          buildTextField(
              title: "Nhập mật khẩu mới",
              controller: passwordNew,
              dieukien: (value) {
                if (passwordNew.text.length < 6) {
                  return "mật khẩu mới phải ít nhất 6 kí tự";
                }
              }),
          buildTextField(
              title: "Nhập lại mật khẩu mới",
              controller: passwordNewConfirm,
              dieukien: (value) {
                if (passwordNew.text.length < 6) {
                  return "mật khẩu mới phải ít nhất 6 kí tự";
                }
                if (passwordNew.text != passwordNewConfirm.text) {
                  return "mật khẩu không trùng nhau";
                }
              }),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 50,
              width: 200,
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
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      var dataFromServer = await RepositoryUser.changePassword(
                          widget.email, passwordNew.text);
                      if (dataFromServer == 200) {
                        await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDiaLogCustom(
                                json: "assets/done.json",
                                text: "Đổi mật khẩu thành công.",
                              );
                            });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
                            ));
                      }
                    }
                  },
                  child: const Text(
                    "Đổi mật khẩu",
                    style: TextStyle(fontSize: 18),
                  )))
        ]),
      ),
    );
  }

  Widget buildTextField({title, controller, dieukien}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
          validator: dieukien,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: title,
            labelStyle: const TextStyle(fontSize: 25),
          )),
    );
  }
}
