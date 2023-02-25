import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:fluter_19pmd/views/profile/account/account_bloc.dart';
import 'package:fluter_19pmd/views/profile/account/account_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key key, this.user}) : super(key: key);
  final User user;
  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  final _openEdit = OpenEditAccount();

  final _username = TextEditingController();

  final _email = TextEditingController();

  final _fullName = TextEditingController();

  final _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _profileBloc = ProfileBloc();
  @override
  void initState() {
    _username.text = widget.user.username;
    _email.text = widget.user.email;
    _fullName.text = widget.user.fullName;
    _phone.text = widget.user.phone;
    _username.addListener(onListen);
    _fullName.addListener(onListen);
    _phone.addListener(onListen);
    super.initState();
  }

  void onListen() => setState(() {});

  @override
  void dispose() {
    super.dispose();
    _openEdit.dispose();
    _username.dispose();
    _email.dispose();
    _fullName.dispose();
    _phone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: StreamBuilder<User>(
          initialData: widget.user,
          stream: _profileBloc.userOnlineStream,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.amberAccent));
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shadowColor: Colors.teal,
                    elevation: 10,
                    margin: const EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: StreamBuilder<bool>(
                          initialData: false,
                          stream: _openEdit.editProfileStream,
                          builder: (context, value) {
                            if (!value.data) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Thông tin tài khoản",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: buttonColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => _openEdit.eventSink
                                            .add(AccountEvent.editAccount),
                                        child: const Icon(
                                          Icons.mode_edit_outline_outlined,
                                          color: buttonColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  _buildTitle(user: snapshot.data),
                                ],
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Thông tin tài khoản",
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: buttonColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () async {
                                              final isValid = _formKey
                                                  .currentState
                                                  .validate();
                                              if (!isValid) {
                                                return;
                                              }
                                              var messageFormSever =
                                                  await RepositoryUser
                                                      .updateAccount(
                                                          _username.text,
                                                          _fullName.text,
                                                          _phone.text);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDiaLogCustom(
                                                      text:
                                                          "$messageFormSever.",
                                                      json: "assets/done.json",
                                                    );
                                                  });
                                              _profileBloc.eventSink
                                                  .add(UserEvent.fetch);
                                              _openEdit.eventSink.add(
                                                  AccountEvent.saveAccount);
                                            },
                                            child: const Icon(
                                              Icons.save,
                                              color: buttonColor,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _openEdit.eventSink.add(
                                                  AccountEvent.saveAccount);
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  _buildTextForm(_username, _email, _fullName,
                                      _phone, snapshot.data),
                                ],
                              );
                            }
                          }),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget _buildTitle({User user}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildText('Tên hiển thị:', user.username),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Email:",
                style: TextStyle(
                  fontSize: 20,
                  color: textColor,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 270,
                height: 30,
                child: Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.redAccent,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildText('Họ tên:', user.fullName),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildText('Số điện thoại:', user.phone),
        ),
      ],
    );
  }

  Widget _buildText(title, text) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.redAccent,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
        ],
      );
  Widget _buildTextForm(
    us,
    email,
    fullName,
    phone,
    data,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _input(
          controller: us,
          title: "Tên hiển thị",
          check: false,
          suffixIcon: us.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => us.clear(),
                ),
          type: TextInputType.text,
          inputFormat: FilteringTextInputFormatter.singleLineFormatter,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Không được bỏ trống ';
            }
          },
        ),
        _input(
          controller: email,
          title: "Email",
          check: true,
        ),
        _input(
          controller: fullName,
          title: "Họ tên",
          check: false,
          suffixIcon: fullName.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => fullName.clear(),
                ),
          type: TextInputType.text,
          inputFormat: FilteringTextInputFormatter.singleLineFormatter,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Không được bỏ trống';
            }
          },
        ),
        _input(
          controller: phone,
          title: "Số điện thoại ",
          check: false,
          suffixIcon: phone.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => phone.clear(),
                ),
          type: TextInputType.number,
          inputFormat: FilteringTextInputFormatter.digitsOnly,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Không được bỏ trống';
            }
            if (value.length != 10) {
              return 'Phải 10 số ';
            }
          },
        ),
      ],
    );
  }

  Widget _input(
          {controller,
          title,
          check,
          suffixIcon,
          type,
          inputFormat,
          validator}) =>
      Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: TextFormField(
            inputFormatters: [inputFormat],
            readOnly: check,
            controller: controller,
            style: const TextStyle(fontSize: 20),
            keyboardType: type,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              errorStyle: const TextStyle(fontSize: 18),
              labelText: title,
              labelStyle: const TextStyle(fontSize: 20),
            ),
            validator: (validator)),
      );
}
