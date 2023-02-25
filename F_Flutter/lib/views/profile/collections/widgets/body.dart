import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/favorites_model.dart';
import 'package:fluter_19pmd/repository/favorites_api.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:fluter_19pmd/views/profile/collections/open_item_collection.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  Body({Key key, this.isCreated, this.isDeleted}) : super(key: key);
  bool isCreated;
  final bool isDeleted;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _openFavorite = EventForUserInFavorite();
  final _formController = TextEditingController();
  final _favorites = ProfileBloc();
  @override
  void initState() {
    super.initState();
    _favorites.eventSink.add(UserEvent.showFavorite);
  }

  @override
  void dispose() {
    super.dispose();
    _formController.dispose();
    _openFavorite.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<List<Favorites>>(
        initialData: null,
        stream: _favorites.userFavoriteStream,
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              _form(widget.isCreated, size),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => Card(
                    child: ExpansionTile(
                      leading: Text(
                        '${index + 1}.',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      title: Text(
                        snapshot.data[index].title,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      trailing: AnimatedContainer(
                        width: (widget.isDeleted) ? 30 : 0,
                        height: 30,
                        duration: const Duration(seconds: 1),
                        child: InkWell(
                          onTap: () async {
                            var code = await RepositoryFavorite.deleteFavorite(
                                snapshot.data[index].id);
                            if (code == 200) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDiaLogCustom(
                                      json: "assets/done.json",
                                      text: "Xóa bộ yêu thích thành công.",
                                    );
                                  });
                              _favorites.eventSink.add(UserEvent.showFavorite);
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDiaLogCustom(
                                      json: "assets/error.json",
                                      text: "Thất bại.",
                                    );
                                  });
                            }
                          },
                          child: Image.asset(
                            "assets/images/icons-png/trash.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                      children: [
                        (snapshot.data[index].products != null)
                            ? SizedBox(
                                height: RepositoryFavorite.getHeight(
                                    snapshot.data[index].products.length),
                                child: ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (context, int) =>
                                        const SizedBox(height: 5),
                                    itemCount:
                                        snapshot.data[index].products.length,
                                    itemBuilder: (context, int) => ListTile(
                                        leading: Image.network(
                                          snapshot
                                              .data[index].products[int].image,
                                          height: 80,
                                          width: 80,
                                        ),
                                        title: Text(
                                          '${snapshot.data[index].products[int].name}-${convertToVND(snapshot.data[index].products[int].price)}đ',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        trailing: InkWell(
                                          onTap: () async {
                                            var code = await RepositoryFavorite
                                                .deleteProduct(
                                                    snapshot.data[index]
                                                        .products[int].id,
                                                    favoriteID: snapshot
                                                        .data[index].id);
                                            if (code == 200) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDiaLogCustom(
                                                      json: "assets/done.json",
                                                      text:
                                                          "Xóa sản phẩm thành công.",
                                                    );
                                                  });
                                              _favorites.eventSink
                                                  .add(UserEvent.showFavorite);
                                            }
                                          },
                                          child: const Icon(
                                            Icons.clear,
                                            color: Colors.black,
                                          ),
                                        ))),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _form(isCreated, size) => AnimatedContainer(
        width: widget.isCreated ? size.width : 0.0,
        height: widget.isCreated ? 80.0 : 0.0,
        duration: const Duration(seconds: 2),
        alignment: widget.isCreated
            ? Alignment.centerLeft
            : AlignmentDirectional.topCenter,
        curve: Curves.fastOutSlowIn,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: TextFormField(
          controller: _formController,
          style: const TextStyle(fontSize: 20),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.send,
          onFieldSubmitted: (value) async {
            var data = await RepositoryFavorite.addTitle(value);
            if (data == 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDiaLogCustom(
                      json: "assets/done.json",
                      text: "Đã tạo bộ yêu thích.",
                    );
                  });
              _favorites.eventSink.add(UserEvent.showFavorite);
              widget.isCreated = false;
              _formController.text = "";
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDiaLogCustom(
                      json: "assets/error.json",
                      text: "Tạo thất bại.",
                    );
                  });
            }
          },
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
            border: widget.isCreated ? const OutlineInputBorder() : null,
            errorStyle: const TextStyle(fontSize: 20),
            labelText: "Nhập tên",
            labelStyle: const TextStyle(fontSize: 20, color: Colors.teal),
          ),
         
        ),
      );
}
