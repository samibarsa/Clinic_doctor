// ignore_for_file: use_build_context_synchronously

import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({
    super.key,
    required this.errMessage,
  });
  final String errMessage;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('خطأ'),
      content: SizedBox(
        height: 150.h,
        child: Column(
          children: [
            errMessage == 'لا يوجد اتصال بالإنترنت.'
                ? Image.asset(ImagesPath.offlineIcom)
                : const SizedBox(),
            SizedBox(
              height: 20.h,
            ),
            Text(errMessage),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('حسناً'),
        ),
      ],
    );
  }
}
