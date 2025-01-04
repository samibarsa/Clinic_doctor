// ignore_for_file: use_build_context_synchronously

import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/GetPrice/get_price_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/pages/cnofirm_add_order.dart';
import 'package:doctor_app/Features/Home/data/local/local_data_source.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teeth_selector/teeth_selector.dart';

class Teeth extends StatefulWidget {
  const Teeth({super.key, required this.patientId});
  final int patientId;

  @override
  State<Teeth> createState() => _TeethState();
}

class _TeethState extends State<Teeth> {
  String toothNumber = ""; // تعريف teethNumber هنا

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("اختر رقم السن"),
      ),
      body: BlocListener<GetPriceCubit, GetPriceState>(
        listener: (context, state) {
          if (state is GetPriceLoaded) {
            if (toothNumber != "") {
              MovingNavigation.navTo(
                context,
                page: ConfirmAddOrder(
                  appBarTitle: "صورة تصوير مقطعيC.B.C.T",
                  value1: "ساحة 5*5 مميزة للبية",
                  value2: "لا يوجد",
                  value3: toothNumber,
                  value4: "${state.price.toString()} ل.س",
                  patientId: widget.patientId,
                  getPriceLoaded: state,
                  toothNumber: int.parse(toothNumber),
                ),
              );
            }
          } else if (state is GetPriceError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
        },
        child: BlocBuilder<GetPriceCubit, GetPriceState>(
          builder: (context, state) {
            if (state is GetPriceLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TeethSelector(
                    onChange: (selected) {
                      if (selected.isNotEmpty) {
                        setState(() {
                          toothNumber = selected[0];
                        });
                      } else {
                        setState(() {
                          toothNumber = "";
                        });
                      }
                    },
                    showPermanent: true,
                    showPrimary: false,
                    notation: (isoString) => "ISO: $isoString",
                    multiSelect: false,
                    selectedColor: Color(AppColor.primaryColor),
                    unselectedColor: Colors.grey,
                    tooltipColor: Colors.red,
                    defaultStrokeColor: Colors.transparent,
                    strokeWidth: {
                      "11": 10.0,
                      "12": 10.0,
                    },
                    defaultStrokeWidth: 10.0,
                    leftString: "جهة اليسار",
                    rightString: "جهة اليمين",
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                    ),
                    tooltipTextStyle: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Card(
                    color: Colors.green[100],
                    child: SizedBox(
                      height: 40,
                      width: 60,
                      child: Center(
                        child: Text(
                          toothNumber,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(AppColor.primaryColor),
                        ),
                        borderRadius: BorderRadius.circular(6.r)),
                    child: CustomButton(
                      title: "تأكيد",
                      color: (0x00000000),
                      onTap: () async {
                        if (toothNumber != "") {
                          try {
                            int? detailId = await LocalDataSource.getDetailId(
                              "لا يوجد",
                              "C.B.C.T",
                              "ساحة 5*5 مميزة للبية",
                            );

                            if (detailId != null) {
                              BlocProvider.of<GetPriceCubit>(context)
                                  .getPrice(detailId, "لا شيء");
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('خطأ: $e')),
                            );
                          }
                        }
                      },
                      titleColor: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
