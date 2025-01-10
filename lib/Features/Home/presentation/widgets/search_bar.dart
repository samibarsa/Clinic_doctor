// ignore_for_file: avoid_print

import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController searchController;

  const CustomSearchBar({super.key, required this.searchController});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      print("Search bar unfocused");
    }
  }

  void _handleSearch(String query) {
    print("Search query submitted: $query");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w), // تقليل المسافة الأفقية
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 40.h, // تقليل ارتفاع الحاوية
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.r), // تقليل نصف القطر
          ),
          child: TextField(
            controller: widget.searchController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, size: 18.sp), // تقليل حجم الأيقونة
              hintText: "ابحث عن اسم المريض",
              hintStyle: TextStyle(fontSize: 12.sp), // تقليل حجم النص
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
                borderSide: const BorderSide(
                    color: Color(AppColor.primaryColor),
                    width: 1.5), // تقليل العرض
              ),
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: _handleSearch,
            style: TextStyle(fontSize: 12.sp), // تقليل حجم النص
          ),
        ),
      ),
    );
  }
}
