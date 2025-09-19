// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';
import 'package:vision_app/core/utils/constants/sizes/sizes.dart';

class VisionTextForm extends StatefulWidget {
  final void Function(String?)? onSaved;
  final TextAlign? textAlign;
  final InputDecoration? decoration;
  final bool? isCard;
  final String? counterText;
  final String? hintText;
  final String? helperText;
  final String? Function(String?)? validator;
  final bool? enabled;
  final int? maxLength;
  final String label;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? errorText;
  final String? initialValue;
  final bool readOnly;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final MouseCursor? mouseCursor;
  final BoxConstraints? constraints;
  final bool expands;
  final bool isGhost;
  final int? maxLines;
  final int? minLines;
  final Widget? suffix;
  final Color? suffixColor;
  final TextStyle? hintTextStyle;
  final void Function()? onEditingComplete;
  final FocusNode? focus;
  final FocusNode? nextFocus;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool isRequired;
  final Iterable<String>? autofillHints;
  bool isPassword;

  VisionTextForm({
    super.key,
    this.onSaved,
    this.textAlign,
    this.decoration,
    this.isCard = false,
    this.isGhost = false,
    this.counterText,
    this.hintText,
    this.hintTextStyle,
    this.helperText,
    this.validator,
    this.enabled = true,
    this.maxLength,
    required this.label,
    this.inputFormatters,
    this.controller,
    this.errorText,
    this.initialValue,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.prefixIcon,
    this.mouseCursor,
    this.constraints,
    this.expands = false,
    this.maxLines = 1,
    this.minLines,
    this.suffix,
    this.suffixColor,
    this.onEditingComplete,
    this.focus,
    this.nextFocus,
    this.autovalidateMode,
    this.onSubmitted,
    this.textInputAction = TextInputAction.next,
    this.keyboardType,
    this.isRequired = true,
    this.autofillHints,
    this.isPassword = false,
  });

  @override
  State<VisionTextForm> createState() => _VisionTextFormState();
}

class _VisionTextFormState extends State<VisionTextForm> {
  late bool _isPassword;

  @override
  void initState() {
    super.initState();
    _isPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration? modifiedDecoration = widget.decoration;
    return TextFormField(
      autofillHints: widget.autofillHints,

      cursorColor: VisionColors.onBackground,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: widget.keyboardType,

      textAlign: widget.textAlign ?? TextAlign.start,
      autovalidateMode: widget.autovalidateMode,
      focusNode: widget.focus,
      enabled: widget.enabled,
      textInputAction: widget.textInputAction,
      onFieldSubmitted:
          widget.onSubmitted ??
          (value) {
            if (widget.textInputAction == TextInputAction.next) {
              FocusScope.of(context).requestFocus(widget.nextFocus);
            } else {
              widget.focus!.unfocus();
            }
          },
      onEditingComplete:
          widget.onEditingComplete ??
          () {
            if (widget.textInputAction == TextInputAction.next) {
              FocusScope.of(context).requestFocus(widget.nextFocus);
            } else {
              widget.focus!.unfocus();
            }
          },

      onSaved: widget.onSaved,
      validator: widget.validator,
      mouseCursor: widget.mouseCursor,
      onTap: widget.onTap,
      maxLength: widget.maxLength,
      obscureText: _isPassword,
      onChanged: widget.onChanged,
      controller: widget.controller,
      readOnly: widget.readOnly,
      initialValue: widget.initialValue,
      inputFormatters: widget.inputFormatters,
      expands: widget.expands,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      style: TextStyle(
        color: VisionColors.onBackground,
        fontSize: VisionSizes.mediumM16,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: VisionSizes.mediumM14 * 0.005,
      ),

      decoration:
          modifiedDecoration ??
          InputDecoration(
            contentPadding: const EdgeInsets.only(
              top: 30,
              left: 10,
              right: 10,
              bottom: 10,
            ),
            isDense: true,
            labelStyle: widget.readOnly
                ? const TextStyle(fontWeight: FontWeight.bold)
                : null,
            counterText: widget.counterText,

            hintText: widget.label,
            hintStyle:
                widget.hintTextStyle ??
                TextStyle(
                  color: VisionColors.onSecondary,
                  fontSize: VisionSizes.mediumM14,
                  fontWeight: FontWeight.w400,
                  height: 1,
                  letterSpacing: VisionSizes.mediumM14 * 0.005,
                ),

            suffixIcon: widget.isPassword
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _isPassword = !_isPassword;
                      });
                    },
                    child: Icon(
                      _isPassword ? Icons.visibility : Icons.visibility_off,
                      color: VisionColors.onSecondary,
                    ),
                  )
                : widget.suffix,
            suffixIconColor: widget.suffixColor,

            constraints: widget.constraints,
            prefixIcon: widget.prefixIcon,
            errorText: widget.errorText != null ? '' : null,
          ).copyWith(
            border: modifiedDecoration?.border,
            enabledBorder: modifiedDecoration?.enabledBorder,
            disabledBorder: modifiedDecoration?.disabledBorder,
            focusedBorder: modifiedDecoration?.focusedBorder,
            errorBorder: modifiedDecoration?.errorBorder,
            focusedErrorBorder: modifiedDecoration?.focusedErrorBorder,
            hintText: modifiedDecoration?.hintText,
            labelText: modifiedDecoration?.labelText,
            errorText: modifiedDecoration?.errorText,
            suffixIconColor: modifiedDecoration?.suffixIconColor,
            prefixIcon: modifiedDecoration?.prefixIcon,
          ),
    );
  }
}
