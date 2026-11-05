-- DEPRECATED FOR CURRENT 7RAYER SETUP: Older demo catalog revision. Prefer 7rayer_catalog_fixed.sql after backing up the development database.
-- 7RAYER / حراير — SAFE ARABIC DEMONSTRATION CATALOG (15 products)
-- Supabase SQL Editor, using the EXISTING TStore database.
-- Backup before execution. Do NOT rerun supabase_schema.sql.
-- Updates only original demo UUIDs to deactivate them; creates 7rayer demo UUIDs.
-- Does NOT drop tables, remove accounts/orders, or modify user authentication.
-- Demo prices (TND), quantities, titles, and descriptions are fictional.
-- No real product photos included. URLs are generic non-product placeholders.
-- Re-running the script does not overwrite images or edits to existing 7rayer rows.
-- This is only for your TEST/DEVELOPMENT database. Do not run on live production data.

BEGIN;

-- 1) Disable EXACT original TStore demo entries, while preserving their rows and any references.
UPDATE public.products SET is_active = FALSE WHERE id IN (
  'a1000000-0000-0000-0000-000000000001'::uuid,
  'a1000000-0000-0000-0000-000000000002'::uuid,
  'a1000000-0000-0000-0000-000000000003'::uuid,
  'a1000000-0000-0000-0000-000000000004'::uuid,
  'a1000000-0000-0000-0000-000000000005'::uuid,
  'a1000000-0000-0000-0000-000000000006'::uuid,
  'a1000000-0000-0000-0000-000000000007'::uuid,
  'a1000000-0000-0000-0000-000000000008'::uuid,
  'a1000000-0000-0000-0000-000000000009'::uuid,
  'a1000000-0000-0000-0000-000000000010'::uuid,
  'a1000000-0000-0000-0000-000000000011'::uuid,
  'a1000000-0000-0000-0000-000000000012'::uuid,
  'a1000000-0000-0000-0000-000000000013'::uuid,
  'a1000000-0000-0000-0000-000000000014'::uuid,
  'a1000000-0000-0000-0000-000000000015'::uuid,
  'a1000000-0000-0000-0000-000000000016'::uuid,
  'a1000000-0000-0000-0000-000000000017'::uuid,
  'a1000000-0000-0000-0000-000000000018'::uuid,
  'a1000000-0000-0000-0000-000000000019'::uuid,
  'a1000000-0000-0000-0000-000000000020'::uuid,
  'a1000000-0000-0000-0000-000000000021'::uuid,
  'a1000000-0000-0000-0000-000000000022'::uuid,
  'a1000000-0000-0000-0000-000000000023'::uuid,
  'a1000000-0000-0000-0000-000000000024'::uuid,
  'a1000000-0000-0000-0000-000000000025'::uuid,
  'a1000000-0000-0000-0000-000000000026'::uuid,
  'a1000000-0000-0000-0000-000000000027'::uuid,
  'a1000000-0000-0000-0000-000000000028'::uuid,
  'a1000000-0000-0000-0000-000000000029'::uuid
);

UPDATE public.categories SET is_active = FALSE WHERE id IN (
  'c1000000-0000-0000-0000-000000000001'::uuid,
  'c1000000-0000-0000-0000-000000000002'::uuid,
  'c1000000-0000-0000-0000-000000000003'::uuid,
  'c1000000-0000-0000-0000-000000000004'::uuid,
  'c1000000-0000-0000-0000-000000000005'::uuid
);

UPDATE public.brands SET is_active = FALSE WHERE id IN (
  'b1000000-0000-0000-0000-000000000001'::uuid,
  'b1000000-0000-0000-0000-000000000002'::uuid,
  'b1000000-0000-0000-0000-000000000003'::uuid,
  'b1000000-0000-0000-0000-000000000004'::uuid,
  'b1000000-0000-0000-0000-000000000005'::uuid
);

UPDATE public.coupons SET is_active = FALSE WHERE id IN (
  'ca100000-0000-0000-0000-000000000001'::uuid,
  'ca100000-0000-0000-0000-000000000002'::uuid,
  'ca100000-0000-0000-0000-000000000003'::uuid
);

UPDATE public.banners SET is_active = FALSE WHERE id IN (
  'ba100000-0000-0000-0000-000000000001'::uuid,
  'ba100000-0000-0000-0000-000000000002'::uuid,
  'ba100000-0000-0000-0000-000000000003'::uuid,
  'ba100000-0000-0000-0000-000000000004'::uuid,
  'ba100000-0000-0000-0000-000000000005'::uuid
);

