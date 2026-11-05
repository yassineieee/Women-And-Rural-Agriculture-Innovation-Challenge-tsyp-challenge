
import 'package:flutter/material.dart';
import 'package:t_store/core/common/widgets/banner_carousel_slider.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';

class PromoBannerCarouselSlider extends StatelessWidget {
  const PromoBannerCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: TSizes.defaultSpace,
      ),
      child: BannerCarouselSlider(
        images: [
          TImages.banner1,
          TImages.banner2,
          TImages.banner3,
        ],
      ),
    );
  }
}
