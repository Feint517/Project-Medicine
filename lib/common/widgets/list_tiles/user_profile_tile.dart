import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_med/utils/constants/colors.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          const Icon(Icons.arrow_back), //! this will be the image of the user
      title: Text(
        "User name",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        "test@gmail.com",
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.edit),
          color: TColors.white),
    );
  }
}
