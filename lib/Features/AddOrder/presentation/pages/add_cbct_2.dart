// ignore_for_file: use_build_context_synchronously

import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/GetPrice/get_price_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/pages/cnofirm_add_order.dart';
import 'package:doctor_app/Features/AddOrder/presentation/widgets/add_radio_body.dart';
import 'package:doctor_app/Features/Home/data/local/local_data_source.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCBCTView2 extends StatefulWidget {
  const AddCBCTView2({
    super.key,
    required this.examinationOption,
    required this.patientId,
  });

  final String examinationOption;
  final int patientId;

  @override
  State<AddCBCTView2> createState() => _AddCBCTView2State();
}

class _AddCBCTView2State extends State<AddCBCTView2> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      'الفك كامل',
      'نصف فك أيمن',
      'نصف فك أيسر',
      'المنطقة الأمامية'
    ];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MultiBlocListener(
        listeners: [
          BlocListener<GetPriceCubit, GetPriceState>(
            listener: (context, state) {
              if (state is GetPriceLoaded) {
                if (selectedOption != null) {
                  MovingNavigation.navTo(
                    context,
                    page: ConfirmAddOrder(
                      appBarTitle: "صورة تصوير مقطعيC.B.C.T",
                      value1: widget.examinationOption,
                      value2: selectedOption!,
                      value3: "لا يوجد",
                      value4: "${state.price.toString()} ل.س",
                      patientId: widget.patientId,
                      getPriceLoaded: state,
                    ),
                  );
                }
              } else if (state is GetPriceError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errMessage)),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<GetPriceCubit, GetPriceState>(
          builder: (context, state) {
            if (state is GetPriceLoading) {
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
                title: const Text("صورة تصوير مقطعي C.B.C.T"),
              ),
              body: AddRadioBody(
                patientId: widget.patientId,
                options: options,
                selectedOption: selectedOption,
                onOptionChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
                title: "اختر شكل الصورة:",
                onTap: () async {
                  if (selectedOption != null) {
                    try {
                      int? detailId = await LocalDataSource.getDetailId(
                        selectedOption!,
                        "C.B.C.T",
                        widget.examinationOption,
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
                titleButton: "تأكيد",
              ),
            );
          },
        ),
      ),
    );
  }
}
