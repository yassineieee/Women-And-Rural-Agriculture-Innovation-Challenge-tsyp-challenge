import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/horizontal_small_list_view_item_view_model.dart';
import 'package:t_store/core/common/widgets/horizontal_small_list_view.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/features/shop/presentation/views/sub_category_view.dart';

/// The five home shortcuts navigate to the corresponding live category.
class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    const categoryTitles = TTexts.categories;
    const categoryImages = TImages.categoryIcons;

    final items = List<HorizontalSmallListViewItemModel>.generate(
      categoryTitles.length,
      (index) {
        final title = categoryTitles[index];
        return HorizontalSmallListViewItemModel(
          title: title,
          image: categoryImages[index],
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => SubCategoryView(categoryName: title),
            ),
          ),
        );
      },
    );

    return SizedBox(
      height: 100,
      child: HorizontalSmallListView(items: items),
    );
  }
}
