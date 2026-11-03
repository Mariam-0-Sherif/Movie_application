import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/size_utils.dart';
import 'package:movie_application/features/ui/movie_details/widgets/stat_chip.dart';

class MovieStatsRow extends StatelessWidget {
  final int likes;
  final int runtime;
  final double rating;

  const MovieStatsRow({
    super.key,
    required this.likes,
    required this.runtime,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final gap = SizedBox(width: SizeUtils.getWidth(context, 8));

    return Row(
      children: [
        Expanded(child: StatChip(icon: Icons.favorite, value: '$likes')),
        gap,
        Expanded(
          child: StatChip(icon: Icons.access_time_filled, value: '$runtime'),
        ),
        gap,
        Expanded(
          child: StatChip(
            icon: Icons.star_rounded,
            value: rating.toStringAsFixed(1),
          ),
        ),
      ],
    );
  }
}