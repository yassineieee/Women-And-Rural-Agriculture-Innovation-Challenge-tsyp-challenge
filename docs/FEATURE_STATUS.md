# 7rayer — Feature Status (5 November 2026)

Status vocabulary: **Implemented in code** = corresponding screens and/or repositories exist, but no claim of successful end-to-end testing. **Partial** = demonstrated UI or service with missing flows. **Planned** = not implemented.

| Capability | Status | Notes |
|---|---|---|
| Flutter web buyer frontend | Implemented in code | Chrome development entry point present |
| 7rayer colors, logo, favicon | Implemented in code | Native/PWA icon regeneration still required |
| Arabic + RTL support | Partial | Core screens adapted; legacy screens remain |
| Five artisanal categories | Implemented in code | Supabase records and home navigation |
| Arabic 15-product catalog | Implemented in code | Demo data; depends on running corrected SQL in the right DB |
| TND product prices | Implemented in code | From product records; demo prices are not confirmed retail prices |
| Product images | Implemented in code | Local ID-based JPG mapping; future dynamic upload needed |
| Local banner carousel | Implemented in code | Three JPG images |
| Favorites heart | Implemented in code | Cubit/repository; Supabase auth/RLS need real-user validation |
| Cart listing and totals | Partial | Checkout disabled in main cart UI |
| Account screen | Partial | Arabic headings; anonymous demo display name; secondary screens need work |
| Authentication | Partial | Supabase code present; run registration, recovery and security tests |
| Reviews | Legacy scaffold | Models and widgets exist, but no end-to-end validation |
| Chat / notifications | Legacy scaffold | Repository/state files exist; not verified as working user features |
| Checkout and payments | **Not ready** | Legacy hard-coded checkout page still present in source; do not connect to purchase flow |
| Real order fulfillment | Planned / unverified | Models are not proof of fulfillment operations |
| Seller/artisan dashboard | Planned | No dedicated completed UI |
| Ambassador / hub dashboard | Planned | Needs role-based inventory and intake |
| Admin dashboard | Planned | Needs moderation, reporting, controls |
| QR traceability | Planned | Needs backend identity, consent and provenance design |
| B2B bulk ordering | Planned | No validated B2B workflow |
| IVR / USSD / accessible assisted onboarding | Concept only | Requires external services and community pilots |
| Revenue allocation and payouts | Concept only | Not implemented; needs compliance and validation |
| Education / wellbeing prompts | Concept only | Not implemented |

Do not mark any feature complete solely because a Dart class, SQL table, screenshot, or test name exists.
