import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/view_models/app_bar_view_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/personalization/presentation/view_models/profile_entity_tile_model.dart';
import 'package:t_store/features/personalization/presentation/widgets/personal_information_section.dart';
import 'package:t_store/features/personalization/presentation/widgets/profile_information_section.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final email = user?.email ?? "غير متوفر";
    final userId = user?.id ?? "غير متوفر";
    final phone = user?.phone;
    final displayedPhone = (phone == null || phone.isEmpty)
        ? "غير محدد"
        : phone;

    final List<ProfileEntityTileModel> profileInformation = [
      ProfileEntityTileModel(
        title: "الاسم",
        value: email == "غير متوفر" ? "مستخدم" : email.split("@").first,
        onTap: () {},
      ),
      ProfileEntityTileModel(
        title: "اسم المستخدم",
        value: email == "غير متوفر" ? "غير محدد" : email.split("@").first,
      ),
    ];
    final List<ProfileEntityTileModel> personalInformation = [
      ProfileEntityTileModel(
        trailing: Iconsax.copy,
        title: "معرّف المستخدم",
        value: userId,
        onTap: () {},
      ),
      ProfileEntityTileModel(title: "البريد الإلكتروني", value: email),
      ProfileEntityTileModel(title: "رقم الهاتف", value: displayedPhone),
      const ProfileEntityTileModel(title: "الجنس", value: "غير محدد"),
      const ProfileEntityTileModel(title: "تاريخ الميلاد", value: "غير محدد"),
    ];
    return Scaffold(
      appBar: CustomAppBar(
        appBarModel: AppBarModel(
          title: const Text("الملف الشخصي"),
          hasArrowBack: true,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                ProfileInformationSection(
                  profileInformation: profileInformation,
                ),
                const SpaceBetweenSectionsWithDivider(),
                PersonalInformationSection(
                  personalInformation: personalInformation,
                ),
                const SpaceBetweenSectionsWithDivider(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "حذف الحساب",
                    style: TextStyle(color: TColors.error),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 1.5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpaceBetweenSectionsWithDivider extends StatelessWidget {
  const SpaceBetweenSectionsWithDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: TSizes.spaceBtwItems / 1.5),
        Divider(),
        SizedBox(height: TSizes.spaceBtwItems / 1.5),
      ],
    );
  }
}
