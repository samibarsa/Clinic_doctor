import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:doctor_app/core/utils/constant.dart';

class InactiveAccountDialog extends StatelessWidget {
  final String email;

  const InactiveAccountDialog({Key? key, required this.email})
      : super(key: key);

  void _launchWhatsApp() async {
    final whatsappUrl = Uri.parse('https://wa.me/963937262829');
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
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Colors.white,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
                size: 64,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'الحساب غير نشط',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'عذرًا، حسابك غير نشط حاليًا. يرجى التواصل مع إدارة المركز لتفعيل الحساب.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      email,
                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
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
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: _launchWhatsApp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(AppColor.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.chat, color: Colors.white),
                label: const Text(
                  'تواصل مع الإدارة',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
