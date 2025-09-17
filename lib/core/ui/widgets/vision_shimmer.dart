import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';
import 'package:vision_app/core/utils/sizes/sizes.dart';

class VisionShimmer extends StatelessWidget {
  final Widget? child;

  final Color baseColor;

  final double height;

  final double width;

  const VisionShimmer({
    this.child,
    this.baseColor = Colors.white10,
    this.height = VisionSizes.largeL30,
    this.width = VisionSizes.extraL100,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: baseColor.withValues(alpha: .6),
      child: child != null
          ? child!
          : _RoundedContainer(
              color: VisionColors.onBackground,
              height: height,
              width: width,
              child: child,
            ),
    );
  }
}

class _RoundedContainer extends StatelessWidget {
  final Widget? child;

  final double? width;

  final double? height;

  final Color color;

  const _RoundedContainer({
    this.child,
    this.width,
    this.height,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(VisionSizes.mediumM16),
        ),
      ),
      child: child,
    );
  }
}
