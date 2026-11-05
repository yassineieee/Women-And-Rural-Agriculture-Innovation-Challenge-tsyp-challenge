import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/wishlist/domain/entities/wishlist_item_entity.dart';
import 'package:t_store/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:t_store/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:t_store/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:t_store/features/wishlist/presentation/cubit/wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final GetWishlistUsecase getWishlistUsecase;
  final AddToWishlistUsecase addToWishlistUsecase;
  final RemoveFromWishlistUsecase removeFromWishlistUsecase;

  WishlistCubit({
    required this.getWishlistUsecase,
    required this.addToWishlistUsecase,
    required this.removeFromWishlistUsecase,
  }) : super(WishlistInitial());

  List<WishlistItemEntity> _items = [];
  Set<String> _productIds = {};
  Future<void>? _wishlistLoad;
  bool _hasLoaded = false;
  String? _loadedForUser;

  /// The first product card loads saved hearts. Repeated cards share the request.
  Future<void> ensureLoaded(String userId) async {
    if (_hasLoaded && _loadedForUser == userId) return;
    if (_loadedForUser != null && _loadedForUser != userId) {
      _items = [];
      _productIds = {};
      _hasLoaded = false;
    }
    await getWishlist();
    if (_hasLoaded) _loadedForUser = userId;
  }

  Future<void> getWishlist() {
    final pending = _wishlistLoad;
    if (pending != null) return pending;
    final loading = _fetchWishlist();
    _wishlistLoad = loading;
    return loading.whenComplete(() => _wishlistLoad = null);
  }

  Future<void> _fetchWishlist() async {
    emit(WishlistLoading());

    final result = await getWishlistUsecase(const NoParams());

    result.fold(
      (error) {
        _hasLoaded = false;
        emit(WishlistError(error));
      },
      (items) {
        _hasLoaded = true;
        _items = items;
        _productIds = items.map((e) => e.productId).toSet();
        emit(WishlistLoaded(items));
      },
    );
  }

  Future<void> addToWishlist(String productId) async {
    final result = await addToWishlistUsecase(productId);

    var added = false;
    result.fold(
      (error) => emit(WishlistError(error)),
      (item) {
        added = true;
        emit(WishlistItemAdded(item));
      },
    );
    if (added) await getWishlist();
  }

  Future<void> removeFromWishlist(String productId) async {
    final result = await removeFromWishlistUsecase(productId);

    var removed = false;
    result.fold(
      (error) => emit(WishlistError(error)),
      (_) {
        removed = true;
        emit(WishlistItemRemoved(productId));
      },
    );
    if (removed) await getWishlist();
  }

  Future<void> toggleWishlist(String productId) async {
    if (isInWishlist(productId)) {
      await removeFromWishlist(productId);
    } else {
      await addToWishlist(productId);
    }
  }

  bool isInWishlist(String productId) {
    return _productIds.contains(productId);
  }

  int get itemCount => _items.length;
}
