import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlateOtpInput extends StatelessWidget {
  final int length;
  final int maxLength;
  final List<String> values;
  final Function(int index, String value) onChanged;
  final Function(int index) onRemove;
  final Function()? onAddPressed;
  final bool showAddButton;

  const PlateOtpInput({
    super.key,
    required this.length,
    required this.maxLength,
    required this.values,
    required this.onChanged,
    required this.onRemove,
    this.onAddPressed,
    this.showAddButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center the inputs
      children: [
        if (showAddButton)
          GestureDetector(
            onTap: onAddPressed,
            child: Container(
              width: 40.w,
              height: 40.h,
              margin: EdgeInsets.only(left: 4.w), // Consistent spacing
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Color(0xFFE5E7EB)), // Lighter border
              ),
              child: Icon(
                Icons.add,
                color: Color(0xFF6B46C1), // Purple add icon
                size: 20.sp,
              ),
            ),
          ),
        ...List.generate(length, (index) {
          return _buildOtpBox(context, index, "");
        }).reversed,
      ],
    );
  }

  Widget _buildOtpBox(BuildContext context, int index, String value) {
    final bool hasValue = value.isNotEmpty;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w), // Symmetric spacing
      width: 40.w,
      height: 40.h,
      child: TextFormField(
        key: ValueKey('${index}_$value'),
        initialValue: value,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        maxLength: 1,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: hasValue
              ? Colors.white
              : Color(0xFF9CA3AF), // Gray placeholder text
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide:
                BorderSide(color: Color(0xFFE5E7EB)), // Light gray border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
                color: Color(0xFF6B46C1), width: 2), // Purple focus border
          ),
          filled: true,
          fillColor: hasValue
              ? Color(0xFF6B46C1)
              : Colors.white, // Clean white background when empty
        ),
        onChanged: (text) {
          if (text.isNotEmpty) {
            onChanged(index, text);
            if (index < length - 1) {
              FocusScope.of(context).nextFocus();
            }
          } else {
            onRemove(index);
          }
        },
        inputFormatters: [
          FilteringTextInputFormatter.allow(
              RegExp(r'[a-zA-Z0-9\u0600-\u06FF]')), // Allow Arabic characters
        ],
      ),
    );
  }
}
