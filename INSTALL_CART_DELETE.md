# 7rayer — Remove items from the shopping cart

This patch is based on the latest uploaded `TStore-main (3).zip` source.
It updates TWO files only:

- `lib/features/shop/presentation/views/cart_view.dart`
- `lib/features/cart/presentation/cubit/cart_cubit.dart`

**New behavior:** Each cart item displays its real local product picture, product name, quantity, TND line total and a trash icon. Tapping the icon opens an Arabic confirmation dialog. Confirming deletes that cart line using the already-existing Supabase repository method, reloads the cart and recalculates totals. The payment/checkout flow remains disabled.

## Install from PowerShell (Windows)

1. Save `7rayer_cart_remove_patch.zip` in `C:\Users\hp\Downloads\`.
2. Stop running Flutter with Ctrl+C.
3. Run:

```powershell
cd "C:\Users\hp\Downloads\TStore-main\TStore-main"

$backup = "$HOME\Downloads\7rayer_cart_backup_$(Get-Date -Format yyyyMMdd_HHmmss)"
New-Item -ItemType Directory -Path $backup -Force | Out-Null
Copy-Item ".\lib\features\shop\presentation\views\cart_view.dart" "$backup\cart_view.dart" -Force
Copy-Item ".\lib\features\cart\presentation\cubit\cart_cubit.dart" "$backup\cart_cubit.dart" -Force

Expand-Archive -LiteralPath "$HOME\Downloads\7rayer_cart_remove_patch.zip" -DestinationPath (Get-Location).Path -Force

flutter analyze
flutter run -d chrome -t lib/main_development.dart
```

## Test

1. Sign in, open a product, tap **أضف إلى السلة**.
2. Open the basket from the shopping-cart icon.
3. Tap the trash icon beside the product, then choose **حذف**.
4. Confirm it disappears and the **المجموع** decreases.
5. Try again and select **إلغاء**: the item must remain.
6. Refresh the browser: the deleted product must not reappear.

No SQL migration is necessary because `RemoveFromCartUsecase`, `CartRepositoryImpl.removeFromCart()` and the existing `cart_items` table already support deletion. You must be signed in and have appropriate Supabase table access.

## Troubleshooting

- If Flutter cannot compile, send the full `flutter analyze` output.
- If the item stays in the cart, check Supabase RLS policies for `cart_items` and your current authenticated user.
- If the basket reports an error, use **إعادة المحاولة** to reload it.

The patch was source-reviewed and ZIP-validated; it was not compiled in Windows Flutter here.
