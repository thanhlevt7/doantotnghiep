import 'dart:async';
import 'dart:convert';

import 'package:fluter_19pmd/function.dart';
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
          "__LOCALE__null=VN; csrftoken=rokSn20kcKDw6jL3sHJCU439uy6yhpe9; SPC_SI=CH4aZAAAAABnU2FnaGM2NGI8jAAAAAAAbWRhYjBrZmw=; _gcl_au=1.1.1846303739.1679715281; SPC_F=ydisQwYQRa4ZftKPYUY5zzlE8E2S2uZq; REC_T_ID=faada272-cabd-11ed-9e66-347379171190; _fbp=fb.1.1679715281864.1059428231; _QPWSDCXHZQA=3844097f-bbc6-4917-ca57-7eedfb6379a0; _hjFirstSeen=1; _hjIncludedInSessionSample_868286=0; _hjSession_868286=eyJpZCI6IjUzNzQzZWJhLTJkOGYtNDVlMy05ODk1LTEzYjQ5NjEwYzBhZCIsImNyZWF0ZWQiOjE2Nzk3MTUyODM3NTIsImluU2FtcGxlIjpmYWxzZX0=; _hjAbsoluteSessionInProgress=0; AMP_TOKEN=%24NOT_FOUND; _gid=GA1.2.1807228285.1679715284; SPC_CLIENTID=eWRpc1F3WVFSYTRayskdruszzbcumcgs; SPC_U=953323022; SPC_R_T_IV=RGNTYUZSWGE1YVFNb3hacw==; SPC_T_ID=8t8NUizqdiBqxlD/Bb0RyUN+mKwswqk1+pkowyJJjo7fePPWsRk4oIoRIciOb8ibT7k3vlYasRi6BnRu6SXjyUXv/qnpOpiGF2Z7qjru7tCgt8lU2hjTODdkY0lueF7a9cqtY+fVoJzVWFZ4mMGIujwN+pjVcMVGF73Bbl5YWiw=; SPC_T_IV=RGNTYUZSWGE1YVFNb3hacw==; SPC_R_T_ID=8t8NUizqdiBqxlD/Bb0RyUN+mKwswqk1+pkowyJJjo7fePPWsRk4oIoRIciOb8ibT7k3vlYasRi6BnRu6SXjyUXv/qnpOpiGF2Z7qjru7tCgt8lU2hjTODdkY0lueF7a9cqtY+fVoJzVWFZ4mMGIujwN+pjVcMVGF73Bbl5YWiw=; _hjSessionUser_868286=eyJpZCI6IjkxMjJiNjY2LWVjYTItNWFhOS04OGM0LTQ0NmNmYzU0OTVkOCIsImNyZWF0ZWQiOjE2Nzk3MTUyODM3NDIsImV4aXN0aW5nIjp0cnVlfQ==; _dc_gtm_UA-61914164-6=1; ds=6d75ff932d91491888301723d3106010; shopee_webUnique_ccd=H2cVQMbpsddhqd1b%2FlshEw%3D%3D%7C%2FLPt%2Biaedhdy0J0m%2F4vaGYOYrx%2FlfKNcT7JPPfwYm9DyBM1ea29j8%2F0b8N1lkLRVhM3sEgnaAoQ%2BQxaW2S9KA6XjqJlEDtHo%2BA%3D%3D%7CfvfZWvp4PHVlxr2H%7C06%7C3; SPC_ST=.U1U3N05JWjNIS0Zkam9tNr8ZUqN+er0vPxo6ExWGRs2H1r/o5RJGL0pjgQ+0A/zPC4a17W3iCyNJHmOtgAknmvULpLKqdBBC61aUoazIkDyyj2r5Drtur5qNR8rdJO+JQyCRLTRQWV6ZAMYeYky8wGTqVdVs5coWoIdXYFmBpheB/azjxOX4q8sjfOLdRFC8taLSMq1qBa56pHVnuYn4hQ==; _ga_M32T05RVZT=GS1.1.1679715283.1.1.1679715443.48.0.0; _ga=GA1.1.1476749469.1679715284; SPC_EC=WGxMQkxFNFpQNHp0ZVRqZWSL6xpRKAy6713tID3/qDtL6WTTiqFE9cVEvkq/24hyv0NazU/acQ0tZYxr5stxQz71JnXZEls2HPTgkvagAyxrqnk/8bZSm725CMTfBoqu0fe7dzpionqNoHc+FgVq8RcCwQDMId2/N6nYsnBDJ/U=; useragent=TW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzExMS4wLjAuMCBTYWZhcmkvNTM3LjM2; _uafec=Mozilla%2F5.0%20(Windows%20NT%2010.0%3B%20Win64%3B%20x64)%20AppleWebKit%2F537.36%20(KHTML%2C%20like%20Gecko)%20Chrome%2F111.0.0.0%20Safari%2F537.36; "
    });
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
