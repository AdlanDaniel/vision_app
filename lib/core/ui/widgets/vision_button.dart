// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';
import 'package:vision_app/core/utils/sizes/sizes.dart';


class VisionButton extends StatefulWidget {
  String textButton;
  void Function()? onPressed;
  bool isLoading;
  bool isEnable;
  EdgeInsetsGeometry? padding;
  double? width;
  double? height;

  VisionButton({
    super.key,
   required  this.textButton,
    this.onPressed,
    this.isLoading = false,
    this.isEnable = true,
    this.padding,
    this.width,
    this.height,
  });

  @override
  State<VisionButton> createState() => _VisionButtonState();
}

class _VisionButtonState extends State<VisionButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: widget.width ?? VisionSizes.extraL208,
      height: widget.height ?? VisionSizes.largeL42,

      child: ElevatedButton(
        onPressed: widget.isEnable ? widget.onPressed : null,
        style: ButtonStyle(
          side: WidgetStatePropertyAll(
            BorderSide(color: VisionColors.onPrimary, width: 1.2),
          ),
        ),

        child: Text(
          widget.textButton,
          style: TextStyle(
            color: VisionColors.onPrimary,
            fontSize: VisionSizes.mediumM14,
            fontWeight: FontWeight.w600,
            letterSpacing: VisionSizes.mediumM14 * 0.02,
            height: 1,
          ),
        ),
      ),
    );
  }
}
