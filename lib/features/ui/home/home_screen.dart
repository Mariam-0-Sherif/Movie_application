import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_images.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/core/widgets/custom_image_asset.dart';
import 'package:movie_application/features/ui/home/tabs/explore_tab/explore_tab.dart';
import 'package:movie_application/features/ui/home/tabs/home_tab/home_tab.dart';
import 'package:movie_application/features/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:movie_application/features/ui/home/tabs/search_tab/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> tabs = const [
    HomeTab(),
    SearchTab(),
    ExploreTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: tabs),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
              horizontal: SizeUtils.getWidth(context, 9),
              vertical: SizeUtils.getHeight(context, 9)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BottomNavigationBar(
              backgroundColor: AppColors.darkGreyColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (value) => setState(() => selectedIndex = value),
              items: [
                buildNavItem(AppImages.homeLogoImagePath, 'Home'),
                buildNavItem(AppImages.searchIconImagePath, 'Search'),
                buildNavItem(AppImages.exploreImagePath, 'Explore'),
                buildNavItem(AppImages.profileTabImagePath, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIcon(String path, Color color) {
    return CustomImageAsset(
      path: path,
      color: color,
      width: SizeUtils.getWidth(context, 26),
      height: SizeUtils.getHeight(context, 20),
      fit: BoxFit.contain,
    );
  }

  BottomNavigationBarItem buildNavItem(String path, String label) {
    return BottomNavigationBarItem(
      icon: buildIcon(path, AppColors.whiteColor),
      activeIcon: buildIcon(path, AppColors.yellowColor),
      label: label,
    );
  }
}