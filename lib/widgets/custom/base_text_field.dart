import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_app/utils/extensions.dart';
import 'package:task_manager_app/widgets/custom/app_widgets.dart';

import '../theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.maxLines = 1,
    this.enabled = true,
    this.obscureText = false,
    this.isTitleRequired = true,
    this.hasRightBorderRadius = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
    this.title,
    required this.hintText,
    required this.controller,
    // TODO make these two required later
    // this.onChanged,
    this.validator,
    this.prefix,
    this.suffix,
    this.titleStyle,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
  });

  final bool enabled;
  final bool obscureText;
  final bool isTitleRequired;
  final bool hasRightBorderRadius;
  final int? maxLines, maxLength;
  final String? title;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  // final void Function(String?)? onChanged;
  final TextStyle? titleStyle;
  final List<FilteringTextInputFormatter>? inputFormatters;

  final Widget? prefix;
  final Widget? suffix;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );

    final borderRadius = BorderRadius.only(
      topRight: Radius.zero,
      bottomRight: Radius.zero,
      topLeft: Radius.circular(AppWidgets.halfBorderRadiusValue),
      bottomLeft: Radius.circular(AppWidgets.halfBorderRadiusValue),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          CustomFieldTitleWidget(
            title: widget.title!,
            isTitleRequired: widget.isTitleRequired,
          ),
        if (widget.title != null) SizedBox(height: 8.h),
        TextFormField(
          enabled: widget.enabled,
          obscureText: _obscureText,
          onChanged: widget.onChanged,
          maxLength: widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: context.textTheme.bodyLarge!.copyWith(
            color: AppColors.textColorLight,
          ),
          decoration: InputDecoration(
            counterText: '',
            labelStyle: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onTertiary,
            ),
            hintStyle: textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onTertiary,
            ),
            hintText: widget.hintText,
            suffixIcon: widget.obscureText
                // TODO color here not working for dark mode
                ? Padding(
                    padding: EdgeInsets.all(16.r),
                    child: IconButton(
                      onPressed: _onPressed,
                      icon: Icon(_obscureText
                          ? Icons.remove_red_eye
                          : Icons.panorama_fish_eye),
                    ),
                  )
                : widget.suffix,
            prefixIcon: widget.prefix,
            suffixIconColor: Colors.green,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 20.h,
            ),
            errorStyle: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onError,
            ),
            errorBorder: inputBorder.copyWith(
              borderSide: const BorderSide(color: AppColors.errorColor),
              borderRadius: widget.hasRightBorderRadius ? borderRadius : null,
            ),
            focusedBorder: inputBorder.copyWith(
              borderSide: const BorderSide(
                color: AppColors.inputFieldFocusedBorderLight,
              ),
              borderRadius: widget.hasRightBorderRadius ? borderRadius : null,
            ),
            focusedErrorBorder: inputBorder.copyWith(
              borderSide: const BorderSide(color: AppColors.errorColor),
              borderRadius: widget.hasRightBorderRadius ? borderRadius : null,
            ),
            enabledBorder: inputBorder.copyWith(
              borderSide:
                  const BorderSide(color: AppColors.placeHolderColorLight),
              borderRadius: widget.hasRightBorderRadius ? borderRadius : null,
            ),
            border: inputBorder.copyWith(
              borderSide: const BorderSide(
                color: AppColors.placeHolderColorLight,
              ),
              borderRadius: widget.hasRightBorderRadius ? borderRadius : null,
            ),
          ),
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines,
          validator: widget.validator,
          textCapitalization: widget.textCapitalization,
          inputFormatters: widget.inputFormatters,
        ),
      ],
    );
  }

  void _onPressed() => setState(() => _obscureText = !_obscureText);
}

class CustomFieldTitleWidget extends StatelessWidget {
  const CustomFieldTitleWidget({
    super.key,
    this.isTitleRequired = true,
    required this.title,
  });

  final bool isTitleRequired;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isTitleRequired) ...[
          SizedBox(width: 2.h),
          Text(
            '*',
            style: context.textTheme.bodyLarge?.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ],
    );
  }
}
