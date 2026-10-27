import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';

class SummarySection extends StatelessWidget {
  final String summary;

  const SummarySection({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    if (summary.trim().isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Summary', style: AppStyles.bold24WhiteRoboto),
        SizedBox(height: SizeUtils.getHeight(context, 16)),
        Text(summary, style: AppStyles.regular16WhiteRoboto),
      ],
    );
  }
}