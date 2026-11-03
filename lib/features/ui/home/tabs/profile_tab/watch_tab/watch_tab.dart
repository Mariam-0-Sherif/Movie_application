import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_images.dart';
import 'package:movie_application/core/widget/custom_image_asset.dart';

class WatchTab extends StatelessWidget {
  const WatchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CustomImageAsset(path: AppImages.searchImagePath));
  }
}
