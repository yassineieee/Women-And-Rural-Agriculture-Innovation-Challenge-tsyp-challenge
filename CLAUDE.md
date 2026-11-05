# 7rayer — Repository notes for coding assistants

This is the **7rayer (حراير)** Tunisian artisanal marketplace prototype, adapted from TStore. All code edits must preserve the current user's working environment and the existing database contract.

## Current project facts

- Flutter / Dart app, with `lib/main_development.dart` as the active Chrome development entry point.
- Supabase backend for auth, catalog, and wishlist/cart repositories.
- Five Arabic artisan product categories and fifteen known demo product IDs.
- Product photos in `assets/images/products/7rayer-001.jpg` … `7rayer-015.jpg`, mapped by `ProductPhoto`.
- Three local banners selected through `TImages.banner1`, `banner2`, `banner3`.
- Buyer-facing Arabic/RTL work in progress.
- Seller, ambassador, admin, B2B, payment, and verified order flow are **not** complete.

## Do not break internal identifiers

`name: t_store` in `pubspec.yaml`, imports beginning `package:t_store/`, class `TStore`, and some native project identifiers are inherited internal identifiers. They are not the displayed brand and must not be replaced using global search-and-replace. Rename only through a coordinated, tested package migration.

## Safe workflow

1. Inspect actual source files before claiming how a screen works.
2. Back up touched files and use small, reviewable changes.
3. Never claim an untested capability is complete; mark features as demo, partial, or planned.
4. Retain correct 7rayer vocabulary: Tunisian artisans, traditional foods, bee products, textile crafts, herbs/oils, handmade goods.
5. Do not restore Nike, clothing, shoe, electronics, or fake-brand demo screens to active routes.
6. Keep local asset extensions and filenames exact, including case sensitivity.
7. Do not expose real tokens, edit `.env` into documentation, or disable RLS.
8. Run `flutter analyze` and relevant tests after source edits; record actual results.

## Key commands

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d chrome -t lib/main_development.dart
```

Read `README.md`, `docs/FEATURE_STATUS.md`, `docs/ASSET_GUIDE.md`, `docs/BRANDING_AUDIT.md`, and `plans/project_analysis_and_roadmap.md` before broad changes.
