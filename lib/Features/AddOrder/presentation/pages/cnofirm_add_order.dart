import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/AddOrder/addorder_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/widgets/section_title.dart';
import 'package:doctor_app/Features/Home/presentation/view/homePageViewWidget.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ConfirmAddOrder extends StatelessWidget {
  const ConfirmAddOrder(
      {super.key,
      required this.appBarTitle,
      required this.value1,
      required this.value2,
      required this.value3,
      required this.value4,
      required this.onTap,
      required this.patientId});
  final String appBarTitle;
  final String value1;
  final String value2;
  final String value3;
  final String value4;
  final int patientId;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    var title1 = "الجزء المراد تصويره:";
    var title2 = "وضعية الصورة";
    var title3 = "";
    var title4 = "";
    if (appBarTitle == "صورة ماجيك بانوراما") {
      title1 = "الجزء المراد تصويره:";
      title2 = "شكل الصورة:";
      title3 = "الفاتورة :";
    } else if (appBarTitle == "صورة سيفالومتريك") {
      title1 = "الجزء المراد تصويره:";

      title2 = "شكل الصورة:";

      title3 = "شكل الصورة:";

      title4 = ":الفاتورة";
    } else if (appBarTitle == "صورة تصوير مقطعيC.B.C.T") {
      title1 = "الجزء المراد تصويره:";
      title2 = "وضعية الصورة";
      title3 = "شكل الصورة:";
      title4 = "الفاتورة :";
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AddOrderCubit, AddorderState>(
        listener: (BuildContext context, AddorderState state) {
          if (state is AddorderFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const HomePageViewWidget()), // الصفحة الجديدة
              (Route<dynamic> route) =>
                  false, // شرط الإزالة: إزالة جميع الصفحات
            );
          } else if (state is AddorderSucses) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const HomePageViewWidget()), // الصفحة الجديدة
              (Route<dynamic> route) =>
                  false, // شرط الإزالة: إزالة جميع الصفحات
            );
          }
        },
        builder: (context, state) {
          if (state is AddorderLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AddorderFailure) {
            return Center(
              child: Text(state.errMessage),
            );
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(appBarTitle),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 34.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(
                        title: title1,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InfoBeforDone(value: value1),
                      SizedBox(
                        height: 36.h,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(
                        title: title2,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InfoBeforDone(value: value2),
                      SizedBox(
                        height: 36.h,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(
                        title: title3,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InfoBeforDone(value: value3),
                      SizedBox(
                        height: 36.h,
                      )
                    ],
                  ),
                  appBarTitle != "صورة ماجيك بانوراما"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionTitle(
                              title: title4,
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            InfoBeforDone(value: value4),
                            SizedBox(
                              height: 36.h,
                            )
                          ],
                        )
                      : const SizedBox(),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.r)),
                        border: Border.all(
                            color: const Color(AppColor.primaryColor))),
                    child: CustomButton(
                      title: "تأكيد",
                      color: 0xffFFFF,
                      onTap: onTap,
                      titleColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 146.h,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class InfoBeforDone extends StatelessWidget {
  const InfoBeforDone({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 20.w,
        ),
        SvgPicture.asset(ImagesPath.done),
        SizedBox(
          width: 16.w,
        ),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
      ],
    );
  }
}
