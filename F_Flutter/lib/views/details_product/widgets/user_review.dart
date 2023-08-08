import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/reviews_models.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserReview extends StatefulWidget {
  const UserReview({Key key, this.userReview, this.rating, this.countReviews})
      : super(key: key);
  final List<Review> userReview;
  final String rating;
  final String countReviews;

  @override
  State<UserReview> createState() => _UserReviewState();
}

class _UserReviewState extends State<UserReview> {
  @override
  Widget build(BuildContext context) {
    List<String> strarray;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          _header(size),
          const SizedBox(height: 20),
          widget.rating.isEmpty
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "0",
                          style: TextStyle(fontSize: 25, color: Colors.red),
                        ),
                        const Text(
                          " trên 5",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        Text(
                          " (0 Đánh giá)",
                          style: TextStyle(
                              fontSize: 22, color: Colors.grey.shade600),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _star(0.toString()),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.rating,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.red)),
                        const Text(
                          " trên 5",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "(",
                          style: TextStyle(
                              fontSize: 20, color: Colors.grey.shade600),
                        ),
                        Text(
                          widget.countReviews,
                          style: TextStyle(
                              fontSize: 22, color: Colors.grey.shade600),
                        ),
                        Text(
                          " đánh giá ) ",
                          style: TextStyle(
                              fontSize: 20, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _star(
                            widget.rating.toString().replaceRange(1, null, ""))
                      ],
                    ),
                  ],
                ),
          const SizedBox(height: 20),
          (RepositoryProduct.getHeightForUserReview(widget.userReview.length) ==
                  0)
              ? Column(
                  children: const [
                    SizedBox(height: 40),
                    Center(
                        child: Text(
                      "Chưa có đánh giá ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                  ],
                )
              : SizedBox(
                  height: size.height *
                      RepositoryProduct.getHeightForUserReview(
                          widget.userReview.length) *
                      0.8,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.userReview.length,
                      itemBuilder: (context, index) {
                        DateFormat dateFormat =
                            DateFormat("dd-MM-yyyy HH:mm:ss");
                        String string = dateFormat
                            .format(widget.userReview[index].postedDate);
                        if (widget.userReview[index].image != null) {
                          final image = widget.userReview[index].image;
                          strarray = image.split(",");
                        } else {
                          strarray = null;
                        }
                        final currentTime = DateTime.now();
                        final orderDate = DateTime.parse(
                            widget.userReview[index].postedDate.toString());
                        final results = currentTime.difference(orderDate);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      child: (widget.userReview[index].avatar ==
                                                  null ||
                                              widget.userReview[index].avatar
                                                  .isEmpty)
                                          ? const CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(imageUser),
                                            )
                                          : CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  widget.userReview[index]
                                                      .avatar),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            widget.userReview[index].userName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          _timeComment(results)
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      _star(widget.userReview[index].quantity
                                          .toString()),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              widget.userReview[index].content != null
                                  ? Container(
                                      width: 280,
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.only(left: 40.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                      ),
                                      child: Text(
                                        widget.userReview[index].content,
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
                              strarray != null
                                  ? Container(
                                      margin: const EdgeInsets.only(left: 40.0),
                                      child: SizedBox(
                                        height: 100,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: strarray.length,
                                            itemBuilder: (context, snapshot) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4),
                                                child: Image.network(
                                                  strarray[snapshot],
                                                  width: 80,
                                                  height: 100,
                                                  errorBuilder:
                                                      (context, url, error) =>
                                                          const Icon(
                                                    Icons.error,
                                                    size: 50,
                                                  ),
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              );
                                            }),
                                      ),
                                    )
                                  : Container(
                                      height: 0,
                                    ),
                              const SizedBox(height: 5),
                              Container(
                                  margin: const EdgeInsets.only(left: 45.0),
                                  child: Text(
                                    string,
                                    style: const TextStyle(fontSize: 15),
                                  )),
                            ],
                          ),
                        );
                      }),
                ),
          // ),
        ],
      ),
    );
  }

  Row _header(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * 0.35,
          height: 1,
          color: Colors.black,
        ),
        const Text(
          "Đánh giá",
          style: TextStyle(fontSize: 24, color: Colors.teal),
        ),
        Container(
          width: size.width * 0.35,
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _timeComment(results) {
    if (results.inSeconds < 60 &&
        results.inMinutes == 0 &&
        results.inHours == 0) {
      return Text(
        '${results.inSeconds} giây trước',
        style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
      );
    } else if (results.inMinutes > 0 &&
        results.inMinutes < 60 &&
        results.inHours == 0) {
      return Text(
        '${results.inMinutes} phút trước',
        style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
      );
    } else if (results.inHours > 0 && results.inHours < 24) {
      return Text(
        '${results.inHours} giờ trước',
        style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
      );
    } else if (results.inHours / 24 > 1 && results.inHours / 24 < 30) {
      return Text(
        '${(results.inHours / 24).toInt()} ngày trước',
        style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
      );
    } else if (results.inHours / 720 > 1 && results.inHours / 720 < 13) {
      return Text(
        '${(results.inHours / 720).toInt()} tháng trước',
        style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
      );
    } else {
      return Text(
        '${(results.inHours / 8640).toInt()} Năm trước',
        style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
      );
    }
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
