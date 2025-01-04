// ignore_for_file: use_build_context_synchronously

import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/AddOrder/addorder_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/GetPrice/get_price_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/pages/add_order_view.dart';
import 'package:doctor_app/Features/AddOrder/presentation/widgets/section_title.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/view/homePageViewWidget.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:doctor_app/core/utils/widgets/custom_text_field.dart';
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
      required this.patientId,
      required this.getPriceLoaded,
      this.toothNumber});
  final String appBarTitle;
  final int? toothNumber;
  final String value1;
  final String value2;
  final String value3;
  final String value4;
  final int patientId;
  final GetPriceLoaded getPriceLoaded;
  @override
  Widget build(BuildContext context) {
    bool oneImage = false;
    TextEditingController notes = TextEditingController();
    var examinationOption = "";
    var examinationMode = "";
    var outPut = "";
    // ignore: unused_local_variable, prefer_typing_uninitialized_variables
    var price;
    var title1 = "الجزء المراد تصويره:";
    var title2 = "وضعية الصورة";
    var title3 = "";
    var title4 = "";
    var type = "";
    if (appBarTitle == "صورة ماجيك بانوراما") {
      title1 = "الجزء المراد تصويره:";
      examinationOption = value1;
      title2 = "شكل الصورة:";
      outPut = value2;
      title3 = "الفاتورة :";
      price = value3;
      examinationMode = "لا يوجد";
      type = "بانوراما";
    } else if (appBarTitle == "صورة تصوير مقطعيC.B.C.T") {
      if (value1 == "ساحة 5*5 مميزة للبية") {
        title1 = "الجزء المراد تصويره:";
        examinationOption = value1;
        title2 = "وضعية الصورة";
        examinationMode = value2;
        title3 = "رقم السن :";
        outPut = value3;
        title4 = "الفاتورة :";
        price = value4;
        type = "C.B.C.T";
      } else {
        title1 = "الجزء المراد تصويره:";
        examinationOption = value1;
        title2 = "وضعية الصورة";
        examinationMode = value2;
        title3 = "شكل الصورة:";
        outPut = "لا يوجد";
        title4 = "الفاتورة :";
        price = value3;
        type = "C.B.C.T";
      }
    } else if (appBarTitle == "صورة سيفالومتريك") {
      title1 = "الجزء المراد تصويره:";
      examinationOption = value1;
      title2 = "وضعية الصورة";
      examinationMode = value2;
      title3 = "شكل الصورة:";
      outPut = value3;
      title4 = "الفاتورة :";
      price = value4;
      type = "سيفالوماتريك";
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AddOrderCubit, AddorderState>(
        listener: (BuildContext context, AddorderState state) {
          if (state is AddorderFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
            ;
          } else if (state is AddorderSucses && oneImage == true) {
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
          }
          return Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              centerTitle: true,
              title: Text(appBarTitle),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: ListView(
                children: [
                  SizedBox(
                    height: 34.h,
                  ),
                  if (value1 != "لا يوجد") // الشرط هنا
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
                  if (value2 != "لا يوجد") // الشرط هنا
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
                  if (value3 != "لا يوجد") // الشرط هنا
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        )
                      ],
                    ),
                  if (value4 != "لا يوجد") // الشرط هنا
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appBarTitle != "صورة ماجيك بانوراما"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SectionTitle(
                                    title: title4,
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w500),
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
                            : const SizedBox()
                      ],
                    ),
                  CustomTextField(
                    title: 'ملاحظات',
                    radius: 6.sp,
                    textEditingController: notes,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.r)),
                        border: Border.all(
                            color: const Color(AppColor.primaryColor))),
                    child: CustomButton(
                      title: "إنهاء",
                      color: 0xffFFFF,
                      onTap: () async {
                        oneImage = true;
                        final now = DateTime.now();
                        final startOfMonth = DateTime(now.year, now.month, 1);
                        final endOfMonth = DateTime(now.year, now.month + 1, 0);
                        await BlocProvider.of<AddOrderCubit>(context).addOrder(
                            getPriceLoaded,
                            toothNumber != null ? toothNumber! : 0,
                            outPut,
                            examinationOption,
                            patientId,
                            examinationMode,
                            type,
                            notes.text);
                        BlocProvider.of<OrderCubit>(context).fetchOrders(
                            startDate: startOfMonth, endDate: endOfMonth);
                      },
                      titleColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 21.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.r)),
                        border: Border.all(
                            color: const Color(AppColor.primaryColor))),
                    child: CustomButton(
                      title: "صورة أخرى",
                      color: 0xffFFFF,
                      onTap: () async {
                        oneImage = false;
                        await BlocProvider.of<AddOrderCubit>(context).addOrder(
                            getPriceLoaded,
                            toothNumber != null ? toothNumber! : 0,
                            outPut,
                            examinationOption,
                            patientId,
                            examinationMode,
                            type,
                            notes.text);
                        Future.delayed(Duration(milliseconds: 100));
                        if (state is AddorderSucses && oneImage == false) {
                          MovingNavigation.navTo(context,
                              page: AddOrderView(
                                patientId: patientId,
                              ));
                        }
                      },
                      titleColor: Colors.black,
                    ),
                  ),
                  Spacer()
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
    return value != "لا يوجد" // الشرط هنا
        ? Row(
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
          )
        : const SizedBox(); // إرجاع عنصر فارغ إذا كانت القيمة "لا يوجد"
  }
}
