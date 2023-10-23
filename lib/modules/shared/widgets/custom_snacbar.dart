import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idea/modules/shared/util/util.dart';

snackBar({
  required BuildContext context,
  required String message,
  required String title,
  required bool isError,
  double? width,
  double? height,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      elevation: 0,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(bottom: 50.0),
      content: Column(
        mainAxisSize: MainAxisSize.min, // needed for flexible height
        children: [
          Container(
            padding:
                EdgeInsets.only(bottom: 24.h, top: 6.h, left: 24.w, right: 4.w),
            alignment: Alignment.center,
            width: deviceWidth(context) * 0.8,
            height: height,
            // color: white,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: isError == true
                            ? Colors.red.shade300
                            : Colors.green.shade300,
                        width: 2.5))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    child: Icon(
                      Icons.clear,
                      size: 15.sp,
                    ),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: isError == true
                        ? Colors.red.shade300
                        : const Color(0xFF14142B),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 13.sp,
                         color: 
                         const Color(0xFF14142B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
