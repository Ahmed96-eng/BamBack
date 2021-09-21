import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingMethodWidget extends StatelessWidget {
  const RatingMethodWidget({
    required this.width,
    required this.initialRating,
  });

  final double width;
  final double? initialRating;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 15,
      initialRating: initialRating!,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      ignoreGestures: true,
      itemPadding: EdgeInsets.symmetric(horizontal: width * 0.005),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        return;
      },
    );
  }
}
