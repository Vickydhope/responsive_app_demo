import 'package:flutter/material.dart';
import 'package:responsive_app_demo/app/config/themes/app_theme.dart';
import 'package:responsive_app_demo/app/constants/app_constants.dart';

class ListProfileImage extends StatelessWidget {
  const ListProfileImage(
      {Key? key, required this.images, this.onPressed, this.maxImages = 3})
      : super(key: key);

  final List<ImageProvider> images;

  final Function()? onPressed;
  final int maxImages;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: _getImageLimit(images, maxImages)
          .asMap()
          .entries
          .map((e) => Padding(
                padding: EdgeInsets.only(right: e.key * 25.0),
                child: _image(
                  e.value,
                  onPressed: () {},
                ),
              ))
          .toList(),
    );
  }

  List<ImageProvider> _getImageLimit(List<ImageProvider> images, int limit) {
    if (images.length <= limit) return images;
    List<ImageProvider> result = [];

    for (int i = 0; i < limit; i++) {
      result.add(images[i]);
    }

    return result;
  }

  Widget _image(ImageProvider image, {Function()? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.basic.cardColor,
        ),
        child: CircleAvatar(
          backgroundImage: image,
          radius: 15,
        ),
      ),
    );
  }
}
