import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:t_store/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:t_store/features/wishlist/presentation/cubit/wishlist_state.dart';

/// Heart button shared by product cards and product details.
/// Changes are persisted through the project's existing WishlistCubit.
class WishlistHeartButton extends StatefulWidget {
  final String productId;
  final bool onPicture;

  const WishlistHeartButton({
    super.key,
    required this.productId,
    this.onPicture = false,
  });

  @override
  State<WishlistHeartButton> createState() => _WishlistHeartButtonState();
}

class _WishlistHeartButtonState extends State<WishlistHeartButton> {
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    // Several cards appear at once; ensureLoaded deduplicates their requests.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId != null) {
        context.read<WishlistCubit>().ensureLoaded(userId);
      }
    });
  }

  Future<void> _toggle() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) {
      _message('يرجى تسجيل الدخول لإضافة المنتجات إلى المفضلة');
      return;
    }

    setState(() => _busy = true);
    final cubit = context.read<WishlistCubit>();
    try {
      await cubit.ensureLoaded(userId);
      if (cubit.state is WishlistError) {
        if (mounted) _message((cubit.state as WishlistError).message);
        return;
      }
      await cubit.toggleWishlist(widget.productId);
      if (mounted && cubit.state is WishlistError) {
        _message((cubit.state as WishlistError).message);
      }
    } catch (error) {
      if (mounted) _message('تعذّر تحديث المفضلة: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final liked = context.read<WishlistCubit>().isInWishlist(widget.productId);
        final button = IconButton(
          tooltip: liked ? 'إزالة من المفضلة' : 'إضافة إلى المفضلة',
          onPressed: _busy ? null : _toggle,
          icon: Icon(
            liked ? Icons.favorite : Icons.favorite_border,
            color: liked ? const Color(0xFF9F1833) : Colors.black87,
          ),
        );
        if (!widget.onPicture) return button;
        return Material(
          color: Colors.white,
          elevation: 2,
          shape: const CircleBorder(),
          child: button,
        );
      },
    );
  }
}
