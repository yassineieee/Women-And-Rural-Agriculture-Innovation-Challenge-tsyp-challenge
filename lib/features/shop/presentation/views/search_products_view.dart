import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/common/widgets/vertical_product_card.dart';
import 'package:t_store/core/dependency_injection/service_locator.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';
import 'package:t_store/features/shop/presentation/cubit/products_cubit.dart';
import 'package:t_store/features/shop/presentation/cubit/products_state.dart';

/// Search the active Supabase product catalog without replacing the home
/// screen's ProductsCubit state (which shows featured products).
class SearchProductsView extends StatelessWidget {
  const SearchProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>(
      create: (_) => sl<ProductsCubit>(),
      child: const _SearchProductsBody(),
    );
  }
}

class _SearchProductsBody extends StatefulWidget {
  const _SearchProductsBody();

  @override
  State<_SearchProductsBody> createState() => _SearchProductsBodyState();
}

class _SearchProductsBodyState extends State<_SearchProductsBody> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    _debounce?.cancel();
    final query = value.trim();
    if (query.isEmpty) {
      context.read<ProductsCubit>().searchProducts('');
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      context.read<ProductsCubit>().searchProducts(query);
    });
  }

  void _searchImmediately(String value) {
    _debounce?.cancel();
    context.read<ProductsCubit>().searchProducts(value.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('البحث عن منتجات'),
          backgroundColor: TColors.primary,
          foregroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controller,
                autofocus: true,
                textInputAction: TextInputAction.search,
                onChanged: _onQueryChanged,
                onSubmitted: _searchImmediately,
                decoration: InputDecoration(
                  hintText: 'ابحث عن عسل، بسيسة، زيت زيتون...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    tooltip: 'مسح البحث',
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      _onQueryChanged('');
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsSearching) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ProductsError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('تعذّر البحث عن المنتجات'),
                            const SizedBox(height: 8),
                            Text(state.message, textAlign: TextAlign.center),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () => _searchImmediately(_controller.text),
                              child: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is ProductsSearchResult) {
                    if (state.products.isEmpty) {
                      return const Center(
                        child: Text('لا توجد منتجات مطابقة للبحث'),
                      );
                    }
                    return _SearchResults(products: state.products);
                  }

                  return const Center(
                    child: Text('اكتب اسم منتج لعرض نتائج البحث'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1000
            ? 4
            : constraints.maxWidth >= 640
                ? 3
                : constraints.maxWidth >= 340
                    ? 2
                    : 1;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text('نتائج البحث: ${products.length}'),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 315,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) =>
                    VerticalProductCard(product: products[index]),
              ),
            ),
          ],
        );
      },
    );
  }
}
