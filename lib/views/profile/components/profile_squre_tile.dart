import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/constants.dart';

class ProfileSqureTile extends StatelessWidget {
  const ProfileSqureTile({
    super.key,
    // required this.label,
    required this.icon,
    required this.onTap,
  });

  // final String label;
  final String icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDefaults.borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(AppDefaults.padding),
          child: Column(
            children: [
              SvgPicture.asset(icon),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
