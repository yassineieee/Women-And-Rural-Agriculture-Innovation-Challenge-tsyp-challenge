# 7rayer (حراير)

**A Flutter marketplace prototype for Tunisian artisanal and regional products.**

7rayer aims to connect products made by women artisans in rural Tunisia with consumers, while preparing an assisted sales model through local ambassadors and collection hubs. The marketplace focuses on traditional foods, bee products, textile crafts, herbs and oils, and handmade goods—not a general clothing, sneaker, or electronics shop.

> **Project status (5 November 2026): Development prototype / buyer-facing MVP in progress.** Do not describe this repository as a completed, production-ready e-commerce service. Checkout, seller onboarding, administration, payments, delivery operations, and end-to-end verification are not complete.

## Purpose and intended impact

Artisans should be able to focus on production, even when they have limited access to smartphones, banking tools, internet connectivity, or time for online store administration. The longer-term 7rayer model proposes community-level ambassadors and local aggregation hubs to record product intake, verify quality, photograph products, and publish listings on behalf of producers.

The current repository implements the **customer-facing technical foundation**. The producer/ambassador workflow described above is a **future development objective**, not a working part of the application today.

## What the prototype currently includes

| Area | Current state |
|---|---|
| Flutter app | Web-capable Flutter/Dart source; development runs in Chrome |
| Visual identity | 7rayer logo, burgundy/ivory theme, browser favicon, and local promotional banners |
| Arabic interface | Arabic strings and right-to-left presentation in key buyer views; some legacy screens still untranslated |
| Catalog | Supabase-backed product and category records; 15-product Arabic demonstration catalog |
| Categories | Five clickable artisanal categories with dedicated category views |
| Product photos | Local demo assets `assets/images/products/7rayer-001.jpg` … `7rayer-015.jpg` |
| Product details | Selected product name, description, price, and image from the product record / local demo mapping |
| Favorites | Heart controls and wishlist repository/Cubit integrated; test sign-in and Supabase permissions |
| Cart | Cart records, quantity and totals view; **payment/checkout deliberately incomplete** |
| Accounts | Supabase authentication integration; account screens partially translated; `anonymous anonymous` is a display placeholder, not a changed database identity |
| Tests | Test source files exist, but a passing suite and claimed coverage have **not** been verified for this adapted version |

### Five current categories

1. **منتجات النحل** — Bee products (honey, beeswax)
2. **مأكولات تقليدية** — Traditional foods (bsissa, couscous, fig jam)
3. **نسيج وتطريز** — Weaving and embroidery
4. **أعشاب وزيوت** — Herbs and oils
5. **صناعات يدوية** — Handmade crafts (pottery, baskets, ceramics)

Prices in the demonstration catalog are expressed in Tunisian dinars (`د.ت`). The values are sample data and should not be interpreted as confirmed retail prices.

## Technology

- **Client:** Flutter / Dart, with a web run target and Android/iOS project scaffolding.
- **Backend:** Supabase (PostgreSQL, Supabase Auth, database access).
- **State management:** `flutter_bloc` / Cubit; some screens also use direct Supabase queries.
- **Architecture:** feature-oriented `data`, `domain`, and `presentation` directories, repositories, use cases, and GetIt service locators; legacy code is still being consolidated.
- **Media:** local Flutter assets for product images and promotional banners in the current prototype. The codebase also includes network/storage capabilities for later versions.

**Internal naming note:** `pubspec.yaml` intentionally retains `name: t_store`, and Dart imports still use `package:t_store/...`. These are internal source identifiers inherited from the original template. They do **not** change the displayed 7rayer brand. Renaming the package requires a coordinated migration of imports and native project settings; do not search-and-replace blindly.

## Run locally (Windows PowerShell)

```powershell
cd "C:\Users\hp\Downloads\TStore-main\TStore-main"
flutter doctor
flutter pub get
flutter analyze
flutter run -d chrome -t lib/main_development.dart
```

This path matches the current local development setup. If you unzip the project elsewhere, change only the directory path.

### Supabase environment

Create `.env` in the project root by copying `.env.example` and filling in your own project URL and **public/publishable client key** (the existing code currently reads the variable name `SUPABASE_ANON_KEY`):

```powershell
Copy-Item .env.example .env
code .env
```

Example (do not paste a real key into documentation):

```dotenv
SUPABASE_URL=https://YOUR_PROJECT.supabase.co
SUPABASE_ANON_KEY=YOUR_CLIENT_PUBLISHABLE_OR_LEGACY_ANON_KEY
```

