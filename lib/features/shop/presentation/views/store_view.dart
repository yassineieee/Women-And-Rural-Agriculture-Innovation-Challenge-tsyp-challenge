import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:t_store/core/common/widgets/vertical_product_card.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/features/shop/data/models/product_model.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';

/// Real, Arabic storefront. This replaces the static Nike/demo tabs.
class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  late Future<_Catalog> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadCatalog();
  }

  Future<_Catalog> _loadCatalog() async {
    final client = Supabase.instance.client;
    final categoryRows = await client
        .from('categories')
        .select('id, name')
        .eq('is_active', true)
        .order('sort_order', ascending: true);
    final productRows = await client
        .from('products')
        .select('*, categories(name), brands(name)')
        .eq('is_active', true)
        .order('created_at', ascending: false)
        .limit(100);

    return _Catalog(
      categories: categoryRows
          .map((row) => _Category(row['id'] as String, row['name'] as String))
          .toList(),
      products: productRows
          .map<ProductEntity>((row) => ProductModel.fromJson(row))
          .toList(),
    );
  }

  void _reload() => setState(() => _future = _loadCatalog());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('متجر حراير'),
          backgroundColor: TColors.primary,
          foregroundColor: Colors.white,
          actions: [IconButton(onPressed: _reload, icon: const Icon(Icons.refresh), tooltip: 'تحديث')],
        ),
        body: FutureBuilder<_Catalog>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('تعذّر تحميل المنتجات من قاعدة البيانات'),
                    const SizedBox(height: 8),
                    Text('${snapshot.error}', textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    ElevatedButton(onPressed: _reload, child: const Text('إعادة المحاولة')),
                  ],
                ),
              );
            }
            final catalog = snapshot.data!;
            return DefaultTabController(
              length: catalog.categories.length + 1,
              child: Column(
                children: [
                  Material(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      labelColor: TColors.primary,
                      indicatorColor: TColors.primary,
                      tabs: [
                        const Tab(text: 'الكل'),
                        ...catalog.categories.map((c) => Tab(text: c.name)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _ProductGrid(products: catalog.products),
                        ...catalog.categories.map((category) => _ProductGrid(
                              products: catalog.products
                                  .where((p) => p.categoryId == category.id)
                                  .toList(),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Category {
  final String id;
  final String name;
  const _Category(this.id, this.name);
}

class _Catalog {
  final List<_Category> categories;
  final List<ProductEntity> products;
  const _Catalog({required this.categories, required this.products});
}

class _ProductGrid extends StatelessWidget {
  final List<ProductEntity> products;
  const _ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(child: Text('لا توجد منتجات في هذا القسم حالياً'));
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 1000
            ? 4
            : constraints.maxWidth >= 640
                ? 3
                : constraints.maxWidth >= 340
                    ? 2
                    : 1;
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            mainAxisExtent: 298,
          ),
          itemCount: products.length,
          itemBuilder: (context, i) => VerticalProductCard(product: products[i]),
        );
      },
    );
  }
}
