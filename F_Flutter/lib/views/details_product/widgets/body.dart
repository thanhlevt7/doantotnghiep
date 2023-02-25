import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/views/details_product/widgets/description_counter.dart';
import 'package:fluter_19pmd/views/details_product/widgets/user_review.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.details}) : super(key: key);
  final Product details;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DescriptionWidthCounter(
            description: widget.details.description,
            stock: widget.details.stock,
            price: widget.details.price,
            sell: widget.details.total.toString(),
          ),
          UserReview(
            userReview: widget.details.reviews,
            rating: widget.details.rating.toString(),
            countReviews: widget.details.countReviews.toString(),
          ),
        ],
      ),
    );
  }
}
