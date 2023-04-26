import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class HeaderWithAvatar extends StatefulWidget {
  const HeaderWithAvatar({Key key, this.user}) : super(key: key);
  final User user;

  @override
  State<HeaderWithAvatar> createState() => _HeaderWithAvatarState();
}

class _HeaderWithAvatarState extends State<HeaderWithAvatar> {
  final cloudinary = CloudinaryPublic('thanhlevt7', 'amdyfjvl', cache: false);
  Future getImage(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      Navigator.of(context, rootNavigator: true).pop();
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image),
      );
      RepositoryUser.updateImage(response.secureUrl);
      Fluttertoast.showToast(msg: "Đã cập nhật", fontSize: 22);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height * 0.33,
      child: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height * 0.3,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.teal.shade200],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: <Widget>[
                buildHeader(size, context),
                buildAvatar(size, RepositoryUser.info.avatar),
              ],
            ),
          ),
          buildNameUser(size, widget.user.username),
        ],
      ),
    );
  }

  Stack buildAvatar(Size size, String avatar) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(70),
            ),
          ),
          height: size.height * 0.2,
          width: size.width * 0.37,
          child: (avatar == null || avatar.isEmpty)
              ? const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://res.cloudinary.com/thanhlevt7/image/upload/v1678943288/image_flutter/u2swpnxwfv3s15on7ngo.png"),
                )
              : CircleAvatar(
                  backgroundImage: NetworkImage(avatar),
                ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            height: size.height * 0.05,
            width: size.width * 0.1,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: IconButton(
              onPressed: () {
                diglog();
              },
              icon: const Icon(Icons.camera_alt),
            ),
          ),
        ),
      ],
    );
  }

  diglog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () {
                    getImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.image),
                  title: const Text("Bộ sưu tập"),
                  onTap: () {
                    getImage(ImageSource.gallery);
                  },
                )
              ],
            ),
          );
        });
  }

  Row buildHeader(Size size, BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: size.width,
          height: size.height * 0.07,
          child: const Center(
            child: Text(
              "Hồ sơ",
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                letterSpacing: 5,
                fontFamily: "RobotoSlab",
              ),
            ),
          ),
        ),
      ],
    );
  }

  Positioned buildNameUser(Size size, String fullName) {
    return Positioned(
      left: size.width / 5,
      bottom: 5,
      child: Container(
        width: size.width * 0.6,
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: Center(
          child: (fullName == null)
              ? const Text(
                  "",
                )
              : Text(
                  fullName,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 18,
                    letterSpacing: 1,
                    fontFamily: "RobotoSlab",
                  ),
                ),
        ),
      ),
    );
  }
}
