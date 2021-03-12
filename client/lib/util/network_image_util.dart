import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:im/util/util.dart';

class NetworkImageUtil {
  static CachedNetworkImage assetNetwork({
    @required String image,
    String plahoder = "assets/images/ico_placeholder.png",
    BoxFit fit = BoxFit.cover,
    double width,
    double height,
  }) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: Util.colorInfoBackground(context),
        child: Center(
          child: Text(
            "...",
            style: TextStyle(fontSize: Util.font14),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Util.colorInfoBackground(context),
        child: Icon(
          Icons.broken_image,
          color: Util.color999,
        ),
      ),
    );
  }
}
