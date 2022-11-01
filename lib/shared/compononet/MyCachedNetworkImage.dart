import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping/shared/my_colors.dart';

class MyCachedNetWorkImage extends StatelessWidget {
  final String logo;
  final double radius;
  const MyCachedNetWorkImage({Key? key,required this.logo,required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: logo,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color:myWhite,
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
              image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(color: myBlacks),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
