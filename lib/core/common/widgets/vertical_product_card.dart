import 'package:t_store/core/common/widgets/product_photo.dart';
import 'package:t_store/core/common/widgets/wishlist_heart_button.dart';
import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/presentation/views/product_details_view.dart';

/// A product card driven by a real ProductEntity, not hard-coded TStore images.
class VerticalProductCard extends StatelessWidget {
  final ProductEntity product;
  const VerticalProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => ProductDetailsView(product: product),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ProductPhoto(
                      productId: product.id,
                      thumbnail: product.thumbnail,
                      images: product.images,
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: WishlistHeartButton(
                        productId: product.id,
                        onPicture: true,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.categoryName ?? 'منتج حرفي',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${product.effectivePrice.toStringAsFixed(2)} د.ت',
                      style: const TextStyle(
                        color: TColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      product.isInStock ? 'متوفر' : 'غير متوفر',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
