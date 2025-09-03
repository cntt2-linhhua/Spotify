import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopify/core/configs/assets/app_vectors.dart';
import 'package:shopify/common/helpers/is_dark_mode.dart';
import 'package:shopify/core/configs/theme/app_color.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icons = [
      AppVectors.homeIcon,
      AppVectors.discoveryIcon,
      AppVectors.heartIcon,
      AppVectors.userIcon,
    ];

    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.darkGrey
            : AppColors.lightBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          final isActive = currentIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            child: SizedBox(
              width: 70,
              height: 60,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (isActive)
                    Positioned(
                      top: 0,
                      child: Container(
                        width: 24,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(3.5),
                            bottomRight: Radius.circular(3.5),
                          ),
                        ),
                      ),
                    ),
                  // Icon chính
                  SvgPicture.asset(
                    icons[index],
                    width: 28,
                    height: 28,
                    colorFilter: ColorFilter.mode(
                      isActive ? Color(0xff42C83C) : Color(0xff808080),
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
