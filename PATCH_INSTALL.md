# Installing the 7rayer documentation and branding cleanup

**Back up your project first.** This ZIP is a **small overlay patch**, not a complete Flutter project. It contains updated README files, project plans, selected web/native display metadata, a few image path corrections, and safety notes. It does not include your `.env`, local photos, or personal browser profile.

```powershell
cd "C:\Users\hp\Downloads\TStore-main\TStore-main"
$backup = "$HOME\Downloads\7rayer_before_docs_$(Get-Date -Format yyyyMMdd_HHmmss)"
New-Item -ItemType Directory -Path $backup -Force | Out-Null
Copy-Item '.\README.md' "$backup\README.md"
Copy-Item '.\README.txt' "$backup\README.txt"
Copy-Item '.\INSTALL_README.md' "$backup\INSTALL_README.md"
Copy-Item '.\CLAUDE.md' "$backup\CLAUDE.md"
Copy-Item '.\web' "$backup\web" -Recurse
Copy-Item '.\lib\core\utils\constants\image_strings.dart' "$backup\image_strings.dart"
Expand-Archive -Path "$HOME\Downloads\7rayer_branding_cleanup.zip" -DestinationPath (Get-Location).Path -Force
flutter analyze
flutter run -d chrome -t lib/main_development.dart
```

**Important:** `flutter analyze` may show pre-existing infos/warnings. This patch has been reviewed statically but Flutter compilation could not be executed in the report environment. The package name `t_store` and imports remain untouched by design. Launch icons must be regenerated explicitly; changing YAML does not automatically overwrite existing binary icons.

Read `docs/BRANDING_AUDIT.md` and `docs/RELEASE_CHECKLIST.md` after extraction. Avoid publishing the original project ZIP unchanged because it contains `.env`, browser profile data and generated build/cache files.
