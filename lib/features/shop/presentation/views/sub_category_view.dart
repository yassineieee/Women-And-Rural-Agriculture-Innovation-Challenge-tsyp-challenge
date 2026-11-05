import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:t_store/core/common/widgets/vertical_product_card.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/features/shop/data/models/product_model.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';

/// Shows real products in the category selected from the home-page shortcut.
/// Uses VerticalProductCard -> ProductPhoto to load local 7rayer-XXX.jpg assets.
class SubCategoryView extends StatefulWidget {
  final String categoryName;

  const SubCategoryView({
    super.key,
    required this.categoryName,
  });

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  late Future<List<ProductEntity>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<ProductEntity>> _loadProducts() async {
    final client = Supabase.instance.client;

    // Look up the ID of the category clicked on the home screen.
    final category = await client
        .from('categories')
        .select('id')
        .eq('name', widget.categoryName)
        .eq('is_active', true)
        .limit(1)
        .maybeSingle();

    if (category == null) return <ProductEntity>[];

    // These are the same real rows used by the main 7rayer Store page.
    final productRows = await client
        .from('products')
        .select('*, categories(name), brands(name)')
        .eq('category_id', category['id'] as String)
        .eq('is_active', true)
        .order('created_at', ascending: false)
        .limit(100);

    return productRows
        .map<ProductEntity>((row) => ProductModel.fromJson(row))
        .toList();
  }

  void _refresh() {
    setState(() {
      _productsFuture = _loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
          backgroundColor: TColors.primary,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              tooltip: 'تحديث المنتجات',
              onPressed: _refresh,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: FutureBuilder<List<ProductEntity>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('تعذّر تحميل منتجات هذا التصنيف'),
                      const SizedBox(height: 8),
                      Text(
                        '${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton(
                        onPressed: _refresh,
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final products = snapshot.data ?? <ProductEntity>[];
            if (products.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('لا توجد منتجات في هذا التصنيف حالياً'),
                ),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth >= 1000
                    ? 4
                    : constraints.maxWidth >= 650
                        ? 3
                        : constraints.maxWidth >= 360
                            ? 2
                            : 1;

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    mainAxisExtent: 315,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) =>
                      VerticalProductCard(product: products[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
