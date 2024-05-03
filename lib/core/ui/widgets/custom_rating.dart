// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';

class CustomRating extends StatefulWidget {
  final double initRating;
  final bool update;
  final bool showRateText;

  const CustomRating({
    Key? key,
    required this.initRating,
    required this.update,
    required this.showRateText,
  }) : super(key: key);

  @override
  State<CustomRating> createState() => _CustomRatingState();
}

class _CustomRatingState extends State<CustomRating> {
  late double rating;
  @override
  void initState() {
    super.initState();
    rating = widget.initRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingBar.builder(
          itemBuilder: (context, index) {
            return Icon(
              Icons.star,
              color: ColorManager.starColorRate,
            );
          },
          onRatingUpdate: (value) {
            if (widget.update) {
              setState(() {
                rating = value;
              });
            }
          },
          direction: Axis.horizontal,
          glowColor: ColorManager.starColorRate,
          unratedColor: Colors.grey,
          itemSize: 14,
          updateOnDrag: widget.update,
          ignoreGestures: widget.update,
          initialRating: rating,
        ),
        if (widget.showRateText) ...[
          SizedBox(
            width: 8,
          ),
          Text(rating.toStringAsFixed(1),style: TextStyle(fontSize: 12,fontFamily: 'Roboto'),),
        ]
      ],
    );
  }
}
