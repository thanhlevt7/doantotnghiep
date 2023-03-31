import 'dart:convert';

import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/address/google_map_address_page.dart';
import 'package:flutter/material.dart';

import '../../../../../repository/user_api.dart';
import 'package:http/http.dart' as https;

class SpecificAddress extends StatefulWidget {
  const SpecificAddress({Key key}) : super(key: key);

  @override
  State<SpecificAddress> createState() => _SpecificAddressState();
}

class _SpecificAddressState extends State<SpecificAddress> {
  List suggest = [];
  String experiment;
  String components = "country%3Avn";
  String state;
  final _formKey = GlobalKey<FormState>();

  String placeid;
  double latitude;
  double longitude;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar("Địa chỉ mới", context),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Autocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  } else {
                    return suggest.map((e) => e["main_text"]);
                  }
                },
                optionsViewBuilder:
                    (context, Function(String) onSelected, options) {
                  return ListView.separated(
                    padding:
                        const EdgeInsets.only(top: 12, bottom: 12, right: 80),
                    itemBuilder: (context, index) {
                      final option = options.elementAt(index);

                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          onSelected(option.toString());
                          RepositoryUser.address =
                              suggest[index]["description"];
                          setState(() {
                            placeid = suggest[index]["placeid"];
                            suggest.clear();
                          });
                          location();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.location_on),
                            Container(
                              margin: const EdgeInsets.only(top: 0),
                              width: 300,
                              height: 40,
                              child: Text(
                                option.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.none,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w100),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      height: 15,
                    ),
                    itemCount: suggest.length,
                  );
                },
                fieldViewBuilder:
                    (context, suggestController, focusNode, onEditingComplete) {
                  return TextFormField(
                      controller: suggestController,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.teal,
                          ),
                        ),
                        hintText: "Tên đường,Tòa nhà,Số nhà.",
                        suffixIcon: suggestController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.teal,
                                ),
                                onPressed: () {
                                  setState(() {
                                    suggestController.clear();
                                  });
                                }),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          suggestAddress(
                              RepositoryUser.province,
                              RepositoryUser.district,
                              RepositoryUser.ward,
                              value);
                        }
                      },
                      // ignore: missing_return
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Không được bỏ trống';
                        }
                      });
                },
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.teal),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {
                      final isValid = _formKey.currentState.validate();
                      if (!isValid) {
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GoogleMapAddress(
                            latitude: latitude,
                            longitude: longitude,
                          ),
                        ),
                      );
                    },
                    child: const Text("Tiếp theo")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future suggestAddress(
      String province, String district, String ward, String input) async {
    String tinh = "Tỉnh ";
    String tphcm = "Thành phố Hồ Chí Minh";
    String thanhpho = "Thành phố ";
    if (province.contains(tinh)) {
      state = province.replaceAll(RegExp(tinh), "");
    }

    if (province.contains(thanhpho)) {
      if (province == tphcm) {
        state = province.replaceAll(RegExp(thanhpho), "TP. ");
      } else {
        state = province.replaceAll(RegExp(thanhpho), "");
      }
    }
    RepositoryUser.province = state;

    String sessiontoken = "a11ba2b3-v2a4-s2g2-ssw2-a2g2g4s3fs34";
    final url = Uri.parse(
        "https://shopee.vn/api/v4/geo/autocomplete?city=$district&components=$components&district=$ward&input=$input&sessiontoken=$sessiontoken&state=$state&use_case=shopee.account&v=3");
    final response = await https.get(url);
    final json = jsonDecode(response.body);
    experiment = json['experiment'];
    final predictions = json['predictions'];
    suggest.clear();
    if (suggest.isEmpty) {
      predictions.forEach((e) {
        suggest.add({
          "main_text": e['structured_formatting']['main_text'],
          "description": e['description'],
          "placeid": e['place_id']
        });
        setState(() {});
      });
    }
  }

  void location() async {
    String fields = "geometry";
    String group = "DS";
    String sessiontoken = "a11ba2b3-v2a4-s2g2-ssw2-a2g2g4s3fs34";
    final url = Uri.parse(
        "https://shopee.vn/api/v4/geo/details?components=$components&experiment=$experiment&fields=$fields&group=$group&placeid=$placeid&sessiontoken=$sessiontoken&use_case=shopee.account&v=3");
    final response = await https.get(url);
    final json = jsonDecode(response.body);
    latitude = json['result']['geometry']['location']['lat'];
    longitude = json['result']['geometry']['location']['lng'];
  }
}
