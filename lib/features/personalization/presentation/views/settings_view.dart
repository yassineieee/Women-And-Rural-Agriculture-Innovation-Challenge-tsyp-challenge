import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/widgets/primary_header_container.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/personalization/presentation/view_models/settings_menu_tile_model.dart';
import 'package:t_store/features/personalization/presentation/views/user_addresses_view.dart';
import 'package:t_store/features/personalization/presentation/widgets/account_settings_section.dart';
import 'package:t_store/features/personalization/presentation/widgets/app_settings_section.dart';
import 'package:t_store/features/personalization/presentation/widgets/settings_view_header_section.dart';
import 'package:t_store/features/shop/presentation/views/orders_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SettingsMenuTileModel> appSettingsTiles = [
      SettingsMenuTileModel(
        onTap: () {},
        title: "رفع البيانات",
        subtitle: "رفع بياناتك إلى الخادم",
        leading: Iconsax.document_upload,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "الموقع الجغرافي",
        subtitle: "اقتراح منتجات حسب موقعك",
        leading: Iconsax.document_download,
        trailing: Switch(
          value: true,
          onChanged: (value) {},
        ),
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "الوضع الآمن",
        subtitle: "نتائج بحث مناسبة لجميع الأعمار",
        leading: Iconsax.security_user,
        trailing: Switch(
          value: false,
          onChanged: (value) {},
        ),
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "جودة الصور",
        subtitle: "عرض الصور بجودة عالية",
        leading: Iconsax.image,
        trailing: Switch(
          value: true,
          onChanged: (value) {},
        ),
      ),
    ];
    final List<SettingsMenuTileModel> accountSettingsTiles = [
      SettingsMenuTileModel(
        onTap: () {
          //navigateToScreen UserAddressesView
          THelperFunctions.navigateToScreen(context, const UserAddressesView());
        },
        title: "عناويني",
        subtitle: "إدارة عناوين توصيل الطلبات",
        leading: Iconsax.safe_home,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "سلة مشترياتي",
        subtitle: "إضافة المنتجات أو حذفها ومراجعة السلة",
        leading: Iconsax.shopping_cart,
      ),
      SettingsMenuTileModel(
        onTap: () {
          //navigateToScreen UserAddressesView
          THelperFunctions.navigateToScreen(context, const OrdersView());
        },
        title: "طلباتي",
        subtitle: "الطلبات الجارية والمكتملة",
        leading: Iconsax.bag,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "الحساب البنكي",
        subtitle: "إدارة معلومات الحساب البنكي",
        leading: Iconsax.bank,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "قسائم التخفيض",
        subtitle: "عرض قسائم التخفيض المتاحة",
        leading: Iconsax.discount_shape,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "الإشعارات",
        subtitle: "إدارة الإشعارات والتنبيهات",
        leading: Iconsax.notification,
      ),
      SettingsMenuTileModel(
        onTap: () {},
        title: "خصوصية الحساب",
        subtitle: "إدارة الخصوصية والحسابات المرتبطة",
        leading: Iconsax.security_card,
      ),
    ];
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const PrimaryHeaderContainer(child: SettingsViewHeaderSection()),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  AccountSettingsSection(
                      accountSettingsTiles: accountSettingsTiles),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  AppSettingsSection(appSettingsTiles: appSettingsTiles),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
