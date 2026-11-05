# 7rayer (حراير) — Technical Assessment and Roadmap

**Baseline:** Uploaded development snapshot dated 5 November 2026. This is a forward-looking plan, not an assertion that each feature has passed integration tests.

## Goal

Build an inclusive Tunisian artisan marketplace connecting producers, local WADG/ambassador hubs, customers, and eventually institutional/B2B buyers. The present codebase is a **buyer-facing Flutter prototype**. Assisted producer onboarding and multi-role operations remain to be built.

## Baseline: implemented or partially implemented

| Workstream | Current baseline | Remaining verification |
|---|---|---|
| Branding | 7rayer logos, palette, web title/favicon | Regenerate Android/iOS/PWA icons; inspect every screen |
| Localization | Arabic catalog and account UI; RTL enabled | Translate legacy views; accessibility and Arabic typography |
| Catalog | Supabase categories/products; five artisanal categories and 15 demo items | Validate RLS, category links, sorting, empty/error behavior |
| Photos | Local `7rayer-###.jpg` mapping | Replace ID-based demo mapping with managed media records |
| Banners | Three local JPG banners in homepage carousel | Responsive crop/performance; campaign management |
| Wishlist | Hearts + state/repository structures | Sign-in, persistence, RLS, refresh, edge cases |
| Cart | Cart items and totals view | Quantity controls, inventory consistency, price validation |
| Auth/account | Supabase auth integration and partial Arabic account UI | Registration/recovery, profile editing, deletion/privacy, social auth testing |
| Orders | Source repositories/models exist | Actual user journey, inventory transaction, fulfillment and payments |
| Tests | Automated test source exists | Execute, fix failures, set CI and report measured coverage |

## Next phases (recommended order)

### Phase A — Stabilize buyer MVP

- Remove active routes to generic TStore Nike/brand/clothing screens and leftover fake transaction screens.
- Complete Arabic localization and RTL for checkout-related and secondary screens.
- Validate authentication and permissions with test buyer accounts.
- Implement real checkout states (without simulating success); product availability and order creation must be transactional.
- Replace local demonstration photo-ID mapping with dynamic, authorized product media management.
- Establish smoke/widget/integration tests and a documented deployment pipeline.

**Definition of done:** A test buyer can browse five categories, save/unsave favorites, manage cart, and place a clearly marked test order without fictitious prices or false payment confirmation.

### Phase B — Ambassador and collection hub

- Add role-based permissions: ambassador, producer, buyer, administrator.
- Artisan registration with explicit consent, privacy, and minimal personal information.
- Inventory intake: product batch, weight, quantity, source region, quality inspection, photos, receipts.
- Audit trails and stock reconciliation for hub handoffs and returned goods.

**Definition of done:** A test ambassador can register a batch, attribute it to an artisan, and create a moderated listing with traceable stock movements.

### Phase C — Seller and producer experience

- Mobile-friendly seller view, optional ambassador-mediated access, sales and earnings visibility.
- Accessible language choices and workflows for users without modern smartphones.
- Pilot paper receipt and voice/USSD mechanisms only after feasibility research and telecom integration.

### Phase D — Administrator dashboard

- Role and permissions management; catalog moderation; disputes; inventory; order oversight.
- Secure, auditable reporting; export; operations dashboards.
- Financial reconciliation with explicit permissions and approvals.

### Phase E — Payments, B2B and traceability

- Evaluate regulated payment partners, customer refunds, settlement, taxes and legal obligations.
- Confirm any proposed revenue-sharing policy before automated disbursement.
- B2B bulk ordering, contract pricing, fulfillment workflows.
- QR-based origin and artisan storytelling with consent, selective disclosures, and anti-fraud controls.

### Phase F — Learning and social-impact modules

- Free artisan learning materials and peer-to-peer teaching.
- Optional wellbeing reminders using appropriate opt-in preferences.
- Impact measurement that respects privacy and uses verified metrics.

## Engineering priorities

**P0 — Security:** prevent client-side secret keys, validate RLS, verify no production credentials in archives, and remove unwanted hard-coded fallback Supabase project identifiers from `supabase_config.dart` through a tested update.

**P1 — Correctness:** actual end-to-end checkout; proper account flows; audit remaining static legacy widgets; validate empty/loading/error states.

**P2 — Maintainability:** consolidate legacy and new GetIt locators; standardize repositories, state management, and image upload; eliminate stale brand constants from active UI.

**P3 — User experience:** mobile responsive layouts, accessible Arabic typography, performance of large banner images, better pagination and content moderation.

## Validation before release

- `flutter analyze` succeeds with no errors.
- Test suite executed and results recorded (not merely test filenames counted).
- Auth + RLS tested with separate buyer, ambassador, and admin accounts.
- All prices and order totals verified server-side.
- No fake payment success; no unwanted TStore visuals in reachable screens.
- Terms, privacy, payment and artisan revenue model reviewed with relevant stakeholders.
