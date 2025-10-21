import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
   CustomTextField({
    super.key,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.borderColor,
    this.hintColor,
    this.label,
    this.maxLines = 1,
    this.controller,
    this.isPassword = false,
    this.onChanged
  });

  final String? hintText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Color? borderColor;
  final Color? hintColor;
  final String? label;
  final int? maxLines;
  final TextEditingController? controller;
  final bool isPassword;
  void Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isPassword = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
        TextFormField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          validator: widget.validator,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).hoverColor,
          ),
          obscureText: isPassword,
          decoration: InputDecoration(
            border: _getBorder(
              widget.borderColor ?? Theme.of(context).hintColor,
            ),
            focusedBorder: _getBorder(
              widget.borderColor ?? Theme.of(context).hintColor,
            ),
            enabledBorder: _getBorder(
              widget.borderColor ?? Theme.of(context).hintColor,
            ),
            errorBorder: _getBorder(AppColors.errorColor),
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: widget.hintColor ?? Theme.of(context).hoverColor,
            ),
            prefixIcon:
                widget.prefixIcon == null
                    ? null
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: widget.prefixIcon,
                    ),
            suffixIcon:
                widget.isPassword
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      icon: Icon(
                        isPassword
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                      ),
                    )
                    : null,
          ),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }

  _getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }
}
