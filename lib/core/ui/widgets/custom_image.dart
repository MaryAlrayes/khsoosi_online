// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final bool? isCircle;
  final double? radius;
  const CustomImage({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.isCircle,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCircle == true
        ? PhysicalModel(
            color: Colors.grey.withOpacity(0.3),
            elevation: 4.0,
            shape: BoxShape.circle,
            child: CircleAvatar(
              radius: radius!,
              backgroundImage: CachedNetworkImageProvider(
                image,
              ),
            ),
          )
        : CachedNetworkImage(
            imageUrl: image,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
              ),
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
            ),
            imageBuilder: (context, imageProvider) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: isCircle == null ? BoxShape.rectangle : BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }
}