Use **only** a client-side publishable/anon key, never a `service_role` or secret server key. Authorization depends on properly configured Supabase Row Level Security policies; `.env` in a Flutter client is not a secure server-side secret vault.

### Database setup: read before running SQL

- `supabase_schema.sql` is the **original base schema**, not the complete future 7rayer data model. Review it before applying it to a fresh development database.
- `7rayer_catalog_fixed.sql` is the intended **7rayer demonstration data update**: five Arabic categories and fifteen products. It modifies known demo records and should be run only against the intended development Supabase project after a backup.
- `supabase_sample_data.sql` contains **legacy TStore electronics, clothing, and brand examples**; **do not import it** to populate the 7rayer catalog.
- `7rayer_catalog_demo_regenerated.sql` is an **older iteration**; prefer the fixed version and do not run both indiscriminately.

SQL files are executed through **Supabase Dashboard → SQL Editor**, not by pasting SQL into PowerShell. See [installation notes](INSTALL_README.md) and [data migration notes](plans/supabase_migration_plan.md).

### Local images and banners

- Product image mapping is implemented in `lib/core/common/widgets/product_photo.dart` and corresponds to the fifteen known demonstration product IDs. The files live under `assets/images/products/`.
- Banner carousel paths are defined in `lib/core/utils/constants/image_strings.dart`, using `assets/images/banners/banner_1.jpg`, `banner_2.jpg`, and `banner_3.jpg`. Both JPG and PNG versions may exist; paths must match the files exactly.
- Logo paths are also defined in `image_strings.dart` and sourced from `assets/logos/`.
- Changing a Dart asset path requires saving the file and restarting Flutter if a hot reload does not refresh assets.

See [asset guide](docs/ASSET_GUIDE.md) for details.

## Main source directories

```text
lib/
├── core/                     Shared widgets, service locators, config, theme
├── features/
│   ├── auth/                 Authentication UI and logic
│   ├── shop/                 Catalog, categories, banners, product pages
│   ├── cart/                 Cart records and state
│   ├── wishlist/             Favorites records and state
│   └── personalization/      Account/profile UI
├── main_development.dart     Development entry point
├── main_production.dart      Production entry point (not validated for launch)
└── t_store.dart              Flutter root widget (legacy internal filename)
```

Other legacy modules (orders, reviews, chat, notifications, brand-based shopping UI) exist in the codebase but should not be presented as fully completed 7rayer features.

## Future development

The planned platform includes:

- **Ambassador dashboard:** artisan registration, inventory intake, quantities, inspection, product photography, listing publication, and hub-level tracking.
- **Seller/artisan experience:** product visibility, available stock, sales and earnings reports, designed to work with or without direct smartphone use.
- **Administrator interface:** role-based access, catalog approval, inventory, users, moderation, orders, reports, and financial reconciliation.
- **Verified checkout and operations:** pricing, inventory reservation, order lifecycle, delivery, customer support, and lawful payment integration.
- **B2B orders:** consolidated ordering for hotels, shops, restaurants, and other institutional buyers.
- **Traceability:** QR-linked origin and artisan stories, with privacy/consent controls.
- **Accessibility:** proposed paper receipts, Tunisian-Derja IVR/USSD options, learning materials, and optional wellbeing reminders.

A proposed revenue-allocation model is described in the project's concept document. It is **not implemented** in the app, and payment/legal/tax compliance requires validation before deployment.

See [development roadmap](plans/project_analysis_and_roadmap.md) and [feature status](docs/FEATURE_STATUS.md).

## Development checks

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d chrome -t lib/main_development.dart
```

**Checks must actually be run and recorded.** Existing test files are not proof of passing tests, and the presence of repository/Cubit code is not proof of functioning screens or completed backend permissions.

## Privacy, security, and publishing

Do not commit `.env`, `.dart_tool/`, `build/`, browser profiles, local SDK files, or private customer data. This repository may contain legacy client configuration in source files; review `lib/core/supabase/supabase_config.dart` and remove unwanted fallback project identifiers before public distribution. Configure and test Supabase RLS before accepting customer data. See [release checklist](docs/RELEASE_CHECKLIST.md).

## Attribution and rights

7rayer is an adaptation of a pre-existing TStore Flutter codebase. Retain appropriate attribution to the upstream creator and verify the original project's distribution license before publishing or redistributing the adapted repository. **No license file was present in the uploaded snapshot**, so this README does not assert a license that has not been verified.

---

**Project:** 7rayer / حراير · **Phase:** buyer-facing development prototype · **Documentation updated:** 5 November 2026.
