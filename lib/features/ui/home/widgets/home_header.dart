import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_images.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/features/ui/home/widgets/movies_carousel.dart';

class HomeHeader extends StatefulWidget {
  final List<CarouselMovie> movies;
  final ValueChanged<int>? onMovieTap;

  const HomeHeader({super.key, required this.movies, this.onMovieTap});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: _buildBackground()),
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              SizedBox(height: SizeUtils.getHeight(context, 8)),
              Image.asset(
                AppImages.availableNowImagePath,
                width: SizeUtils.getWidth(context, 267),
              ),
              SizedBox(height: SizeUtils.getHeight(context, 20)),
              MoviesCarousel(
                movies: widget.movies,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                onMovieTap: widget.onMovieTap,
              ),
              SizedBox(height: SizeUtils.getHeight(context, 24)),
              Image.asset(
                AppImages.watchNowImagePath,
                width: SizeUtils.getWidth(context, 354),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackground() {
    if (widget.movies.isEmpty) return const SizedBox.shrink();

    final movie = widget.movies[_currentIndex];
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: ImageFiltered(
            key: ValueKey(movie.imageUrl),
            imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Image.network(
              movie.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const ColoredBox(color: AppColors.darkGreyColor);
              },
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.blackColor.withValues(alpha: 0.55),
                AppColors.blackColor.withValues(alpha: 0.85),
                AppColors.blackColor,
              ],
              stops: const [0, 0.6, 1],
            ),
          ),
        ),
      ],
    );
  }
}

