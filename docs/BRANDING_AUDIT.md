# 7rayer — Branding and Legacy TStore Audit

**Scope:** Source ZIP uploaded on 5 November 2026. This cleanup prioritizes accurate project documentation and safe display metadata; it does **not** certify every reachable screen as brand-free or production ready.

## Updated in this cleanup patch

- Root README and text README: 7rayer identity, artisan mission, five categories and honest implementation status.
- Root INSTALL_README and account notes: current instructions instead of obsolete patch-install steps.
- `CLAUDE.md`: updated contributor/agent context.
- Both `plans/*.md`: current migration status, security, and future phases.
- Added asset guide, feature-status matrix, release checklist, and this audit.
- `web/index.html` and `web/manifest.json`: description and 7rayer brand.
- `flutter_launcher_icons.yaml`, `splash.yaml`: existing 7rayer logo rather than missing TStore logo.
- Android application label, iOS display name, Windows/Linux user-facing window title / product metadata.
- Corrected a few legacy `TImages` paths that referenced missing local product/banners.
- Added warning comments to *legacy* sample SQL to avoid accidentally restoring shoes/electronics demo content.

## Remain unchanged intentionally

| Item | Reason |
|---|---|
| `pubspec.yaml: name: t_store` | Package name used by hundreds of Dart imports; careless replacement breaks compilation |
| `package:t_store/...` imports | Internal implementation identifiers; not customer-facing text |
| `class TStore`, `lib/t_store.dart` | Code-level identifiers; safe migration later |
| Android Kotlin package, applicationId, iOS bundle identifiers | Publishing identity changes require platform-specific migration and testing |
| Base Supabase table / column names | Existing database code depends on these contracts |
| Historic SQL `supabase_sample_data.sql` | Kept for reference but **not recommended for 7rayer import** |
| Legacy brand widgets and demo screens | Need a targeted UI audit and functional tests before deleting or rerouting |
| `.env` | Not included in patch or public distribution |

## Remaining actual code problems to address

1. **Legacy demo UI:** Some brand/product metadata widgets still contain Nike or TStore examples. Audit reachable routes; replace with real 7rayer catalog components.
2. **Legacy checkout:** `lib/features/shop/presentation/views/checkout_view.dart` has a hard-coded `$175` and a fake success flow. Keep it inaccessible until replaced with a real secure checkout.
3. **Profile and addresses:** Some secondary screens still contain old sample identities and untranslated labels.
4. **Brand icons:** Original brand graphics/assets still exist. Do not include them in the active artisan marketplace; remove unused assets only after checking references.
5. **Key handling:** `lib/core/supabase/supabase_config.dart` still contains fallback project URL and a client anon key. These are not server service-role secrets, but accidental project coupling must be removed and RLS reviewed before public release.
6. **Old credentials/references:** Review legacy code and docs for example emails, passwords and external URLs before publishing.
7. **Native icons:** Regenerate from new config; changing YAML alone does not update all binary icon assets.
8. **Validation:** No end-to-end pass, deployed payment, or legal approval was established from the uploaded ZIP.

## Do not share the original ZIP unchanged

The uploaded archive includes `.env`, `.dart_tool/chrome-device` browser-profile content, `build/` artifacts, local/ephemeral platform files, and other development-only data. This can expose session or environment details and makes the archive unnecessarily large. Do not upload the archive wholesale to a public GitHub repository. Create a fresh Git commit using `.gitignore` and inspect `git status` / `git ls-files` first. Keep auth tokens out of source, and rotate any credentials if exposed.

This cleanup ZIP contains only the reviewed changed files, not an entire browser cache or `.env`.

## Attribution

The repository was adapted from an existing TStore codebase. Retain proper upstream attribution and establish a correct software license before redistribution. The uploaded snapshot did not include the `LICENSE` file referenced by its former README.
