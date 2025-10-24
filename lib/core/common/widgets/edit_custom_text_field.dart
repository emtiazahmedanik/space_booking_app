import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditCustomTextField extends StatelessWidget {
  final String lebelText;
  final String hintText;
  final bool obscureText;
  final int? maxLine;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextEditingController controller;

  const EditCustomTextField({
    required this.controller,
    required this.lebelText,
    this.suffixIcon,
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(lebelText, style: TextStyle()),

          Container(
            margin: EdgeInsets.symmetric(vertical: 6.h),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12.r),

              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    obscureText: obscureText,
                    // maxLines: maxLine,
                    maxLines: obscureText ? 1 : null,
                    validator: validator,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
                if (suffixIcon != null) suffixIcon!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
