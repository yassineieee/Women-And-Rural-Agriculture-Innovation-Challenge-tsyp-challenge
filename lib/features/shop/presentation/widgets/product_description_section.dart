import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/view_models/section_heading_view_model.dart';
import 'package:t_store/core/common/widgets/read_more.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/shop/presentation/views/product_reviews_view.dart';

class ProductDescriptionAndReviewsSection extends StatelessWidget {
  const ProductDescriptionAndReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeading(
          sectionHeadingModel: SectionHeadingModel(
            title: "وصف المنتج",
            showActionButton: false,
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        const ReadMore(text: "لا يوجد وصف متاح لهذا المنتج حالياً."),
        const SizedBox(height: TSizes.spaceBtwItems),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SectionHeading(
              sectionHeadingModel: SectionHeadingModel(
                title: "التقييمات",
                showActionButton: false,
              ),
            ),
            TextButton(
              onPressed: () {
                THelperFunctions.navigateToScreen(
                  context,
                  const ProductReviewsView(),
                );
              },
              child: const Icon(Iconsax.arrow_right_3),
            ),
          ],
        ),
      ],
    );
  }
}
