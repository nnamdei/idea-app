import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  // final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final String? hintText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  // final bool? readOnly;
  final bool obscureText;
  final String? obscuringCharacter;

  // final String? labelText;
  final bool? enabled;
  final Function()? onTap;
  final String? initialVlaue;
  final List<TextInputFormatter>? inputFormmater;
  final AutovalidateMode? autovalidateMode;
  final BorderRadius? borderRadius;

  // ignore: use_key_in_widget_constructors
  const CustomTextField({
    // this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onSaved,
    this.hintText,
    this.textInputAction,
    this.textInputType,
    this.textAlign,
    this.onChanged,
    this.controller,
    // this.readOnly,
    this.obscureText = false,
    this.obscuringCharacter,
    // this.labelText,
    this.enabled = true,
    this.onTap,
    this.initialVlaue,
    this.inputFormmater,
    this.autovalidateMode,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialVlaue,
      onTap: onTap,
      // cursorColor: AppColors.color18.withOpacity(0.4),
      maxLines: 1,
      enabled: enabled,
      textInputAction: textInputAction,
      inputFormatters: inputFormmater,
      style: const TextStyle(
        // color: AppColors.color5,
        fontWeight: FontWeight.w500,
        fontSize: 15,
        letterSpacing: 0.4,
      ),
      // readOnly: readOnly!,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        counterText: '',
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.h,
          horizontal: 15.w,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          // fontFamily: Strings.poppins,
          color: Color(0xffC8D1E1),
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),

        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffC8D1E1), width: 1),
          borderRadius: borderRadius ?? BorderRadius.circular(7.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: borderRadius ?? BorderRadius.circular(7.r),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderSide:
        //       const BorderSide(color: AppColors.color6, width: 0.5),
        //   borderRadius: BorderRadius.circular(4.h),
        // ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffC8D1E1),
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(7.r),
        ),
      ),
      obscureText: obscureText,
      // obscuringCharacter: '*',
      controller: controller,
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: textInputType,
      onFieldSubmitted: onSaved,
      onSaved: onSaved,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
