import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/features/ui/movie_details/widgets/cast_section.dart';
import 'package:movie_application/features/ui/movie_details/widgets/details_header.dart';
import 'package:movie_application/features/ui/movie_details/widgets/genres_section.dart';
import 'package:movie_application/features/ui/movie_details/widgets/movie_stats_row.dart';
import 'package:movie_application/features/ui/movie_details/widgets/screenshots_section.dart';
import 'package:movie_application/features/ui/movie_details/widgets/similar_section.dart';
import 'package:movie_application/features/ui/movie_details/widgets/summary_section.dart';

import '../../common/widget/custom_elevated_button.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  // Placeholder values until the details cubit is connected.
  static const String _posterUrl = 'https://picsum.photos/seed/poster/600/900';
  static const List<String> _screenshots = [
    'https://picsum.photos/seed/shot1/800/450',
    'https://picsum.photos/seed/shot2/800/450',
    'https://picsum.photos/seed/shot3/800/450',
  ];
  static const List<SimilarMovie> _similar = [
    (imageUrl: 'https://picsum.photos/seed/sim1/300/450', rating: 7.7),
    (imageUrl: 'https://picsum.photos/seed/sim2/300/450', rating: 7.7),
    (imageUrl: 'https://picsum.photos/seed/sim3/300/450', rating: 7.7),
    (imageUrl: 'https://picsum.photos/seed/sim4/300/450', rating: 7.7),
  ];
  static const String _summary =
      'The movie summary will be shown here once the details are loaded '
      'from the API. It can be a few lines long and the text wraps on '
      'its own.';
  static const List<CastMember> _cast = [
    (
    name: 'Actor One',
    character: 'Character One',
    imageUrl: 'https://picsum.photos/seed/cast1/200/200',
    ),
    (
    name: 'Actor Two',
    character: 'Character Two',
    imageUrl: 'https://picsum.photos/seed/cast2/200/200',
    ),
    (
    name: 'Actor Three',
    character: 'Character Three',
    imageUrl: 'https://picsum.photos/seed/cast3/200/200',
    ),
  ];
  static const List<String> _genres = [
    'Action',
    'Sci-Fi',
    'Adventure',
    'Fantasy',
    'Horror',
  ];

  @override
  Widget build(BuildContext context) {
    final sectionGap = SizedBox(height: SizeUtils.getHeight(context, 24));

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DetailsHeader(
              imageUrl: _posterUrl,
              title: 'Doctor Strange in the Multiverse of Madness',
              year: '2022',
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeUtils.getWidth(context, 16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: SizeUtils.getHeight(context, 16)),
                  CustomElevatedButton(
                    onPressed: () {},
                    backgroundColor: AppColors.redColor,
                    radius: SizeUtils.getWidth(context, 16),
                    padding: EdgeInsets.symmetric(
                      vertical: SizeUtils.getHeight(context, 14),
                    ),
                    child: Text('Watch', style: AppStyles.regular20WhiteRoboto),
                  ),
                  SizedBox(height: SizeUtils.getHeight(context, 16)),
                  const MovieStatsRow(likes: 15, runtime: 90, rating: 7.6),
                  sectionGap,
                  const ScreenshotsSection(imageUrls: _screenshots),
                  sectionGap,
                  const SimilarSection(movies: _similar),
                  sectionGap,
                  const SummarySection(summary: _summary),
                  sectionGap,
                  const CastSection(cast: _cast),
                  sectionGap,
                  const GenresSection(genres: _genres),
                  SizedBox(height: SizeUtils.getHeight(context, 32)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}