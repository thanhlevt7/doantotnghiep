import 'dart:convert';
import 'package:fluter_19pmd/views/profile/account/widgets/address/google_map_address_page.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/address/specific_address_page.dart';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import '../../../../../repository/user_api.dart';

// ignore: camel_case_types
class CreateAddress extends StatefulWidget {
  const CreateAddress({Key key}) : super(key: key);

  @override
  State<CreateAddress> createState() => _CreateAddressState();
}

// ignore: camel_case_types
class _CreateAddressState extends State<CreateAddress> {
  int current = 0;
  List<dynamic> provinces = [];
  List<dynamic> districts = [];
  List<dynamic> wards = [];

  String idProvince;
  String idDistrict;
  String idWard;
  double latitude;
  double longitude;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    getProvinces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Khu vực"),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: GestureDetector(
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
                    content: provinces.isNotEmpty
                        ? SizedBox(
                            height: 600,
                            child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(provinces[index]['name']),
                                      onTap: () {
                                        setState(() {
                                          current = current + 1;
                                          idProvince =
                                              provinces[index]['id'].toString();
                                          getDistricts(idProvince.toString());
                                          idDistrict = "";
                                          idWard = "";
                                          districts.clear();
                                          wards.clear();
                                          RepositoryUser.province =
                                              provinces[index]['name'];
                                        });
                                      },
                                    ),
                                  );
                                },
                                itemCount: provinces.length),
                          )
                        : const CircularProgressIndicator()),
                Step(
                  state: current > 1 ? StepState.complete : StepState.indexed,
                  isActive: current >= 1,
                  title: const Text("Chọn Quận/Huyện"),
                  content: districts.isNotEmpty
                      ? SizedBox(
                          height: 550,
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(districts[index]['name']),
                                    onTap: () async {
                                      setState(() {
                                        wards.clear();
                                        current = current + 1;
                                        idDistrict =
                                            districts[index]['id'].toString();
                                        getWards(idDistrict.toString());
                                        idWard = "";
                                        RepositoryUser.district =
                                            districts[index]['name'];
                                      });
                                    },
                                  ),
                                );
                              },
                              itemCount: districts.length),
                        )
                      : const CircularProgressIndicator(),
                ),
                Step(
                  state: current > 2 ? StepState.complete : StepState.indexed,
                  isActive: current >= 2,
                  title: const Text("Chọn Phường/Xã"),
                  content: wards.isNotEmpty
                      ? SizedBox(
                          height: 450,
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    title: Text(wards[index]['name']),
                                    onTap: () {
                                      setState(() {
                                        RepositoryUser.ward =
                                            wards[index]['name'];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SpecificAddress(),
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                );
                              },
                              itemCount: wards.length),
                        )
                      : const CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getProvinces() async {
    final url = Uri.parse("https://provinces.open-api.vn/api/p");

    final response = await https.get(url);
    final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    if (provinces.isEmpty) {
      json.forEach((element) {
        setState(() {
          provinces.add({"id": element['code'], "name": element['name']});
        });
      });
    }
  }

  void getDistricts(id) async {
    final url = Uri.parse("https://provinces.open-api.vn/api/p/$id?depth=2");

    final response = await https.get(url);
    final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    final district = json['districts'];
    if (districts.isEmpty) {
      district.forEach((element) {
        setState(() {
          districts.add({
            "id": element['code'],
            "name": element['name'],
          });
        });
      });
    }
  }

  void getWards(id) async {
    final url = Uri.parse("https://provinces.open-api.vn/api/d/$id?depth=2");

    final response = await https.get(url);
    final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    final ward = json['wards'];

    if (wards.isEmpty) {
      ward.forEach((element) {
        setState(() {
          wards.add({
            "id": element['code'],
            "name": element['name'],
          });
        });
      });
    }
  }
}
