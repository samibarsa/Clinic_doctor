import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController searchController;

  const CustomSearchBar({super.key, required this.searchController});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final FocusNode _focusNode = FocusNode();
  bool isPanorama = false;
  bool isCephalometric = false;
  bool isCBCT = false;
  bool showDropdown = false;

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

  void _toggleDropdown() {
    setState(() {
      showDropdown = !showDropdown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: [
                TextField(
                  controller: widget.searchController,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: _toggleDropdown,
                      child: SvgPicture.asset(
                        ImagesPath.filter,
                        fit: BoxFit.none,
                      ),
                    ),
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
                if (showDropdown)
                  Positioned(
                    top: 50.h, // Adjust this value as needed
                    right: 0, // Align with the right edge of the screen
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 32.w,
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSwitchOption("بانوراما", isPanorama, (value) {
                              setState(() {
                                isPanorama = value;
                              });
                            }),
                            _buildSwitchOption("سيفالوماتريك", isCephalometric,
                                (value) {
                              setState(() {
                                isCephalometric = value;
                              });
                            }),
                            _buildSwitchOption("C.B.C.T", isCBCT, (value) {
                              setState(() {
                                isCBCT = value;
                              });
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchOption(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
