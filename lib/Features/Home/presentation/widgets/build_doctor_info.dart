import 'package:doctor_app/Features/Auth/data/repo/auth_repository_impl.dart';
import 'package:doctor_app/Features/Auth/domain/usecase/usecacses.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Widget buildDoctorInfo(BuildContext context, OrderState state) {
  if (state is OrderLoading) {
    // إذا كانت البيانات لا تزال في حالة تحميل، عرض CircularProgressIndicator
    return Row(
      children: [
        SvgPicture.asset(ImagesPath.doctor),
        SizedBox(width: 8.w),
        const CircularProgressIndicator(), // عرض المؤشر أثناء تحميل الاسم
      ],
    );
  } else if (state is OrderLoaded) {
    // إذا كانت البيانات قد تم تحميلها بنجاح، عرض اسم الطبيب
    return GestureDetector(
      onTap: () {
        // عند النقر، عرض Bottom Sheet
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(1),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SvgPicture.asset(ImagesPath.wellcome),
                  Padding(
                    padding: EdgeInsets.only(bottom: 79.w),
                    child: CustomButton(
                        title: "تسجيل خروج",
                        color: AppColor.primaryColor,
                        onTap: () async {
                          await SignOutUseCase(
                                  AuthRepositoryImpl(Supabase.instance.client))
                              .repository
                              .signOut();

                          final prefs = await SharedPreferences.getInstance();
                          await prefs.clear();
                          Navigator.pushNamedAndRemoveUntil(
                              // ignore: use_build_context_synchronously
                              context,
                              '/',
                              (_) => false);
                        },
                        titleColor: Colors.white),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Row(
        children: [
          SvgPicture.asset(ImagesPath.doctor),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "أهلاً وسهلاً!",
                style:
                    TextStyle(fontSize: 12.sp, color: const Color(0xff6A6A6A)),
              ),
              Text(
                state.doctor.name, // عرض اسم الطبيب
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  } else {
    return const Text("حدث خطأ في تحميل البيانات");
  }
}
