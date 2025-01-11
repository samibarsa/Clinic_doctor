import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InactiveAccountDialog extends StatelessWidget {
  final String email;

  const InactiveAccountDialog({Key? key, required this.email})
      : super(key: key);

  void _launchWhatsApp() async {
    final whatsappUrl = Uri.parse('https://wa.me/0943818201');
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'تعذر فتح واتساب. تأكد من تثبيت التطبيق.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: Colors.white,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(12.w),
              child: Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
                size: 64.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'الحساب غير نشط',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'عذرًا، حسابك غير نشط حاليًا. يرجى التواصل مع إدارة المركز لتفعيل الحساب.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: Colors.grey[600], size: 20.sp),
                  SizedBox(width: 8.w),
                  Flexible(
                    child: Text(
                      email,
                      style:
                          TextStyle(fontSize: 14.sp, color: Colors.grey[800]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: _launchWhatsApp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(AppColor.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                ),
                icon: Icon(Icons.chat, color: Colors.white, size: 18.sp),
                label: Text(
                  'تواصل مع الإدارة',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
