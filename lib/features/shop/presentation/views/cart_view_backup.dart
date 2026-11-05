import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:t_store/features/cart/presentation/cubit/cart_state.dart';

/// Real cart items/prices from CartCubit. No pretend $175 checkout button.
/// Checkout stays unavailable until its flow is tested for 7rayer.
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCartItems();
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
              return Center(child: Text(state.message));
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
                ...state.items.map((item) => Card(
                      child: ListTile(
                        title: Text(item.product?.name ?? 'منتج'),
                        subtitle: Text('الكمية: ${item.quantity}'),
                        trailing: Text('${item.totalPrice.toStringAsFixed(2)} د.ت'),
                      ),
                    )),
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
