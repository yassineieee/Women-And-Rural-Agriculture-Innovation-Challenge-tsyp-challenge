# 7rayer — Supabase Data Status and Future Migration Plan

## Current backend

Flutter uses Supabase for authentication and database-driven buyer-facing catalog records. The base PostgreSQL schema was inherited from TStore and includes commerce-related tables for categories, products, profiles, cart, wishlist, orders, etc. Their existence does not imply all workflows are integrated or production tested.

## Existing SQL files

- **`supabase_schema.sql`** — inherited table creation and policies. Use only after reviewing compatibility with your target database; schema migrations require backups and version control.
- **`7rayer_catalog_fixed.sql`** — intended demonstration data for five Arabic categories and 15 handmade/regional products. Used in development. Verify contents and IDs before re-running.
- **`7rayer_catalog_demo_regenerated.sql`** — previous catalog attempt. Superseded for normal setup.
- **`supabase_sample_data.sql`** — **obsolete TStore sample dataset** containing non-artisanal product categories, demo brands and images; do not load into a 7rayer project.

## Current development asset strategy

The 15 demonstration products use local photo assets by product ID via `lib/core/common/widgets/product_photo.dart`. This is a prototype-only strategy. Product and category content come from Supabase, but their current demonstration media mappings are in Flutter code.

For production, plan a `product_media` model or approved storage URL relation; implement uploader authorization, image processing, ownership validation, and privacy. Do **not** make every storage bucket public indiscriminately.

## Proposed next schema changes (not implemented)

1. `artisans` — producer profile and consent information, minimal personally identifiable data.
2. `ambassador_hubs` / `hub_memberships` — collection centers, roles, territorial affiliation.
3. `product_batches` / `inventory_movements` — origin, intake, quantity, quality check, state transitions.
4. `product_media` / `listing_approvals` — dynamic approved photographs, moderation records.
5. `order_fulfillments` / `delivery_events` — shipping and pickup status.
6. `payment_events` / `settlement_ledger` — auditability and reconciliation, built around a qualified payment provider.
7. `traceability_records` — consent-aware QR links and product origin metadata.
8. `b2b_accounts` / `bulk_orders` — organization customers and bulk purchasing.

Do not implement money splits or legally sensitive obligations based only on a planning PDF; obtain formal business and legal requirements first.

## Suggested safe migration process

1. Export database backup and record current schema version.
2. Write incremental, reviewed SQL migrations; avoid re-running the base schema on an existing populated database.
3. Stage test data without changing existing user records.
4. Test RLS with buyer, ambassador, admin, and anonymous roles.
5. Test transactional order creation and inventory deductions in staging.
6. Document rollback and deploy in phases.

## Configuration notes

The Flutter client reads `SUPABASE_URL` and `SUPABASE_ANON_KEY` from `.env`. Only client-side publishable/anon keys belong in frontend code. The current `supabase_config.dart` has legacy fallback values that should be removed before public release; never put a service-role key in this file. Ensure actual authorization is enforced by RLS and controlled server-side operations.