-- 2) Five categories. Keep existing category images on repeat execution.
INSERT INTO public.categories (id, name, description, image_url, sort_order, is_active) VALUES
  ('c7000000-0000-0000-0000-000000000001'::uuid, 'منتجات النحل', 'عسل طبيعي ومنتجات النحل - بيانات تجريبية', 'https://placehold.co/800x800/F6E8E2/9F1833.png?text=7RAYER', 1, TRUE),
  ('c7000000-0000-0000-0000-000000000002'::uuid, 'مأكولات تقليدية', 'بسيسة وكسكسي ومأكولات تونسية تقليدية - بيانات تجريبية', 'https://placehold.co/800x800/F8EDE4/9F1833.png?text=7RAYER', 2, TRUE),
  ('c7000000-0000-0000-0000-000000000003'::uuid, 'نسيج وتطريز', 'منسوجات وتطريزات تونسية يدوية - بيانات تجريبية', 'https://placehold.co/800x800/F5E3EB/9F1833.png?text=7RAYER', 3, TRUE),
  ('c7000000-0000-0000-0000-000000000004'::uuid, 'أعشاب وزيوت', 'أعشاب مجففة وزيوت محلية - بيانات تجريبية', 'https://placehold.co/800x800/EDEBDA/9F1833.png?text=7RAYER', 4, TRUE),
  ('c7000000-0000-0000-0000-000000000005'::uuid, 'صناعات يدوية', 'فخار وحلفاء ومنتجات حرفية - بيانات تجريبية', 'https://placehold.co/800x800/F6ECE0/9F1833.png?text=7RAYER', 5, TRUE)
ON CONFLICT (id) DO NOTHING;

-- 3) Demo groups (NOT verified cooperatives or artisan identities).
INSERT INTO public.brands (id, name, description, is_featured, is_active) VALUES
  ('b7000000-0000-0000-0000-000000000001'::uuid, 'حراير - منتجات النحل', 'مجموعة تجريبية - منتجات النحل', TRUE, TRUE),
  ('b7000000-0000-0000-0000-000000000002'::uuid, 'حراير - مأكولات تقليدية', 'مجموعة تجريبية - مأكولات تقليدية', TRUE, TRUE),
  ('b7000000-0000-0000-0000-000000000003'::uuid, 'حراير - نسيج وتطريز', 'مجموعة تجريبية - نسيج وتطريز', TRUE, TRUE),
  ('b7000000-0000-0000-0000-000000000004'::uuid, 'حراير - أعشاب وزيوت', 'مجموعة تجريبية - أعشاب وزيوت', TRUE, TRUE),
  ('b7000000-0000-0000-0000-000000000005'::uuid, 'حراير - صناعات يدوية', 'مجموعة تجريبية - صناعات يدوية', TRUE, TRUE)
ON CONFLICT (id) DO NOTHING;

