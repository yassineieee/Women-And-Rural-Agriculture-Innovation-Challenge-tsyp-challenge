import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/common/widgets/product_photo.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:t_store/features/cart/presentation/cubit/cart_state.dart';

/// Displays real Supabase cart items, with a confirmation before removal.
/// Checkout remains disabled until the 7rayer payment flow is implemented.
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  String? _removingItemId;

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCartItems();
  }

  Future<void> _confirmRemove(CartItemEntity item) async {
    if (_removingItemId != null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف المنتج من السلة؟'),
        content: Text('هل تريد حذف «${item.product?.name ?? 'هذا المنتج'}» من سلة التسوق؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (!mounted || confirmed != true || _removingItemId != null) return;

    setState(() => _removingItemId = item.id);
    final removed = await context.read<CartCubit>().removeFromCart(item.id);
    if (!mounted) return;

    setState(() => _removingItemId = null);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            removed ? 'تم حذف المنتج من السلة' : 'تعذر حذف المنتج. حاول مرة أخرى.',
          ),
        ),
      );
  }

  Widget _buildCartItem(CartItemEntity item) {
    final product = item.product;
    final removing = _removingItemId == item.id;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 74,
                height: 74,
                child: product == null
                    ? const ColoredBox(
                        color: Color(0xFFFFF0EA),
                        child: Icon(Icons.image_outlined),
                      )
                    : ProductPhoto(
                        productId: product.id,
                        thumbnail: product.thumbnail,
                        images: product.images,
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product?.name ?? 'منتج',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Text('الكمية: ${item.quantity}'),
                  const SizedBox(height: 5),
                  Text(
                    '${item.totalPrice.toStringAsFixed(2)} د.ت',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: TColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            if (removing)
              const Padding(
                padding: EdgeInsets.all(12),
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: TColors.primary,
                tooltip: 'حذف من السلة',
                onPressed: _removingItemId == null
                    ? () => _confirmRemove(item)
                    : null,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('سلة التسوق')),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading || state is CartInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(state.message, textAlign: TextAlign.center),
                    ),
                    OutlinedButton(
                      onPressed: () => context.read<CartCubit>().getCartItems(),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }
            if (state is! CartLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.items.isEmpty) {
              return const Center(child: Text('سلة التسوق فارغة حالياً'));
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final item in state.items) _buildCartItem(item),
                const SizedBox(height: 12),
                Text(
                  'المجموع: ${state.totalPrice.toStringAsFixed(2)} د.ت',
                  style: const TextStyle(
                    color: TColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                const SizedBox(height: 12),
                const Text('الدفع قيد الإعداد؛ لن يتم تحصيل أي مبلغ الآن.'),
              ],
            );
          },
        ),
      ),
    );
  }
}
