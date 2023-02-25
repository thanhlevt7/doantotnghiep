import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/account_information.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/address/address.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _profileBloc = ProfileBloc();
  @override
  void initState() {
    super.initState();
    _profileBloc.eventSink.add(UserEvent.fetch);
  }

  @override
  void dispose() {
    super.dispose();
    _profileBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        initialData: null,
        stream: _profileBloc.userOnlineStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return SingleChildScrollView(
              child: Column(
                children: const [
                  SizedBox(height: 340),
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AccountInformation(user: snapshot.data),
                  const SizedBox(height: 30),
                  AddressManagement(addresses: snapshot.data.address),
                ],
              ),
            );
          }
        });
  }
}
