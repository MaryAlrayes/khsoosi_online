// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/utils/helpers/number_fomatter.dart';
import 'package:like_button/like_button.dart';

class LikeDislikeButtons extends StatefulWidget {
  final num likes;
  final num dislikes;
  LikeDislikeButtons({required this.likes, required this.dislikes});

  @override
  State<LikeDislikeButtons> createState() => _LikeDislikeButtonsState();
}

class _LikeDislikeButtonsState extends State<LikeDislikeButtons> {
  late num likesCount;
  late num dislikesCount;
  var isLike = false;
  var isDislike = false;
  var hasBorderDislikes = false;
  var hasBorderLikes = false;
  final key1 = GlobalKey<LikeButtonState>();
  final key2 = GlobalKey<LikeButtonState>();
  @override
  void initState() {
    super.initState();
    likesCount = widget.likes;
   
    dislikesCount = widget.dislikes;
  }

  @override
  Widget build(BuildContext context) {
    const animationDuration1 = Duration(milliseconds: 100);
    const animationDuration2 = Duration(milliseconds: 100);
    return Row(
      children: [
        _buildLikes(animationDuration2),
        _buildDislikes(animationDuration1),
      ],
    );
  }

  Expanded _buildDislikes(Duration animationDuration1) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: hasBorderDislikes
              ? BorderSide(width: 2, color: ColorManager.orange)
              : null,
        ),
        onPressed: () async {
          setState(() {
            hasBorderDislikes = !isDislike;
          });
          await Future.delayed(const Duration(milliseconds: 100));
          key1.currentState!.onTap();
        },
        child: IgnorePointer(
          child: LikeButton(
            key: key1,
            size: 40,
            animationDuration: animationDuration1,
            likeCount: dislikesCount as int,
            isLiked: isDislike,
            likeCountPadding: const EdgeInsets.all(12),
            likeBuilder: (isLiked) {
              final color = isLiked ? ColorManager.orange : Colors.grey;
              const icon = Icons.thumb_down;
              return Icon(icon, color: color);
            },
            circleColor: CircleColor(
                start: ColorManager.orange, end: ColorManager.orange),
            bubblesColor: BubblesColor(
                dotPrimaryColor: ColorManager.orange,
                dotSecondaryColor: ColorManager.orange,
                dotLastColor: ColorManager.orange,
                dotThirdColor: ColorManager.orange),
            countBuilder: (likeCount, isLiked, text) {
              final color = isLiked ? Colors.black : Colors.grey;
              return Text(
                '${formatNumber( likeCount!)}' + ' لا',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              );
            },
            onTap: (isDisliked) async {
              this.isDislike = !isDisliked;
              dislikesCount += (this.isDislike) ? 1 : -1;
              likesCount = widget.likes;
              if (isLike) {
                isLike = false;
                hasBorderLikes = false;
              }
              Future.delayed(animationDuration1).then((_) {
                return setState(() {
                  hasBorderDislikes = !isDisliked;
                });
              });
              return !isDisliked;
            },
          ),
        ),
      ),
    );
  }

  Expanded _buildLikes(Duration animationDuration2) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: hasBorderLikes
              ? BorderSide(width: 2, color: ColorManager.orange)
              : null,
        ),
        onPressed: () async {
          setState(() {
            hasBorderLikes = !isLike;
          });
          await Future.delayed(Duration(milliseconds: 100));

          key2.currentState!.onTap();
        },
        child: IgnorePointer(
          child: LikeButton(
            key: key2,
            size: 30,
            animationDuration: animationDuration2,
            likeCount: (likesCount) as int,
            isLiked: isLike,
            likeCountPadding: const EdgeInsets.all(12),
            likeBuilder: (isLiked) {
              final color = isLiked ? ColorManager.orange : Colors.grey;
              const icon = Icons.thumb_up;
              return Icon(icon, color: color);
            },
            countBuilder: (likeCount, isLiked, text) {
              final color = isLiked ? Colors.black : Colors.grey;
              return Text(
                '${formatNumber( likeCount!)}' + ' نعم',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              );
            },
            circleColor: CircleColor(
                start: ColorManager.orange, end: ColorManager.orange),
            bubblesColor: BubblesColor(
                dotPrimaryColor: ColorManager.orange,
                dotSecondaryColor: ColorManager.orange,
                dotLastColor: ColorManager.orange,
                dotThirdColor: ColorManager.orange),
            onTap: (isLiked) async {
              isLike = !isLiked;
              likesCount += (this.isLike) ? 1 : -1;
              dislikesCount = widget.dislikes;
              if (isDislike) {
                isDislike = false;
                hasBorderDislikes = false;
              }
              Future.delayed(animationDuration2).then((_) {
                return setState(() {
                  hasBorderLikes = !isLiked;
                });
              });

              return !isLiked;
            },
          ),
        ),
      ),
    );
  }
}
