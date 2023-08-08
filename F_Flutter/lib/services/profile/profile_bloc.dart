import 'dart:async';

import 'package:fluter_19pmd/models/favorites_model.dart';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/repository/favorites_api.dart';
import 'package:fluter_19pmd/repository/user_api.dart';

enum UserEvent {
  fetch,
  fetchAddress,
  showFavorite,
  offFavorite,
}

class ProfileBloc {
  final _stateStreamController = StreamController<User>();
  StreamSink<User> get _userOnlineSink => _stateStreamController.sink;
  Stream<User> get userOnlineStream => _stateStreamController.stream;

  final _stateAddressController = StreamController<List<Address>>();
  StreamSink<List<Address>> get _userAddressSink =>
      _stateAddressController.sink;
  Stream<List<Address>> get userAddressStream => _stateAddressController.stream;

  final _stateFavoriteController = StreamController<List<Favorites>>();
  StreamSink<List<Favorites>> get _userFavoriteSink =>
      _stateFavoriteController.sink;
  Stream<List<Favorites>> get userFavoriteStream =>
      _stateFavoriteController.stream;

  final _eventStreamController = StreamController<UserEvent>();
  StreamSink<UserEvent> get eventSink => _eventStreamController.sink;
  Stream<UserEvent> get _eventStream => _eventStreamController.stream;

  ProfileBloc() {
    _eventStream.listen((event) async {
      if (event == UserEvent.fetch) {
        var user = await RepositoryUser.fetchUserOnline();
        _userOnlineSink.add(user);
      } else if (event == UserEvent.fetchAddress) {
        var user = await RepositoryUser.fetchUserOnline();
        _userAddressSink.add(user.address);
      } else if (event == UserEvent.showFavorite) {
        var favorites = await RepositoryFavorite.showFavorite();
        _userFavoriteSink.add(favorites);
      } else if (event == UserEvent.offFavorite) {
        _userFavoriteSink.add(null);
      }
    });
  }
  void dispose() {
    _stateStreamController.close();
    _stateAddressController.close();
    _stateFavoriteController.close();
  }
}
