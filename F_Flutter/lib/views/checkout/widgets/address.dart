import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/repository/invoice_api.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/services/checkout/address_change.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:flutter/material.dart';

class AddressInPayment extends StatefulWidget {
  const AddressInPayment({Key key}) : super(key: key);

  @override
  State<AddressInPayment> createState() => _AddressInPaymentState();
}

class _AddressInPaymentState extends State<AddressInPayment> {
  final _profileBloc = ProfileBloc();
  final _changeBLoc = AddressChange();
  @override
  void dispose() {
    super.dispose();
    _profileBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    _profileBloc.eventSink.add(UserEvent.fetchAddress);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Address>>(
        initialData: null,
        stream: _profileBloc.userAddressStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const CircularProgressIndicator(
              color: Colors.teal,
            );
          } else {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder<bool>(
                    initialData: false,
                    stream: _changeBLoc.changeStream,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Địa chỉ nhận hàng :",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder<String>(
                                  initialData: snapshot.data[0].name,
                                  stream: _changeBLoc.chooseStream,
                                  builder: (context, address) {
                                    RepositoryInvoice.getAddress = address.data;
                                    if (address.data == null) {
                                      return const Center(
                                          child: CircularProgressIndicator(
                                        color: Colors.green,
                                      ));
                                    }
                                    return Container(
                                      margin: const EdgeInsets.only(top: 15),
                                      width: 280,
                                      height: 60,
                                      child: Text(
                                        address.data,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade900,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 3,
                                      ),
                                    );
                                  }),
                              TextButton(
                                onPressed: () {
                                  (state.data)
                                      ? _changeBLoc.eventSink
                                          .add(ChangeEvent.close)
                                      : _changeBLoc.eventSink
                                          .add(ChangeEvent.open);
                                },
                                child: Text(
                                  (state.data) ? "Đóng" : "Thay đổi",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: buttonColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          (state.data)
                              ? SizedBox(
                                  height: RepositoryUser.getHeightAddress(),
                                  child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(height: 0),
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 320,
                                                  child: Text(
                                                    snapshot.data[index].name,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              iconSize: 30,
                                              onPressed: () {
                                                _changeBLoc.chooseSink.add(
                                                    snapshot.data[index].name);
                                                RepositoryInvoice.getAddress =
                                                    snapshot.data[index].name;
                                                _changeBLoc.eventSink
                                                    .add(ChangeEvent.close);
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                color: Colors.green,
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                )
                              : Container(),
                        ],
                      );
                    }),
              ),
            );
          }
        });
  }
}
