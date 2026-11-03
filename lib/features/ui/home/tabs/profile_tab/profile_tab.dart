
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/features/ui/home/tabs/profile_tab/history_tab/history_tab.dart';
import 'package:movie_application/features/ui/home/tabs/profile_tab/repository/profile_repository.dart';
import 'package:movie_application/features/ui/home/tabs/profile_tab/watch_tab/cubit/watchlist_cubit.dart';
import 'package:movie_application/features/ui/home/tabs/profile_tab/watch_tab/watch_tab.dart';
import 'package:movie_application/features/ui/home/tabs/profile_tab/widgets/profile_header.dart';

import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widget/custom_image_asset.dart';
import 'history_tab/cubit/history_cubit.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WatchlistCubit(ProfileRepository())),
        BlocProvider(create: (_) => HistoryCubit(ProfileRepository())),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const ProfileHeader(),
                Container(
                  color: AppColors.darkGrayColor,
                  child: TabBar(
                    indicatorColor: AppColors.yellowColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelStyle: AppStyles.regular20WhiteRoboto,
                    unselectedLabelStyle: AppStyles.regular20WhiteRoboto,
                    tabs: [
                      Tab(
                        icon: CustomImageAsset(
                          path: AppImages.listIconImagePath,
                        ),
                        text: 'Watch List',
                      ),
                      Tab(
                        icon: CustomImageAsset(
                          path: AppImages.historyIconImagePath,
                        ),
                        text: 'History',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.blackColor,
                    child: const TabBarView(
                      children: [
                        WatchTab(),
                        HistoryTab(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
