import 'dart:async';
import 'package:fluter_19pmd/models/reviews_models.dart';
import 'package:fluter_19pmd/repository/review_api.dart';

enum ReviewEvent { getReviewsForUser }

class ReviewsBloc {
  final _stateStreamController = StreamController<List<Review>>();
  StreamSink<List<Review>> get _reviewsSink => _stateStreamController.sink;
  Stream<List<Review>> get reviewsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<ReviewEvent>();
  StreamSink<ReviewEvent> get eventSink => _eventStreamController.sink;
  Stream<ReviewEvent> get _eventStream => _eventStreamController.stream;
  ReviewsBloc() {
    _eventStream.listen((event) async {
      if (event == ReviewEvent.getReviewsForUser) {
        var reviews = await RepositoryReview.getReviewsForUser();
        _reviewsSink.add(reviews);
      }
    });
  }

  void dispose() {
    _stateStreamController.close();
  }
}
