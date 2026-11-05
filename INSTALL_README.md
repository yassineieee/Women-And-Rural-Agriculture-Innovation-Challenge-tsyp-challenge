# 7rayer — Installation and Development Guide

This file replaces obsolete patch-by-patch instructions. Use the current code already present in this project rather than reinstalling older replacement ZIPs.

## 1. Prerequisites

- Flutter SDK / Dart SDK compatible with `pubspec.yaml` (Dart SDK constraint is `^3.10.0`).
- VS Code or Android Studio, Google Chrome for web development.
- An existing Supabase development project.
- On Windows: PowerShell in the Flutter project root.

## 2. Start the application

```powershell
cd "C:\Users\hp\Downloads\TStore-main\TStore-main"
flutter doctor
flutter pub get
flutter analyze
flutter run -d chrome -t lib/main_development.dart
```

If an existing Flutter process is running, stop it with `Ctrl+C` before starting a new one. Use `Ctrl+Shift+R` in Chrome after web asset changes.

## 3. Configure Supabase

```powershell
Copy-Item .env.example .env
code .env
```

Set your `SUPABASE_URL` and `SUPABASE_ANON_KEY` for your own **development** project. The latter is named for legacy compatibility and should contain only a client-side publishable or legacy anon key. Never use a service-role or secret key in the Flutter app. Keep `.env` out of source control.

The main application initializes Supabase in `lib/main_development.dart` and reads settings through `lib/core/supabase/supabase_config.dart`. **Important:** that file includes legacy fallback project values; audit it before publishing the source.

## 4. SQL files — which ones to use

| File | Purpose | Instruction |
|---|---|---|
| `supabase_schema.sql` | Legacy base schema | Review for a **new, empty** development database; do not run over production without a migration plan |
| `7rayer_catalog_fixed.sql` | 7rayer demo categories + 15 products | Use **after backing up** your development database |
| `7rayer_catalog_demo_regenerated.sql` | Older sample catalog attempt | Keep for history; do not execute alongside the fixed catalog |
| `supabase_sample_data.sql` | Old clothes, electronics, brand demos | Do **not** import to create the 7rayer storefront |

To view the fixed 7rayer SQL from PowerShell:

```powershell
code .\7rayer_catalog_fixed.sql
```

Copy it to the clipboard:

```powershell
Get-Content -Raw -Encoding UTF8 '.\7rayer_catalog_fixed.sql' | Set-Clipboard
```

Then paste into **Supabase → SQL Editor** and review before selecting Run. PowerShell does **not** execute this SQL.

## 5. Verify the catalog and assets

For catalog rows in Supabase:

```sql
SELECT c.name AS category, p.name AS product, p.price, p.is_active
FROM public.categories c
LEFT JOIN public.products p ON p.category_id = c.id
ORDER BY c.name, p.name;
```

Verify local demo product JPGs:

```powershell
Get-ChildItem '.\assets\images\products\7rayer-*.jpg' | Select-Object Name
```

Verify banners:

```powershell
Get-ChildItem '.\assets\images\banners' | Select-Object Name
```

The current homepage expects `banner_1.jpg`, `banner_2.jpg`, `banner_3.jpg`. Do not replace those with PNG paths unless `image_strings.dart` is updated accordingly.

## 6. Rebuild platform branding, if needed

`flutter_launcher_icons.yaml` and `splash.yaml` point to the existing 7rayer logo. These configuration files do not regenerate launcher assets automatically.

```powershell
dart run flutter_launcher_icons
# For mobile native splash screens, if needed:
dart run flutter_native_splash:create --path=splash.yaml
```

Back up native resources first. Review the generated Android/iOS/web icon images and test on each target platform. Do not rename the Dart package globally just to change the displayed application name.

## 7. Known limitations

The catalog, category pages, favorites and cart contain working implementation paths, but Supabase permissions, account flows, and end-to-end behavior need testing. Checkout is not ready, payments are not integrated, and seller/ambassador/admin dashboards are planned. Some original brand-related widgets and secondary English labels remain.

## 8. Safe editing workflow

```powershell
$backup = "$HOME\Downloads\7rayer_backup_$(Get-Date -Format yyyyMMdd_HHmmss)"
New-Item -ItemType Directory -Path $backup -Force | Out-Null
Copy-Item '.\lib' "$backup\lib" -Recurse
Copy-Item '.\pubspec.yaml' "$backup\pubspec.yaml"
```

Before changing database structure, take a database backup separately. Never treat a Flutter code backup as a Supabase database backup.

More information: [README](README.md), [asset guide](docs/ASSET_GUIDE.md), [status](docs/FEATURE_STATUS.md), [release checklist](docs/RELEASE_CHECKLIST.md).
