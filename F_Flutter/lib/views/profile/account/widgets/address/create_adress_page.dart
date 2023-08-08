import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/address/specific_address_page.dart';
import 'package:flutter/material.dart';
import '../../../../../repository/user_api.dart';

class CreateAddress extends StatefulWidget {
  const CreateAddress({Key key}) : super(key: key);

  @override
  State<CreateAddress> createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
  int current = 0;
  String idProvince;
  String idDistrict;
  String idWard;
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Khu vực", context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(primary: Colors.teal)),
          child: Stepper(
            onStepTapped: (value) {
              setState(() {
                if (current > value) {
                  current = value;
                }
              });
            },
            controlsBuilder:
                (context, details, {onStepContinue, onStepCancel}) => Row(
              children: [
                current != 3
                    ? const SizedBox(
                        height: 0,
                      )
                    : const SizedBox(
                        width: 0,
                      ),
              ],
            ),
            currentStep: current,
            steps: [
              Step(
                  state: current > 0 ? StepState.complete : StepState.indexed,
                  isActive: current >= 0,
                  title: const Text("Chọn Tỉnh/Thành phố"),
                  content: FutureBuilder(
                    future: RepositoryUser.getProvinces(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 600,
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(snapshot.data[index]['name']),
                                    onTap: () {
                                      setState(() {
                                        current = current + 1;
                                        idProvince = snapshot.data[index]['id']
                                            .toString();
                                        RepositoryUser.province =
                                            snapshot.data[index]['name'];
                                      });
                                    },
                                  ),
                                );
                              },
                              itemCount: snapshot.data.length),
                        );
                      } else {
                        // Dữ liệu đang được tải
                        return const CircularProgressIndicator();
                      }
                    },
                  )),
              Step(
                  state: current > 1 ? StepState.complete : StepState.indexed,
                  isActive: current >= 1,
                  title: const Text("Chọn Quận/Huyện"),
                  content: FutureBuilder(
                    future: RepositoryUser.getDistricts(idProvince.toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 550,
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(snapshot.data[index]['name']),
                                    onTap: () async {
                                      setState(() {
                                        current = current + 1;
                                        idDistrict = snapshot.data[index]['id']
                                            .toString();
                                        RepositoryUser.district =
                                            snapshot.data[index]['name'];
                                      });
                                    },
                                  ),
                                );
                              },
                              itemCount: snapshot.data.length),
                        );
                      } else {
                        // Dữ liệu đang được tải
                        return const CircularProgressIndicator();
                      }
                    },
                  )),
              Step(
                  state: current > 2 ? StepState.complete : StepState.indexed,
                  isActive: current >= 2,
                  title: const Text("Chọn Phường/Xã"),
                  content: FutureBuilder(
                    future: RepositoryUser.getWards(idDistrict),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 450,
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(snapshot.data[index]['name']),
                                    onTap: () {
                                      RepositoryUser.ward =
                                          snapshot.data[index]['name'];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SpecificAddress(),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              itemCount: snapshot.data.length),
                        );
                      } else {
                        // Dữ liệu đang được tải
                        return const CircularProgressIndicator();
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
