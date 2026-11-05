import 'package:flutter/material.dart';

/// Product pictures are resolved from local assets for the 7rayer demo catalog.
/// Add 7rayer-001.jpg ... 7rayer-015.jpg to assets/images/products/.
/// The existing Bsisa.jpg is used for product 004 until you add 7rayer-004.jpg.
class ProductPhoto extends StatelessWidget {
  final String productId;
  final String? thumbnail;
  final List<String> images;
  final BoxFit fit;
  const ProductPhoto({super.key, required this.productId, this.thumbnail,
    required this.images, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    final suffix = productId.split('-').last;
    final demoNumber = int.tryParse(suffix);
    final isDemo = productId.startsWith('a7000000-0000-0000-0000-') &&
        demoNumber != null && demoNumber >= 1 && demoNumber <= 15;
    if (isDemo) {
      final number = demoNumber.toString().padLeft(3, '0');
      return Image.asset('assets/images/products/7rayer-$number.jpg',
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          if (demoNumber == 4) {
            return Image.asset('assets/images/products/Bsisa.jpg', fit: fit,
              errorBuilder: (_, __, ___) => _missing());
          }
          return _missing();
        });
    }
    final path = (thumbnail != null && thumbnail!.trim().isNotEmpty)
        ? thumbnail!.trim() : (images.isNotEmpty ? images.first.trim() : '');
    if (path.isEmpty) return _missing();
    if (path.startsWith('assets/')) {
      return Image.asset(path, fit: fit,
        errorBuilder: (_, __, ___) => _missing());
    }
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return Image.network(path, fit: fit,
        errorBuilder: (_, __, ___) => _missing());
    }
    return _missing();
  }

  Widget _missing() => const ColoredBox(
    color: Color(0xFFFFF0EA),
    child: Center(child: Icon(Icons.image_outlined, size: 48)),
  );
}
