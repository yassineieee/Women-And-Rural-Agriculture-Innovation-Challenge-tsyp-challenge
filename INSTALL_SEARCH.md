# 7rayer — Enable the existing homepage search bar

This patch was prepared from `TStore-main (3).zip` (5 Nov 2026). It contains **three Dart files**:

- `lib/features/shop/presentation/widgets/home_header_section.dart` — connects the existing search bar tap to the new results page.
- `lib/features/shop/presentation/views/search_products_view.dart` — NEW Arabic search page with live results, empty/loading/error states and the existing product cards.
- `lib/features/shop/presentation/cubit/products_cubit.dart` — prevents outdated responses from replacing newer search results.

The existing `ProductRepositoryImpl.searchProducts` method calls Supabase (`products` table, `is_active=true`, name/description ILIKE, maximum 50 results). The new page uses this repository through your existing `ProductsCubit` and GetIt service locator. It reuses the existing `VerticalProductCard`, so local `ProductPhoto` and `WishlistHeartButton` stay intact.

No database changes, new packages, or product-image renames are needed.

## 1. Save and copy ZIP

Download `7rayer_search_feature.zip` to `C:\Users\hp\Downloads`.

In VS Code > Terminal > PowerShell:

```powershell
cd "C:\Users\hp\Downloads\TStore-main\TStore-main"
Test-Path "$HOME\Downloads\7rayer_search_feature.zip"
```

The last command should output `True`.

## 2. Back up the files

```powershell
$backup = "$HOME\Downloads\7rayer_search_backup_$(Get-Date -Format yyyyMMdd_HHmmss)"
New-Item -ItemType Directory -Force -Path $backup | Out-Null
Copy-Item ".\lib\features\shop\presentation\widgets\home_header_section.dart" "$backup\home_header_section.dart" -Force
Copy-Item ".\lib\features\shop\presentation\cubit\products_cubit.dart" "$backup\products_cubit.dart" -Force
```

## 3. Apply the patch

Stop `flutter run` with `Ctrl+C` if it is running. Execute:

```powershell
Expand-Archive -Path "$HOME\Downloads\7rayer_search_feature.zip" -DestinationPath (Get-Location).Path -Force
```

## 4. Analyze and run

```powershell
flutter analyze
```

If the analyzer reports errors, **do not proceed**: copy the errors for review. Informational lints unrelated to search may still exist.

```powershell
flutter run -d chrome -t lib/main_development.dart
```

## 5. Manual test checklist

- From the 7rayer home page, click `ابحث عن منتج...`.
- A page titled `البحث عن منتجات` opens, and the input is focused.
- Type `عسل`: matching active honey products appear from Supabase, with local images and TND prices.
- Clear the input: the prompt returns.
- Type `بسيسة`: bsisa product appears; clicking its card opens product details.
- Click the favorite heart: it uses the existing wishlist code (sign-in and Supabase permissions required).
- Type a nonsense string: `لا توجد منتجات مطابقة للبحث` appears.
- Close the search page: homepage featured products are unchanged (the search screen uses its own ProductsCubit).

## Troubleshooting

- If every search is empty, verify that `public.products` has active products and Supabase connectivity and RLS are correctly configured.
- If you see a database/network error, inspect the error text displayed in the search screen and the Flutter terminal.
- If images are missing in search, check `assets/images/products/7rayer-XXX.jpg` and the existing `product_photo.dart` mapping. This patch does not change images.
- Search uses a maximum of 50 matching products per query in the current repository. This is sufficient for the 15-product demo catalog; pagination may be needed for a larger catalog.

## Rollback

Copy the two backed-up Dart files to their original paths and remove the new `search_products_view.dart` file, then restart Flutter.

## Verification limitations

The generated Dart files have been checked against the code and imports in the supplied archive. Flutter/Dart SDK is not installed in the generation environment; the patch has not been compiled or executed against the user's Windows Flutter/Supabase setup. `flutter analyze` and manual tests are required.
