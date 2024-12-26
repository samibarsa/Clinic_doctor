import 'package:doctor_app/core/utils/constant.dart';
import 'package:doctor_app/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teeth_selector/teeth_selector.dart';

class Teeth extends StatefulWidget {
  const Teeth({super.key});

  @override
  State<Teeth> createState() => _TeethState();
}

class _TeethState extends State<Teeth> {
  String teethNumber = ""; // تعريف teethNumber هنا

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("اختر رقم السن"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TeethSelector(
              onChange: (selected) {
                if (selected.isNotEmpty) {
                  setState(() {
                    teethNumber = selected[0];
                  });
                } else {
                  setState(() {
                    teethNumber = "";
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
                    teethNumber,
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
                  onTap: () {
                    if (teethNumber != "") {
                      print(teethNumber);
                    }
                  },
                  titleColor: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
