import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/address/create_adress_page.dart';
import 'package:flutter/material.dart';

class AddressManagement extends StatefulWidget {
  const AddressManagement({Key key, this.addresses}) : super(key: key);
  final List<Address> addresses;

  @override
  State<AddressManagement> createState() => _AddressManagementState();
}

class _AddressManagementState extends State<AddressManagement> {
  final nameAddress = TextEditingController();
  final _profileBloc = ProfileBloc();

  @override
  void dispose() {
    super.dispose();
    nameAddress.dispose();
    _profileBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Address>>(
        initialData: widget.addresses,
        stream: _profileBloc.userAddressStream,
        builder: (context, snapshot) {
          return Card(
            shadowColor: Colors.teal,
            elevation: 10,
            margin: const EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeaderAddress(context),
                  const SizedBox(height: 20),
                  buildListAddress(context, snapshot.data),
                ],
              ),
            ),
          );
        });
  }

  Widget buildHeaderAddress(context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Danh sách địa chỉ",
            style: TextStyle(
              fontSize: 24,
              color: buttonColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          _textButton(
              icon: Icons.add,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateAddress(),
                  ),
                );
              }),
        ],
      );

  Widget _textButton({IconData icon, Function press}) => TextButton(
        onPressed: press,
        child: Icon(
          icon,
          color: buttonColor,
        ),
      );

  Widget buildListAddress(context, list) => SizedBox(
        height: RepositoryUser.getHeightAddress(),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return const SizedBox(height: 0);
          },
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 310,
                  height: 50,
                  child: Text(
                    '+ ${list[index].name}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: textColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var check =
                        await RepositoryUser.deleteAddress(list[index].id);
                    if (check == 200) {
                      checkOut('Xóa địa chỉ thành công');
                      _profileBloc.eventSink.add(UserEvent.fetchAddress);
                    }
                    if (check == 201) {
                      checkOut('Không thể xóa');
                    }
                  },
                  child: Image.asset(
                    "assets/images/icons-png/trash.png",
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            );
          },
        ),
      );

  void checkOut(message) async {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        elevation: 10,
        backgroundColor: Colors.teal,
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
        duration: const Duration(seconds: 3),
      ));
  }
}
