import 'package:flutter/material.dart';

import '../../../../../core/utils/size_utils.dart';
import '../../../widget/build.dart';

class ChooseAvatar extends StatefulWidget {
  final PageController avatarController;
  final ValueChanged<int> onAvatarChanged;
  final List<String> avatars;

  const ChooseAvatar({
    super.key,
    required this.avatarController,
    required this.onAvatarChanged,
    required this.avatars,
  });

  @override
  State<ChooseAvatar> createState() => _ChooseAvatarState();
}

class _ChooseAvatarState extends State<ChooseAvatar> {
  int selectedAvatar = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeUtils.getWidth(context, 170),
      child: PageView.builder(
        controller: widget.avatarController,
        itemCount: widget.avatars.length,
        clipBehavior: Clip.none,
        onPageChanged: (index) {
          selectedAvatar = index;
          setState(() {
            widget.onAvatarChanged(index);
          });
        },
        itemBuilder: (context, i) {
          return buildGestureDetector(
            onTap: () => widget.avatarController.animateToPage(
              i,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            ),
            child: Center(
              child: AnimatedScale(
                scale: i == selectedAvatar ? 1.75 : 1.0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: Image.asset(
                  widget.avatars[i],
                  width: SizeUtils.getWidth(context, 90),
                  height: SizeUtils.getWidth(context, 90),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
