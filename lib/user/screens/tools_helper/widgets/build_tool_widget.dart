import 'package:expenses/general/constants/MyColors.dart';
import 'package:expenses/general/packages/localization/Localizations.dart';
import 'package:expenses/general/widgets/MyText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildToolsWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon; // Add this line
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const BuildToolsWidget({
    required this.onTap,
    required this.title,
    required this.icon, // Add this line
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(icon, color: MyColors.primary),
          ),
          const SizedBox(width: 10),
          MyText(
            title: tr(context, title),
            color: MyColors.primary,
            size: 15.sp,
            fontWeight: FontWeight.bold,
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: Colors.yellow,
            ),
            onPressed: onFavoriteTap,
          ),
        ],
      ),
    );
  }
}
