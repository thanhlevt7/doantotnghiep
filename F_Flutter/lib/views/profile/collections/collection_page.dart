import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:fluter_19pmd/views/profile/collections/widgets/body.dart';
import 'package:flutter/material.dart';

import 'open_item_collection.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key key}) : super(key: key);

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final _formController = TextEditingController();
  final _isLoading = LoadingBloc();
  final _favorites = ProfileBloc();
  final _eventFavorite = EventForUserInFavorite();
  @override
  void initState() {
    super.initState();
    _favorites.eventSink.add(UserEvent.showFavorite);
  }

  @override
  void dispose() {
    super.dispose();
    _formController.dispose();
    _isLoading.dispose();
    _favorites.dispose();
    _eventFavorite.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<bool>(
          initialData: false,
          stream: _isLoading.loadingStream,
          builder: (context, state) {
            return StreamBuilder<bool>(
                initialData: false,
                stream: _eventFavorite.deleteTitleStream,
                builder: (context, stateSecond) {
                  return Scaffold(
                    backgroundColor: Colors.grey.shade200,
                    appBar: AppBar(
                      flexibleSpace: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.teal, Colors.teal.shade200],
                            begin: Alignment.bottomLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      elevation: 0.5,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      title: const Text(
                        "Bộ yêu thích",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: InkWell(
                            onTap: () {
                              (stateSecond.data)
                                  ? _eventFavorite.deleteTitleSink.add(false)
                                  : _eventFavorite.deleteTitleSink.add(true);
                            },
                            child: Text(
                              (stateSecond.data) ? "Hoàn tất" : "Xóa",
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    body: GestureDetector(
                      onTap: () {
                        _isLoading.loadingSink.add(false);
                      },
                      child: Body(
                        isCreated: state.data,
                        isDeleted: stateSecond.data,
                      ),
                    ),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: () {
                        (state.data)
                            ? _isLoading.loadingSink.add(false)
                            : _isLoading.loadingSink.add(true);
                      },
                      label: const Text(
                        'Tạo mới',
                        style: TextStyle(fontSize: 19),
                      ),
                      icon: const Icon(Icons.add),
                      backgroundColor: Colors.teal,
                    ),
                  );
                });
          }),
    );
  }
}
