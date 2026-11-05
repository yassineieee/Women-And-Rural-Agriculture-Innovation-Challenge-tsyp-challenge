import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/common/widgets/vertical_product_card.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:t_store/features/wishlist/presentation/cubit/wishlist_state.dart';

/// Displays only actual saved products (no 10 fake cards).
class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistCubit>().getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('المفضلة')),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading || state is WishlistInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WishlistError) {
              return Center(child: Text(state.message));
            }
            if (state is! WishlistLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            final products = state.items
                .map((item) => item.product)
                .whereType<ProductEntity>()
                .toList();
            if (products.isEmpty) {
              return const Center(child: Text('لم تقم بحفظ أي منتجات بعد'));
            }
            return LayoutBuilder(
              builder: (context, constraints) => GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth >= 800 ? 4 : 2,
                  mainAxisExtent: 298,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: products.length,
                itemBuilder: (_, i) => VerticalProductCard(product: products[i]),
              ),
            );
          },
        ),
      ),
    );
  }
}
