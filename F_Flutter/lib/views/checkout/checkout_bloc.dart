import 'dart:async';

import '../../repository/voucher_api.dart';

class VoucherBloc {
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get getSink => _stateStreamController.sink;
  Stream<int> get getStream => _stateStreamController.stream;

  VoucherBloc() {
    getSink.add(RepositoryVoucher.sale);
  }

  void dispose() {
    _stateStreamController.close();
  }
}
