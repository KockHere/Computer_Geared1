import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Review.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.reviewUser ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          RatingBar.builder(
            initialRating: double.parse(review.rating!.toString()),
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.only(right: 8.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemSize: 20,
            ignoreGestures: true,
            onRatingUpdate: (newRating) {},
          ),
          if (review.review != "") ...[
            const SizedBox(height: 10),
            Text(
              review.review ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
