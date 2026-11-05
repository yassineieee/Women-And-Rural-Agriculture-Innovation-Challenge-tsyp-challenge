import 'package:flutter/material.dart';
import 'package:t_store/features/shop/presentation/views/store_view.dart';

/// Reuses the same live catalog instead of the legacy static product list.
class AllProductsView extends StatelessWidget {
  const AllProductsView({super.key});

  @override
  Widget build(BuildContext context) => const StoreView();
}
