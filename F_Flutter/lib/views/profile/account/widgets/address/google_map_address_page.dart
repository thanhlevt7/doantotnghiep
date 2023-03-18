import 'dart:async';
import 'dart:convert';

import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      appBar: AppBar(
        title: const Text("Sửa vị trí"),
        backgroundColor: Colors.teal,
      ),
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
                                  Fluttertoast.showToast(
                                      msg: "Tạo địa chỉ thành công",
                                      fontSize: 20);
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
    var response = await https.get(url, headers: {
      'cookie':
          "__LOCALE__null=VN; _gcl_au=1.1.483903268.1678507608; _fbp=fb.1.1678507608715.1543979970; csrftoken=etvoW0Mx9qyuETGoG51lRlkHIlvIa6dv; SPC_SI=GqzsYwAAAABhdHBwSkxpYtNkEwQAAAAAOUFkY1hNREM=; SPC_F=u8rqgPH4426sy6AaN4dUMiqwc52p50zT; REC_T_ID=27cf1f7a-bfc2-11ed-b3da-3c15fb7e9af8; _hjFirstSeen=1; _hjIncludedInSessionSample_868286=0; _hjSession_868286=eyJpZCI6ImU5ZmFmODRlLTZmYjAtNDA1ZC04YjI0LWI1ZGU5MDNkN2VhYiIsImNyZWF0ZWQiOjE2Nzg1MDc2MTI2NTMsImluU2FtcGxlIjpmYWxzZX0=; _hjAbsoluteSessionInProgress=1; AMP_TOKEN=%24NOT_FOUND; _gid=GA1.2.1385669630.1678507613; _QPWSDCXHZQA=19e90644-688f-43fa-c953-b24431ed9217; SPC_CLIENTID=dThycWdQSDQ0MjZzlnzdyrkgysadgwku; SPC_U=953323022; SPC_R_T_ID=oJHao9AhaBl3euEVjTJgCsa6B1fnd7wCGPabYOEjOybJEcY2E5ZTGcbrtuuMl6mYnuh/Zu89VlwuSAR26eMCbNTkly809/5NIgU6kj/SCDZmamFlblUo2/4phrCxQAYqcfzOn5FugVHbu9HqOzmt1vI5OUuD709D9eZ79rBOmTQ=; SPC_R_T_IV=QjZQbnpudGNzWnRzclpvVw==; SPC_T_ID=oJHao9AhaBl3euEVjTJgCsa6B1fnd7wCGPabYOEjOybJEcY2E5ZTGcbrtuuMl6mYnuh/Zu89VlwuSAR26eMCbNTkly809/5NIgU6kj/SCDZmamFlblUo2/4phrCxQAYqcfzOn5FugVHbu9HqOzmt1vI5OUuD709D9eZ79rBOmTQ=; SPC_T_IV=QjZQbnpudGNzWnRzclpvVw==; _hjSessionUser_868286=eyJpZCI6ImE3MDdhNTJiLWQ3ZDktNWYwMy1hODZiLTAxYjk1M2VlODc0OCIsImNyZWF0ZWQiOjE2Nzg1MDc2MTI2NDMsImV4aXN0aW5nIjp0cnVlfQ==; _ga=GA1.1.983914170.1678507613; _dc_gtm_UA-61914164-6=1; ds=1d5d1348d449ad71626ffaae801ab98f; shopee_webUnique_ccd=ZrU5yuDxj11t%2FaSTWF%2Fhuw%3D%3D%7CdJzAoCwllgyKpfeKgJ5uNAC0TLD1tot4zyoSqHWL5KbNXNshlCiqvipvvMEMvO6gUvy8juV05SL4TdebKZ9DlGuWv4eBXRRJQBE%3D%7Ck9m2sG2K1A8blEC2%7C06%7C3; SPC_ST=.NVdjNVRpUzFZalhUcWdtSESh4EpHw55K56SuQgWfHPyjAu7o0ZcIiV7R76FTr3xro97NPrYf71jl+RSx9xFwxHskNcFg5aVAlK9lG6kp3mGsENFpnhegxR0qoy+uliOYoMDtbP+wnB4V4HbDBBi8VAuEP24fzPM5jBvwUrc7lkJQt4It8VRJYugOEYNdXofyidXTdGH7hySUCOqqrVTGTw==; _ga_M32T05RVZT=GS1.1.1678507612.1.1.1678508134.53.0.0; SPC_EC=cEpmQWk2ZnNCNEhZMEN1Vi/g7KZM/au1Zv+myci0tERAVnUoqpGVnNUlIbe9olqhgHw87D/3MYYvvVy80sef9hJjKKjL6BLqBmtdEu6ijt1dU+fZcTEA+VVr4JL6OyL4AdoihFdgTCVXpwlTR8BY0kae7P0qT+YQvkD1fMLVBJE=; useragent=TW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzExMC4wLjAuMCBTYWZhcmkvNTM3LjM2; _uafec=Mozilla%2F5.0%20(Windows%20NT%2010.0%3B%20Win64%3B%20x64)%20AppleWebKit%2F537.36%20(KHTML%2C%20like%20Gecko)%20Chrome%2F110.0.0.0%20Safari%2F537.36; "
    });
    final json = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    print(url);
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