-- 4) 15 demo products, with placeholder URLs only. Keep existing images on rerun.
INSERT INTO public.products (
  id, name, description, price, sale_price, category_id, brand_id, stock,
  thumbnail, images, rating, reviews_count, is_featured, is_active
) VALUES
  ('a7000000-0000-0000-0000-000000000001'::uuid, 'عسل زعتر طبيعي - 250غ', 'منتج تجريبي لعرض واجهة حراير: عسل زعتر طبيعي - 250غ. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 48.00, NULL, 'c7000000-0000-0000-0000-000000000001'::uuid, 'b7000000-0000-0000-0000-000000000001'::uuid, 12, 'https://placehold.co/800x800/F6E8E2/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/F6E8E2/9F1833.png?text=7RAYER']::text[], 0, 0, TRUE, TRUE),
  ('a7000000-0000-0000-0000-000000000002'::uuid, 'عسل إكليل الجبل - 250غ', 'منتج تجريبي لعرض واجهة حراير: عسل إكليل الجبل - 250غ. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 42.00, NULL, 'c7000000-0000-0000-0000-000000000001'::uuid, 'b7000000-0000-0000-0000-000000000001'::uuid, 10, 'https://placehold.co/800x800/F6E8E2/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/F6E8E2/9F1833.png?text=7RAYER']::text[], 0, 0, FALSE, TRUE),
  ('a7000000-0000-0000-0000-000000000003'::uuid, 'شمع عسل طبيعي - 100غ', 'منتج تجريبي لعرض واجهة حراير: شمع عسل طبيعي - 100غ. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 14.00, NULL, 'c7000000-0000-0000-0000-000000000001'::uuid, 'b7000000-0000-0000-0000-000000000001'::uuid, 15, 'https://placehold.co/800x800/F6E8E2/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/F6E8E2/9F1833.png?text=7RAYER']::text[], 0, 0, FALSE, TRUE),
  ('a7000000-0000-0000-0000-000000000004'::uuid, 'بسيسة تونسية - 500غ', 'منتج تجريبي لعرض واجهة حراير: بسيسة تونسية - 500غ. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 18.00, NULL, 'c7000000-0000-0000-0000-000000000002'::uuid, 'b7000000-0000-0000-0000-000000000002'::uuid, 20, 'https://placehold.co/800x800/F8EDE4/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/F8EDE4/9F1833.png?text=7RAYER']::text[], 0, 0, TRUE, TRUE),
  ('a7000000-0000-0000-0000-000000000005'::uuid, 'كسكسي تقليدي - 1كغ', 'منتج تجريبي لعرض واجهة حراير: كسكسي تقليدي - 1كغ. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 16.00, NULL, 'c7000000-0000-0000-0000-000000000002'::uuid, 'b7000000-0000-0000-0000-000000000002'::uuid, 20, 'https://placehold.co/800x800/F8EDE4/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/F8EDE4/9F1833.png?text=7RAYER']::text[], 0, 0, FALSE, TRUE),
  ('a7000000-0000-0000-0000-000000000006'::uuid, 'مربى التين - 250غ', 'منتج تجريبي لعرض واجهة حراير: مربى التين - 250غ. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 12.00, NULL, 'c7000000-0000-0000-0000-000000000002'::uuid, 'b7000000-0000-0000-0000-000000000002'::uuid, 15, 'https://placehold.co/800x800/F8EDE4/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/F8EDE4/9F1833.png?text=7RAYER']::text[], 0, 0, FALSE, TRUE),
  ('a7000000-0000-0000-0000-000000000007'::uuid, 'حقيبة منسوجة يدوياً', 'منتج تجريبي لعرض واجهة حراير: حقيبة منسوجة يدوياً. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 65.00, NULL, 'c7000000-0000-0000-0000-000000000003'::uuid, 'b7000000-0000-0000-0000-000000000003'::uuid, 7, 'https://placehold.co/800x800/F5E3EB/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/F5E3EB/9F1833.png?text=7RAYER']::text[], 0, 0, TRUE, TRUE),
  ('a7000000-0000-0000-0000-000000000008'::uuid, 'وشاح صوفي تقليدي', 'منتج تجريبي لعرض واجهة حراير: وشاح صوفي تقليدي. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 45.00, NULL, 'c7000000-0000-0000-0000-000000000003'::uuid, 'b7000000-0000-0000-0000-000000000003'::uuid, 9, 'https://placehold.co/800x800/F5E3EB/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/F5E3EB/9F1833.png?text=7RAYER']::text[], 0, 0, FALSE, TRUE),
  ('a7000000-0000-0000-0000-000000000009'::uuid, 'مفرش مطرز يدوياً', 'منتج تجريبي لعرض واجهة حراير: مفرش مطرز يدوياً. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 85.00, NULL, 'c7000000-0000-0000-0000-000000000003'::uuid, 'b7000000-0000-0000-0000-000000000003'::uuid, 5, 'https://placehold.co/800x800/F5E3EB/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/F5E3EB/9F1833.png?text=7RAYER']::text[], 0, 0, FALSE, TRUE),
  ('a7000000-0000-0000-0000-000000000010'::uuid, 'زيت زيتون بكر - 500مل', 'منتج تجريبي لعرض واجهة حراير: زيت زيتون بكر - 500مل. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 36.00, NULL, 'c7000000-0000-0000-0000-000000000004'::uuid, 'b7000000-0000-0000-0000-000000000004'::uuid, 15, 'https://placehold.co/800x800/EDEBDA/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/EDEBDA/9F1833.png?text=7RAYER']::text[], 0, 0, TRUE, TRUE),
  ('a7000000-0000-0000-0000-000000000011'::uuid, 'أعشاب إكليل الجبل المجففة - 100غ', 'منتج تجريبي لعرض واجهة حراير: أعشاب إكليل الجبل المجففة - 100غ. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 11.00, NULL, 'c7000000-0000-0000-0000-000000000004'::uuid, 'b7000000-0000-0000-0000-000000000004'::uuid, 16, 'https://placehold.co/800x800/EDEBDA/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/EDEBDA/9F1833.png?text=7RAYER']::text[], 0, 0, FALSE, TRUE),
  ('a7000000-0000-0000-0000-000000000012'::uuid, 'ماء زهر طبيعي - 250مل', 'منتج تجريبي لعرض واجهة حراير: ماء زهر طبيعي - 250مل. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 16.00, NULL, 'c7000000-0000-0000-0000-000000000004'::uuid, 'b7000000-0000-0000-0000-000000000004'::uuid, 12, 'https://placehold.co/800x800/EDEBDA/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/EDEBDA/9F1833.png?text=7RAYER']::text[], 0, 0, FALSE, TRUE),
  ('a7000000-0000-0000-0000-000000000013'::uuid, 'طبق فخار تقليدي', 'منتج تجريبي لعرض واجهة حراير: طبق فخار تقليدي. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 28.00, NULL, 'c7000000-0000-0000-0000-000000000005'::uuid, 'b7000000-0000-0000-0000-000000000005'::uuid, 8, 'https://placehold.co/800x800/F6ECE0/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/F6ECE0/9F1833.png?text=7RAYER']::text[], 0, 0, TRUE, TRUE),
  ('a7000000-0000-0000-0000-000000000014'::uuid, 'سلة من الحلفاء', 'منتج تجريبي لعرض واجهة حراير: سلة من الحلفاء. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 38.00, NULL, 'c7000000-0000-0000-0000-000000000005'::uuid, 'b7000000-0000-0000-0000-000000000005'::uuid, 6, 'https://placehold.co/800x800/F6ECE0/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/F6ECE0/9F1833.png?text=7RAYER']::text[], 0, 0, FALSE, TRUE),
  ('a7000000-0000-0000-0000-000000000015'::uuid, 'قطعة خزف مزخرفة', 'منتج تجريبي لعرض واجهة حراير: قطعة خزف مزخرفة. السعر والكمية افتراضيان؛ يرجى استبدال المعلومات والصور ببيانات الحرفية الحقيقية قبل النشر.', 42.00, NULL, 'c7000000-0000-0000-0000-000000000005'::uuid, 'b7000000-0000-0000-0000-000000000005'::uuid, 5, 'https://placehold.co/800x800/F6ECE0/9F1833.png?text=7RAYER', ARRAY['https://placehold.co/800x800/F6ECE0/9F1833.png?text=7RAYER']::text[], 0, 0, FALSE, TRUE)
ON CONFLICT (id) DO NOTHING;

-- 5) Three neutral temporary banners (replace with your own graphics later).
INSERT INTO public.banners (id, image_url, title, subtitle, action_url, action_type, sort_order, is_active, start_date, end_date) VALUES
  ('ba700000-0000-0000-0000-000000000001'::uuid, 'https://placehold.co/1400x500/F8EDE4/9F1833.png?text=7RAYER', 'من أرضنا إلى دارك', 'اكتشف منتجات المرأة الريفية التونسية', '/category/c7000000-0000-0000-0000-000000000001', 'category', 1, TRUE, NOW(), NOW() + INTERVAL '365 days'),
  ('ba700000-0000-0000-0000-000000000002'::uuid, 'https://placehold.co/1400x500/F8EDE4/9F1833.png?text=7RAYER', 'خيرات الطبيعة', 'منتجات النحل والمأكولات التقليدية', '/category/c7000000-0000-0000-0000-000000000002', 'category', 2, TRUE, NOW(), NOW() + INTERVAL '365 days'),
  ('ba700000-0000-0000-0000-000000000003'::uuid, 'https://placehold.co/1400x500/F8EDE4/9F1833.png?text=7RAYER', 'حرف تحكي حكاية', 'نسيج وتطريز وصناعات يدوية', '/category/c7000000-0000-0000-0000-000000000003', 'category', 3, TRUE, NOW(), NOW() + INTERVAL '365 days')
ON CONFLICT (id) DO NOTHING;

COMMIT;

-- 6) Verification: the result should show 5 categories and 15 products.
SELECT '7rayer_categories' AS kind, COUNT(*) AS total FROM public.categories WHERE id BETWEEN
  'c7000000-0000-0000-0000-000000000001'::uuid AND 'c7000000-0000-0000-0000-000000000005'::uuid
UNION ALL
SELECT '7rayer_products' AS kind, COUNT(*) AS total FROM public.products WHERE id BETWEEN
  'a7000000-0000-0000-0000-000000000001'::uuid AND 'a7000000-0000-0000-0000-000000000015'::uuid;

-- View the demo products:
SELECT name, price, stock, thumbnail FROM public.products WHERE id BETWEEN
  'a7000000-0000-0000-0000-000000000001'::uuid AND 'a7000000-0000-0000-0000-000000000015'::uuid ORDER BY name;

-- Editing images later: change thumbnail and images manually in Supabase Table Editor.
-- The new demo image URLs currently point to generic placeholder illustrations, NOT actual products.
