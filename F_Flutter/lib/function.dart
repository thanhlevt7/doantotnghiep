import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/repository/favorites_api.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:fluter_19pmd/views/home/home_page.dart';
import 'package:fluter_19pmd/views/profile/collections/open_item_collection.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'models/favorites_model.dart';

String convertToVND(int price) {
  var current = price.toString().split('');
  var newPrice = '';

  if (current.length == 5) {
    current.insert(2, '.');
    for (var element in current) {
      newPrice += element;
    }
  } else if (current.length == 6) {
    current.insert(3, '.');
    for (var element in current) {
      newPrice += element;
    }
  } else if (current.length == 4) {
    current.insert(1, '.');
    for (var element in current) {
      newPrice += element;
    }
  } else if (current.length == 7) {
    current.insert(1, '.');
    current.insert(5, '.');
    for (var element in current) {
      newPrice += element;
    }
  } else if (current.length == 8) {
    current.insert(2, '.');
    current.insert(6, '.');
    for (var element in current) {
      newPrice += element;
    }
  } else {
    newPrice = price.toString();
  }
  return newPrice.toString();
}

class AlertTextFieldCustom extends StatefulWidget {
  const AlertTextFieldCustom({Key key, this.title, this.productID})
      : super(key: key);
  final String title;
  final int productID;

  @override
  State<AlertTextFieldCustom> createState() => _AlertTextFieldCustomState();
}

class _AlertTextFieldCustomState extends State<AlertTextFieldCustom> {
  final controller = TextEditingController();
  final _eventFavorite = EventForUserInFavorite();
  final _favorites = ProfileBloc();

  @override
  void initState() {
    super.initState();
    _favorites.eventSink.add(UserEvent.showFavorite);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    _eventFavorite.dispose();
    _favorites.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              StreamBuilder<bool>(
                  initialData: false,
                  stream: _eventFavorite.openFavoriteStream,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          StreamBuilder<List<Favorites>>(
                              initialData: null,
                              stream: _favorites.userFavoriteStream,
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                return SizedBox(
                                  width: 300,
                                  height:
                                      RepositoryFavorite.getHeightForScreenHome(
                                          snapshot.data.length),
                                  child: ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => ListTile(
                                            leading: Text(
                                              '${index + 1}.',
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.grey.shade600),
                                            ),
                                            title: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              height: 50,
                                              child: Text(
                                                snapshot.data[index].title,
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.grey.shade600,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                            trailing: IconButton(
                                                onPressed: () async {
                                                  var code =
                                                      await RepositoryFavorite
                                                          .addProduct(
                                                    widget.productID,
                                                    snapshot.data[index].id,
                                                  );
                                                  if (code == 200) {
                                                    Navigator.of(context).pop();
                                                    await showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDiaLogCustom(
                                                            json:
                                                                "assets/done.json",
                                                            text:
                                                                "Sản phẩm đã được thêm vào bộ yêu thích.",
                                                          );
                                                        });
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Colors.green,
                                                  size: 30,
                                                )),
                                          ),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 5),
                                      itemCount: snapshot.data.length),
                                );
                              }),
                          const SizedBox(height: 24.0),
                          (state.data) ? _input() : Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              (state.data)
                                  ? ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                buttonColor),
                                      ),
                                      onPressed: () async {
                                        var data =
                                            await RepositoryFavorite.addTitle(
                                                controller.text);
                                        if (data == 200) {
                                          await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDiaLogCustom(
                                                  json: "assets/done.json",
                                                  text: "Tạo mới thành công.",
                                                );
                                              });
                                          _favorites.eventSink
                                              .add(UserEvent.showFavorite);
                                        } else {
                                          await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDiaLogCustom(
                                                  json: "assets/error.json",
                                                  text: "Tạo mới thất bại.",
                                                );
                                              });
                                        }
                                        _eventFavorite.openFavoriteSink
                                            .add(false);
                                      },
                                      child: const Text(
                                        "Hoàn tất",
                                        style: TextStyle(
                                          fontSize: 22.0,
                                        ),
                                      ),
                                    )
                                  : ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                buttonColor),
                                      ),
                                      onPressed: () {
                                        _eventFavorite.openFavoriteSink
                                            .add(true);
                                      },
                                      child: const Text(
                                        "Tạo mới",
                                        style: TextStyle(
                                          fontSize: 22.0,
                                        ),
                                      ),
                                    ),
                              const SizedBox(width: 20.0),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(buttonColor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Hủy",
                                  style: TextStyle(
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _input() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey.shade500,
        ),
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        onFieldSubmitted: (value) {},
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.collections),
          floatingLabelStyle: TextStyle(
            fontSize: 22,
            color: Colors.grey.shade500,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
          errorStyle: const TextStyle(fontSize: 18),
          labelText: "Tên",
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade500,
          ),
        ),
        validator: (value) {
          if (value.isEmpty ||
              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
            return 'Enter a valid email!';
          }
          return null;
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class AlertDiaLogCustom extends StatefulWidget {
  AlertDiaLogCustom({Key key, this.json, this.text, this.navigator})
      : super(key: key);
  final String json, text;
  String navigator;
  @override
  State<AlertDiaLogCustom> createState() => _AlertDiaLogCustomState();
}

class _AlertDiaLogCustomState extends State<AlertDiaLogCustom>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        (widget.navigator == null)
            ? Navigator.pop(context)
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );

        controller.reset();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Lottie.asset(widget.json, controller: controller, repeat: false,
            onLoaded: (p0) {
          controller.duration = p0.duration;
          controller.forward();
        }, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(widget.text,
              style: TextStyle(fontSize: 22, color: Colors.grey.shade600)),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

 