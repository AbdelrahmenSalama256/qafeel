import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qafeel/core/constants/app_colors.dart';

class AppDropdownField extends StatefulWidget {
  final String hint;
  final Map<String, Color>? colorMap;
  final String? value; // Single select
  final List<String>? selectedValues; // Multi-select
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final ValueChanged<List<String>>? onMultipleChanged;
  final FormFieldValidator<String>? validator;
  final bool showErrorBorder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? hintStyle;
  final TextStyle? selectedTextStyle;
  final bool enabled;
  final bool isMultiSelect;

  const AppDropdownField({
    super.key,
    required this.hint,
    this.value,
    this.colorMap,
    this.selectedValues,
    required this.items,
    required this.onChanged,
    this.onMultipleChanged,
    this.validator,
    this.showErrorBorder = false,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.hintStyle,
    this.selectedTextStyle,
    this.enabled = true,
    this.isMultiSelect = false,
  });

  @override
  State<AppDropdownField> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  late List<String> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = widget.selectedValues ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: widget.hint,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        filled: true,
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 7.h,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: Color(0xffEBEBEB),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Color(0xffEBEBEB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: Color(0xFFE53935),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(
            color: Color(0xFFE53935),
            width: 2,
          ),
        ),
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        alignLabelWithHint: true,
        labelStyle: widget.hintStyle ??
            TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
      ),
      isEmpty: widget.isMultiSelect
          ? _selectedValues.isEmpty
          : (widget.value?.isEmpty ?? true),
      child: widget.isMultiSelect
          ? _buildMultiSelectDropdown()
          : _buildSingleSelectDropdown(),
    );
  }

  Widget _buildSingleSelectDropdown() {
    final selectedColor = widget.colorMap != null && widget.value != null
        ? widget.colorMap![widget.value]
        : null;

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: widget.value,
        isExpanded: true,
        hint: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Text(widget.hint, style: widget.hintStyle),
        ),
        icon: Container(
          width: 20.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: selectedColor ?? Colors.transparent,
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: selectedColor == null
              ? Icon(
                  CupertinoIcons.chevron_down,
                  size: 20.sp,
                  color: AppColors.primary,
                )
              : null,
        ),
        onChanged: widget.enabled ? widget.onChanged : null,
        items: widget.items.map((item) {
          // final itemColor =
          //     widget.colorMap != null ? widget.colorMap![item] : null;
          return DropdownMenuItem<String>(
            value: item,
            child: Row(
              children: [
                Text(
                  item,
                  style: widget.selectedTextStyle ??
                      TextStyle(fontSize: 12.sp, color: AppColors.textPrimary),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMultiSelectDropdown() {
    return GestureDetector(
      onTap: widget.enabled ? () => _showMultiSelectMenu() : null,
      child: Wrap(
        spacing: 8.w,
        runSpacing: 4.h,
        children: _selectedValues.isEmpty
            ? [
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Text(
                    widget.hint,
                    style: widget.hintStyle ??
                        TextStyle(fontSize: 12.sp, color: Colors.grey.shade400),
                  ),
                ),
              ]
            : _selectedValues.map((value) {
                return Chip(
                  label: Text(value,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                  backgroundColor: AppColors.primary,
                  deleteIcon:
                      Icon(Icons.close, size: 16.w, color: Colors.white),
                  onDeleted: () {
                    setState(() {
                      _selectedValues.remove(value);
                      widget.onMultipleChanged?.call(_selectedValues);
                    });
                  },
                );
              }).toList(),
      ),
    );
  }

  void _showMultiSelectMenu() async {
    final List<String>? result = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        final tempValues = List<String>.from(_selectedValues);
        return AlertDialog(
          title: Text(widget.hint),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: widget.items.map((item) {
                return CheckboxListTile(
                  value: tempValues.contains(item),
                  title: Text(item),
                  activeColor: AppColors.primary,
                  onChanged: (selected) {
                    setState(() {
                      selected == true
                          ? tempValues.add(item)
                          : tempValues.remove(item);
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, tempValues),
              child: Text("تم", style: TextStyle(color: AppColors.primary)),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedValues = result;
      });
      widget.onMultipleChanged?.call(_selectedValues);
    }
  }
}
