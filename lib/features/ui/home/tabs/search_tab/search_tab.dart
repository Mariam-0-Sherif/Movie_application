import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_images.dart';
import 'package:movie_application/core/widgets/custom_image_asset.dart';

import '../../../widget/build.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildField(
          prefixIcon: CustomImageAsset(path: AppImages.searchIconImagePath),
          controller: null,
          hint: 'Search',
        ),
      ),
      backgroundColor: AppColors.blackColor,
      body: Center(child: CustomImageAsset(path: AppImages.searchImagePath)),
    );
  }
}
