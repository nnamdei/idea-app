import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomButton extends StatelessWidget {
  // final Widget? icon;
  final String? title;
  final Function()? onPress;
  final Color? color;
  final Color? txtColor;
  final double? width;
  final double? height;
  final bool? hasElevation;
  final double? txtSize;
  final bool isActive;

  const CustomButton(
      {Key? key,
      // this.icon,
      required this.title,
      required this.onPress,
      this.color,
      this.txtColor,
      this.txtSize,
      this.width,
      this.height,
      this.isActive = false,
      this.hasElevation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      width: width ?? 321.w, //double.infinity,
      height: height ?? 56.h,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(6)),
            backgroundColor: MaterialStateProperty.all<Color>(
                //widget.color ?? Color(0xffF2902F)
                isActive
                    ? Colors.black
                    : const Color(0xffC8D1E1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              // side: BorderSide(color: Colors.red)
            ))),
        child: Text(
          title ?? '',
          style: const TextStyle(
              // fontFamily: Strings.ibmPlexSans,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
