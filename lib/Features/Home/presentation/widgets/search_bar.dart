import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController searchController;

  const CustomSearchBar({super.key, required this.searchController});

  @override
  // ignore: library_private_types_in_public_api
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
      // Logic to handle unfocus event, for example, you can clear the search field or perform a search
      print("Search bar unfocused");
    }
  }

  void _handleSearch(String query) {
    // Logic to handle search, for example, filter the list based on the query
    print("Search query submitted: $query");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: widget.searchController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "ابحث عن اسم المريض",
            filled: true,
            fillColor: const Color(0xffF6F7F7),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              borderSide: const BorderSide(
                  color: Color(AppColor.primaryColor), width: 2.0),
            ),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: _handleSearch,
        ),
      ),
    );
  }
}
