import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_images.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/core/widgets/custom_image_asset.dart';
import 'package:movie_application/home/tabs/explore_tab.dart';
import 'package:movie_application/home/tabs/home_tab.dart';
import 'package:movie_application/home/tabs/profile_tab.dart';
import 'package:movie_application/home/tabs/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // el index bta3 el tab elly mfto7a delwa2ty (0 = home)
  int selectedIndex = 0;

  // function mo5tasara bta5od raqam el Figma w trg3o 3ala 7asab 3ard el screen
  double w(double value) => SizeUtils.getWidth(context, value);

  // el 4 screens bel tarteeb elly hatzhar fel nav bar
  List<Widget> tabs = [
    const HomeTab(),
    const SearchTab(),
    const ExploreTab(),
    const ProfileTab(),
  ];

  // btrg3 soret el icon bel lon elly ne7tago (abyad lama msh mo5tara, asfar lama mo5tara)
  Widget buildIcon(String path, Color color) {
    return CustomImageAsset(
      path: path,
      color: color,
      width: w(26),
      height: w(26),
      fit: BoxFit.contain,
    );
  }

  // item wa7ed fel nav bar, 3ashan manekarrarsh el code 4 marat
  BottomNavigationBarItem buildNavItem(String path, String label) {
    return BottomNavigationBarItem(
      icon: buildIcon(path, AppColors.whiteColor),
      activeIcon: buildIcon(path, AppColors.yellowColor),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // el tab elly 3aleha el dor 3ala hasab el index
      body: tabs[selectedIndex],

      // SafeArea 3ashan el nav bar yeb2a fo2 el gesture bar el ta7t
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(w(9), 0, w(9), w(9)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(w(16)),
            child: BottomNavigationBar(
              backgroundColor: AppColors.darkGreyColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,

              // lama el user ydos 3ala icon bn8ayar el index w el screen btetghayar
              onTap: (value) {
                selectedIndex = value;
                setState(() {});
              },

              // el 4 icons bel tarteeb, bnnadi 3alehom men AppImages
              items: [
                buildNavItem(AppImages.homeLogoImagePath, 'Home'),
                buildNavItem(AppImages.searchLogoImagePath, 'Search'),
                buildNavItem(AppImages.exploreImagePath, 'Explore'),
                buildNavItem(AppImages.profileTabImagePath, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
