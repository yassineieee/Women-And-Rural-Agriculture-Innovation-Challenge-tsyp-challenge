# 7rayer — Release Readiness Checklist

This is a checklist, **not a record that these steps are complete**.

## Technical

- [ ] Run `flutter analyze` and resolve all errors; record output.
- [ ] Run `flutter test`; record counts, results and any skipped tests.
- [ ] Test responsive layouts and RTL on web and at least one target mobile device.
- [ ] Confirm there are no active Nike/TStore, clothing/electronics, or fake checkout routes.
- [ ] Ensure local image assets load with correct exact filenames and compressed file sizes.
- [ ] Regenerate launcher/splash/PWA icons, update caches, test browser tab.
- [ ] Verify accessibility of Arabic labels, keyboard navigation, screen readers and forms.

## Backend and security

- [ ] Remove legacy fallback Supabase project URL/client key in `supabase_config.dart` through a tested change.
- [ ] Verify user-specific RLS for wishlist, cart, addresses, orders, and profiles.
- [ ] Ensure all monetary calculations and inventory authorization happen in trusted server-side logic.
- [ ] No `service_role`, payment secret or privileged token is included in frontend or repository.
- [ ] Inspect `git status`, `git ls-files` for `.env`, browser caches, and private data.
- [ ] Record database backups and schema migrations.

## Business and operations

- [ ] Seller/ambassador/admin role and access controls designed and tested.
- [ ] Product provenance, producer consent, photo rights and privacy policy approved.
- [ ] Order, payment, refunds, delivery and returns processes tested with partners.
- [ ] Any revenue-sharing formula reviewed for legal, financial and operational compliance.
- [ ] Validate institutional B2B needs before building bulk-order features.
- [ ] Establish user support, incident response, backup recovery and audit logging.

## Publication

- [ ] Verify rights/license of the original TStore template before releasing a derived repository.
- [ ] Remove unused old assets and dead code only after dependency and route audit.
- [ ] Update screenshots of the actual current application, with no personal user data.
- [ ] Only describe features as complete when demonstration and test evidence exist.
