import 'package:flutter/material.dart';
import 'package:movie_application/core/utils/app_colors.dart';
import 'package:movie_application/core/utils/app_styles.dart';
import 'package:movie_application/core/utils/size_utils.dart';

typedef CastMember = ({String name, String character, String imageUrl});

class CastSection extends StatelessWidget {
  final List<CastMember> cast;

  const CastSection({super.key, required this.cast});

  @override
  Widget build(BuildContext context) {
    if (cast.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Cast', style: AppStyles.bold24WhiteRoboto),
        for (final member in cast) ...[
          SizedBox(height: SizeUtils.getHeight(context, 16)),
          _CastTile(member: member),
        ],
      ],
    );
  }
}

class _CastTile extends StatelessWidget {
  final CastMember member;

  const _CastTile({required this.member});

  @override
  Widget build(BuildContext context) {
    final imageSize = SizeUtils.getWidth(context, 70);

    return Container(
      padding: EdgeInsets.all(SizeUtils.getWidth(context, 8)),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(SizeUtils.getWidth(context, 16)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(SizeUtils.getWidth(context, 8)),
            child: Image.network(
              member.imageUrl,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: const ColoredBox(color: AppColors.blackColor),
                );
              },
            ),
          ),
          SizedBox(width: SizeUtils.getWidth(context, 16)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name : ${member.name}',
                  style: AppStyles.regular20WhiteRoboto,
                ),
                Text(
                  'Character : ${member.character}',
                  style: AppStyles.regular20WhiteRoboto,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}