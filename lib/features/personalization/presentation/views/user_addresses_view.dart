import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/view_models/app_bar_view_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/personalization/presentation/views/add_new_addresses_view.dart';

class UserAddressesView extends StatelessWidget {
  const UserAddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarModel: AppBarModel(
          hasArrowBack: true,
          title: const Text("عناويني"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () {
          THelperFunctions.navigateToScreen(
            context,
            const AddNewAddressesView(),
          );
        },
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_off_outlined, size: 48),
              SizedBox(height: TSizes.spaceBtwItems),
              Text("لا توجد عناوين محفوظة بعد"),
            ],
          ),
        ),
      ),
    );
  }
}
