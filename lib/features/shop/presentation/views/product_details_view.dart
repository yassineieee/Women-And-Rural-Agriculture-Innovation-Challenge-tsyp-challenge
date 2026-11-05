import 'package:t_store/core/common/widgets/product_photo.dart';
import 'package:t_store/core/common/widgets/wishlist_heart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:t_store/features/cart/presentation/cubit/cart_state.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';

class ProductDetailsView extends StatelessWidget {
  // Nullable for legacy callers which still open this screen without a product.
  final ProductEntity? product;
  const ProductDetailsView({super.key, this.product});

  Future<void> _addToCart(BuildContext context, ProductEntity p) async {
    if (Supabase.instance.client.auth.currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى تسجيل الدخول أولاً')),
      );
      return;
    }
    final cartCubit = context.read<CartCubit>();
    await cartCubit.addToCart(productId: p.id);
    if (!context.mounted) return;
    final state = cartCubit.state;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state is CartError ? state.message : 'تمت إضافة المنتج إلى السلة')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = product;
    if (p == null) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(title: const Text('تفاصيل المنتج')),
          body: const Center(child: Text('افتح المنتج من صفحة المتجر لعرض تفاصيله')),
        ),
      );
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('تفاصيل المنتج'),
          actions: [WishlistHeartButton(productId: p.id)],
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: ProductPhoto(
                  productId: p.id,
                  thumbnail: p.thumbnail,
                  images: p.images,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(p.name, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            if ((p.categoryName ?? '').isNotEmpty) Text('التصنيف: ${p.categoryName}'),
            if ((p.brandName ?? '').isNotEmpty) Text('المجموعة: ${p.brandName}'),
            const SizedBox(height: 12),
            if (p.hasDiscount)
              Text(
                '${p.price.toStringAsFixed(2)} د.ت',
                style: const TextStyle(decoration: TextDecoration.lineThrough),
              ),
            Text(
              '${p.effectivePrice.toStringAsFixed(2)} د.ت',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: TColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 18),
            Text('وصف المنتج', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text((p.description ?? '').isEmpty ? 'لا يوجد وصف لهذا المنتج حالياً' : p.description!),
            const SizedBox(height: 14),
            Text('التوفر: ${p.availabilityStatus}'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: p.isInStock ? () => _addToCart(context, p) : null,
              icon: const Icon(Icons.shopping_bag_outlined),
              label: const Text('أضف إلى السلة'),
            ),
          ],
        ),
      ),
    );
  }
}
