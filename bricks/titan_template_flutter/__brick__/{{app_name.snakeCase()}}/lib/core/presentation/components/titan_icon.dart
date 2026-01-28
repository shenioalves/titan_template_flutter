import 'package:flutter/material.dart';

import '../../utils/responsive_utils.dart';

class TitanIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  const TitanIcon({super.key, required this.icon, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtils responsiveUtils = ResponsiveUtils();
    return Icon(
      icon,
      size: (size ?? 24) * responsiveUtils.getImageScale(context),
      color: color,
    );
  }
}
