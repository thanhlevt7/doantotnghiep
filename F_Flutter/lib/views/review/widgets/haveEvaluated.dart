import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/models/reviews_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/services/review/review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HaveEvaluated extends StatefulWidget {
  const HaveEvaluated({Key key}) : super(key: key);

  @override
  State<HaveEvaluated> createState() => _HaveEvaluatedState();
}

class _HaveEvaluatedState extends State<HaveEvaluated> {
  final _reviewsBloc = ReviewsBloc();
  List<String> imageReviews;
  List<Product> product;
  List<String> imageProduct;

  @override
  void initState() {
    _reviewsBloc.eventSink.add(ReviewEvent.getReviewsForUser);
    super.initState();
  }

  @override
  void dispose() {
    _reviewsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Review>>(
        initialData: const [],
        stream: _reviewsBloc.reviewsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 15,
                              ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data[index].image != null) {
                              final image = snapshot.data[index].image;
                              imageReviews = image.split(",");
                            } else {
                              imageReviews = null;
                            }
                            final images = snapshot.data[index].imageProduct;
                            imageProduct = images.split(",");
                            DateFormat dateFormat =
                                DateFormat("dd-MM-yyyy HH:mm:ss");
                            String dateTime = dateFormat
                                .format(snapshot.data[index].postedDate);
                            return ListTile(
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      RepositoryUser.info.avatar.isNotEmpty
                                          ? RepositoryUser.info.avatar
                                          : imageUser)),
                              title: Text(RepositoryUser.info.username),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _star(
                                      snapshot.data[index].quantity.toString()),
                                  Text(
                                    dateTime,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  snapshot.data[index].content != null
                                      ? Container(
                                          width: 280,
                                          padding: const EdgeInsets.all(8.0),
                                          margin: const EdgeInsets.only(
                                              right: 40.0),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(16),
                                            ),
                                          ),
                                          child: Text(
                                            snapshot.data[index].content,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.teal.shade700,
                                              letterSpacing: 1.0,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 3,
                                          ),
                                        )
                                      : const SizedBox(height: 0),
                                  imageReviews == null
                                      ? Container(
                                          height: 0,
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 100,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: imageReviews.length,
                                                itemBuilder: (context, index) {
                                                  return Image.network(
                                                    imageReviews[index],
                                                    height: 100,
                                                    width: 100,
                                                    errorBuilder:
                                                        (context, url, error) =>
                                                            const Icon(
                                                      Icons.error,
                                                      size: 50,
                                                    ),
                                                    fit: BoxFit.scaleDown,
                                                  );
                                                }),
                                          ),
                                        ),
                                  Card(
                                    child: Row(
                                      children: [
                                        Image.network(
                                          imageProduct[0],
                                          height: 80,
                                          width: 80,
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            snapshot.data[index].nameProduct,
                                            style:
                                                const TextStyle(fontSize: 16),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(
              child: Text(
                "Chưa có đơn hàng",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        });
  }
}

Widget _star(String quantity) => (quantity == "1")
    ? Row(
        children: const [
          Icon(Icons.star, color: Colors.yellow),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
        ],
      )
    : (quantity == "0")
        ? Row(
            children: const [
              Icon(
                Icons.star,
                color: Colors.grey,
              ),
              Icon(
                Icons.star,
                color: Colors.grey,
              ),
              Icon(
                Icons.star,
                color: Colors.grey,
              ),
              Icon(
                Icons.star,
                color: Colors.grey,
              ),
              Icon(
                Icons.star,
                color: Colors.grey,
              ),
            ],
          )
        : (quantity == "2")
            ? Row(
                children: const [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.grey,
                  ),
                ],
              )
            : (quantity == "3")
                ? Row(
                    children: const [
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                    ],
                  )
                : (quantity == "4")
                    ? Row(
                        children: const [
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(
                            Icons.star,
                            color: Colors.grey,
                          ),
                        ],
                      )
                    : (quantity == "5")
                        ? Row(
                            children: const [
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                              Icon(Icons.star, color: Colors.yellow),
                            ],
                          )
                        : null;
