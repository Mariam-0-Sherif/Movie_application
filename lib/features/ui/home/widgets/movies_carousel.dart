import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/core/widgets/movie_poster_card.dart';

/// The minimum data the carousel needs to draw one poster.
typedef CarouselMovie = ({String imageUrl, double rating});

class MoviesCarousel extends StatefulWidget {
  final List<CarouselMovie> movies;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onMovieTap;

  const MoviesCarousel({
    super.key,
    required this.movies,
    this.onPageChanged,
    this.onMovieTap,
  });

  @override
  State<MoviesCarousel> createState() => _MoviesCarouselState();
}

class _MoviesCarouselState extends State<MoviesCarousel> {
  /// Sizes as designed in Figma (based on a 430 wide screen).
  static const double _posterWidth = 233;
  static const double _posterHeight = 350;
  static const double _sideScale = 0.79;

  late final PageController _controller = PageController(
    viewportFraction: _posterWidth / SizeUtils.widthScreen,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 1 for the poster in the middle, shrinking towards [_sideScale]
  /// as the poster moves away from the center.
  double _scaleFor(int index) {
    final bool ready =
        _controller.hasClients && _controller.position.haveDimensions;
    final double page = ready ? _controller.page ?? 0 : 0;
    final double distance = (page - index).abs().clamp(0.0, 1.0).toDouble();
    return 1 - (1 - _sideScale) * distance;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeUtils.getHeight(context, _posterHeight),
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.movies.length,
        onPageChanged: widget.onPageChanged,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(scale: _scaleFor(index), child: child);
            },
            child: Center(
              child: MoviePosterCard(
                imageUrl: movie.imageUrl,
                rating: movie.rating,
                width: _posterWidth,
                onTap: () => widget.onMovieTap?.call(index),
              ),
            ),
          );
        },
      ),
    );
  }
}