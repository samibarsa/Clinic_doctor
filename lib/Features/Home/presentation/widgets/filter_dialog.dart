import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterDialog extends StatefulWidget {
  final bool isPanorama;
  final bool isCephalometric;
  final bool isCBCT;
  final Function(bool, bool, bool) onFilterChanged;

  const FilterDialog({
    super.key,
    required this.isPanorama,
    required this.isCephalometric,
    required this.isCBCT,
    required this.onFilterChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _FilterDialogState createState() => _FilterDialogState();
}

bool noDate = false;

class _FilterDialogState extends State<FilterDialog> {
  late bool isPanorama;
  late bool isCephalometric;
  late bool isCBCT;

  @override
  void initState() {
    super.initState();
    isPanorama = widget.isPanorama;
    isCephalometric = widget.isCephalometric;
    isCBCT = widget.isCBCT;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 8,
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildSwitchOption("بانوراما", isPanorama, (value) {
              setState(() {
                isPanorama = value;
              });
            }),
            buildSwitchOption("سيفالوماتريك", isCephalometric, (value) {
              setState(() {
                isCephalometric = value;
              });
            }),
            buildSwitchOption("C.B.C.T", isCBCT, (value) {
              setState(() {
                isCBCT = value;
              });
            }),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                widget.onFilterChanged(isPanorama, isCephalometric, isCBCT);
                Navigator.of(context).pop();
              },
              child: const Text('تطبيق'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSwitchOption(
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
