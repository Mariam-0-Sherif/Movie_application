import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_routes.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/size_utils.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import 'model/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    String buttonText = 'Next';
    if (index == 0) {
      buttonText = 'Explore Now';
    } else if (index == onboardingImages.length - 1) {
      buttonText = 'Finish';
    }
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: onboardingImages.length,
            onPageChanged: (value) {
              index = value;
              setState(() {});
            },
            itemBuilder: (context, i) {
              return Image.asset(onboardingImages[i], fit: BoxFit.fill);
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: SizeUtils.getHeight(context, 8)),
              padding: EdgeInsets.symmetric(
                vertical: SizeUtils.getHeight(context, 24),
                horizontal: SizeUtils.getWidth(context, 16),
              ),
              decoration: BoxDecoration(
                color: index == 0 ? null : AppColors.blackColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: SizeUtils.getHeight(context, 16),
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    titles[index],
                    textAlign: TextAlign.center,
                    style: index == 0
                        ? AppStyles.medium36WhiteInter
                        : AppStyles.bold24WhiteInter,
                  ),
                  if (descriptions[index] != '') ...[
                    Text(
                      descriptions[index],
                      textAlign: TextAlign.center,
                      style: index == 0
                          ? AppStyles.regular20LightGrayInter
                          : AppStyles.regular20WhiteInter,
                    ),
                  ],
                  CustomElevatedButton(
                    onPressed: next,
                    backgroundColor: AppColors.yellowColor,
                    padding: EdgeInsets.symmetric(
                      vertical: SizeUtils.getHeight(context, 12),
                    ),
                    radius: 15,
                    child: Text(
                      buttonText,
                      style: AppStyles.semibold20BlackInter,
                    ),
                  ),
                  if (index != 0) ...[
                    CustomElevatedButton(
                      onPressed: back,
                      borderColor: AppColors.yellowColor,
                      backgroundColor: AppColors.transparentColor,
                      padding: EdgeInsets.symmetric(
                        vertical: SizeUtils.getHeight(context, 12),
                      ),
                      radius: 15,
                      child: Text(
                        'Back',
                        style: AppStyles.semibold20YellowInter,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void next() {
    if (index == onboardingImages.length - 1) {
      Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void back() {
    controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
