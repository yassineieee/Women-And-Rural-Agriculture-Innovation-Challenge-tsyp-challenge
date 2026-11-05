# 7rayer — Local Assets and Visual Identity Guide

## Asset locations

| Asset type | Path | Current use |
|---|---|---|
| Brand logo | `assets/logos/7rayer-splash-logo-black.png` | In-app logo; icon generator / splash config |
| Browser favicon | `web/favicon.png` | Browser tab |
| Product photos | `assets/images/products/7rayer-###.jpg` | Mapped for fifteen known demo UUIDs |
| Homepage banners | `assets/images/banners/banner_1.jpg` … `banner_3.jpg` | Local promo carousel |
| Category icons | `assets/icons/categories/` | Five categories use selected existing icon assets |

Both JPG and PNG banner versions may exist. The actual path in `lib/core/utils/constants/image_strings.dart` decides which version Flutter loads.

## Product filename mapping

| Filename | Product concept |
|---|---|
| `7rayer-001.jpg` | Thyme honey |
| `7rayer-002.jpg` | Rosemary honey |
| `7rayer-003.jpg` | Beeswax |
| `7rayer-004.jpg` | Bsissa |
| `7rayer-005.jpg` | Couscous |
| `7rayer-006.jpg` | Fig jam |
| `7rayer-007.jpg` | Handmade bag |
| `7rayer-008.jpg` | Traditional scarf |
| `7rayer-009.jpg` | Embroidered textile |
| `7rayer-010.jpg` | Olive oil |
| `7rayer-011.jpg` | Dried herbs |
| `7rayer-012.jpg` | Orange blossom water |
| `7rayer-013.jpg` | Pottery plate |
| `7rayer-014.jpg` | Handmade basket |
| `7rayer-015.jpg` | Ceramics |

The ID mapping is a **temporary prototype mechanism** inside `ProductPhoto`. Future artisan products will need database-managed media URLs, not more numbered code cases.

## Debug local assets

```powershell
Get-ChildItem '.\assets\images\products\7rayer-*.jpg' | Select-Object Name
Get-ChildItem '.\assets\images\banners' | Select-Object Name, Extension
flutter pub get
flutter analyze
flutter run -d chrome -t lib/main_development.dart
```

Do not rename `.png` to `.jpg` for PNG data: convert it using an image tool. `.jpeg` and `.jpg` are both JPEG format, so copying one to the other extension is acceptable. Check spelling, case and exact extensions.

## How banner selection works

1. `image_strings.dart` declares `TImages.banner1`, `banner2`, `banner3`.
2. `promo_banner_carousel_slider.dart` supplies those to `BannerCarouselSlider`.
3. `banner_carousel_slider.dart` renders each image.

If the path is `assets/`, load it using `Image.asset`. If it is `https://`, use a network image widget. Never load a URL as a Flutter asset.

## Replace platform icons

Current icon/splash configuration now points to the existing 7rayer logo. To actually regenerate icons:

```powershell
dart run flutter_launcher_icons
dart run flutter_native_splash:create --path=splash.yaml
```

Review results per platform; these generators can overwrite platform assets. Web PWA icons may still show old art until regenerated and the browser cache is refreshed.
