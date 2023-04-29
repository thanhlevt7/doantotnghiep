import 'dart:async';
import 'dart:convert';

import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as https;

// ignore: must_be_immutable
class GoogleMapAddress extends StatefulWidget {
  GoogleMapAddress({Key key, this.latitude, this.longitude}) : super(key: key);
  double latitude;
  double longitude;

  @override
  State<GoogleMapAddress> createState() => GoogleMapAddressState();
}

class GoogleMapAddressState extends State<GoogleMapAddress> {
  GoogleMapController googleMapController;
  List province = [];
  double latitude;
  double longitude;
  @override
  void initState() {
    latitude = widget.latitude;
    longitude = widget.longitude;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LatLng location = LatLng(widget.latitude, widget.longitude);

    return Scaffold(
      appBar: appbar("Sửa vị trí", context),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
            onCameraMove: (value) {
              setState(() {
                latitude = value.target.latitude;
                longitude = value.target.longitude;
              });
            },
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: location, zoom: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Center(
                child: Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.red,
              ),
              child: const Center(
                child: Text(
                  "Địa chỉ của bạn ở đây",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )),
          ),
          const Center(
            child: Icon(
              Icons.location_on,
              color: Colors.red,
              size: 36,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 120, right: 12),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 42,
                width: 40,
                alignment: Alignment.center,
                color: Colors.white,
                child: Center(
                  child: IconButton(
                      iconSize: 28,
                      onPressed: () {
                        googleMapController.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                target:
                                    LatLng(widget.latitude, widget.longitude),
                                zoom: 16)));
                        setState(() {});
                      },
                      icon: const Icon(Icons.my_location)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.teal),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () async {
                          await getLocation();
                          if (province.isEmpty) {
                            _notification(context, "Không tìm thấy địa chỉ",
                                RepositoryUser.province);
                          } else {
                            if (RepositoryUser.province == (province[0])) {
                              if (RepositoryUser.district == (province[1])) {
                                if (RepositoryUser.ward == (province[2])) {
                                  RepositoryUser.createAddress(
                                      RepositoryUser.address);
                                  EasyLoading.showSuccess(
                                      'Tạo địa chỉ thành công');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                } else {
                                  _notification(context, province[2],
                                      RepositoryUser.ward);
                                }
                              } else {
                                _notification(context, province[1],
                                    RepositoryUser.district);
                              }
                            } else {
                              _notification(context, province[0],
                                  RepositoryUser.province);
                            }
                          }
                        },
                        child: const Text("Xác nhận ")),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future getLocation() async {
    province.clear();
    final url = Uri.parse(
        "https://shopee.vn/api/v4/location/get_division_hierarchy_by_geo?lat=$latitude&lon=$longitude&useCase=shopee.account");
    var response =
        await https.get(url, headers: {'cookie': RepositoryUser.cookie});
    final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    if (json['data'] == null) {
    } else {
      final data = json['data']['division_info_list'];
      if (province.isEmpty) {
        data.forEach((e) {
          province.add(e['division_name']);
        });
        setState(() {});
      }
    }
  }

  Future<void> _notification(
      context, String thisPosition, String selectedArea) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Ui, địa điểm này không nằm trong khu vực của bạn đã chọn"),
              const SizedBox(height: 5),
              const Text("Địa điểm này: "),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Text(thisPosition),
              ),
              const Text("Khu vực bạn đã chọn:"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Text(selectedArea),
              ),
              const Text("Ban hãy kiểm tra khu vực đã chọn ở trang trước nhé"),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            ),
          ],
        );
      },
    );
  }
}
