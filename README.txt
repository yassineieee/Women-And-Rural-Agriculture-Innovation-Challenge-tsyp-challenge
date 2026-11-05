7RAYER (حراير) — PROJECT INFORMATION
====================================

This repository is the 7rayer Tunisian artisanal marketplace prototype,
not the original TStore clothing/electronics demonstration app.

READ THESE DOCUMENTS:
- README.md                          Main project overview and truthful status
- INSTALL_README.md                  Local setup and Supabase instructions
- docs/FEATURE_STATUS.md             Implemented versus planned features
- docs/ASSET_GUIDE.md                Local product photos, banners, logos
- docs/BRANDING_AUDIT.md             Remaining TStore references and safety notes
- docs/RELEASE_CHECKLIST.md          Before deployment or public release
- plans/project_analysis_and_roadmap.md

To run on the existing Windows workstation:
  cd "C:\Users\hp\Downloads\TStore-main\TStore-main"
  flutter pub get
  flutter analyze
  flutter run -d chrome -t lib/main_development.dart

IMPORTANT:
- The internal Dart package remains named t_store for compatibility.
- This is an MVP prototype; checkout, payment, seller, ambassador, and admin
  functionality are NOT complete.
- Do not import supabase_sample_data.sql for the 7rayer catalog.
- Never publish .env, browser profiles, or build/cache directories.
