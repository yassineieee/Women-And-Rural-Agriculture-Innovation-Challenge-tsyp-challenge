# 7rayer — Account interface notes

This account localization change has **already been integrated** into the source snapshot. Do not reinstall earlier account patch ZIPs over the current code.

## Current account UI

- Main settings page and selected profile labels are in Arabic.
- Header displays the demo-facing text `anonymous anonymous`.
- Email subtitle comes from the authenticated Supabase user when available.
- Profile details and some menu destinations may still be incomplete or contain original demonstration UI.
- The displayed anonymous name does not change the user's Supabase profile or authentication identity.

## Key files

- `lib/features/personalization/presentation/widgets/settings_view_header_section.dart`
- `lib/features/personalization/presentation/views/settings_view.dart`
- `lib/features/personalization/presentation/views/profile_view.dart`
- `lib/features/personalization/presentation/widgets/`

## Before production

Implement actual profile data retrieval and editing, permissions, address handling, and privacy/account deletion options; translate secondary screens and remove any remaining sample identities. Verify these changes against a test user.

**Do not edit account names or email addresses directly in source code as a substitute for real user account management.**
