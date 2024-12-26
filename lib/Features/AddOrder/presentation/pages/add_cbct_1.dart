// ignore_for_file: use_build_context_synchronously

import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/GetPrice/get_price_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/pages/add_cbct_2.dart';
import 'package:doctor_app/Features/AddOrder/presentation/pages/cnofirm_add_order.dart';
import 'package:doctor_app/Features/AddOrder/presentation/pages/teeth_sellector.dart';
import 'package:doctor_app/Features/AddOrder/presentation/widgets/add_radio_body.dart';
import 'package:doctor_app/Features/Home/data/local/local_data_source.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCBCTView1 extends StatefulWidget {
  const AddCBCTView1({super.key, required this.patientId});
  final int patientId;

  @override
  State<AddCBCTView1> createState() => _AddCBCTView1State();
}

class _AddCBCTView1State extends State<AddCBCTView1> {
  String? selectedOption;

  final List<String> options = [
    'الفك العلوي',
    'الفك السفلي',
    'الفكين معا',
    'كامل الجمجمة',
    'ساحة 5*5 مميزة للبية'
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("صورة تصوير مقطعي C.B.C.T"),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<GetPriceCubit, GetPriceState>(
              listener: (context, state) {
                if (state is GetPriceLoaded) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${state.price} الكلفه')),
                  );

                  if (selectedOption != null) {
                    if (selectedOption == 'كامل الجمجمة' ||
                        selectedOption == 'الفكين معا') {
                      MovingNavigation.navTo(context,
                          page: ConfirmAddOrder(
                              appBarTitle: "صورة تصوير مقطعيC.B.C.T",
                              value1: selectedOption!,
                              value2: "لا يوجد",
                              value3: "لا شيء",
                              value4: "${state.price.toString()} ل.س",
                              patientId: widget.patientId,
                              getPriceLoaded: state));
                    }
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
              return AddRadioBody(
                patientId: widget.patientId,
                options: options,
                selectedOption: selectedOption,
                onOptionChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
                title: 'اختر الجزء المراد تصويره:',
                titleButton: "التالي",
                onTap: () async {
                  if (selectedOption != null) {
                    if (selectedOption == 'الفك العلوي' ||
                        selectedOption == 'الفك السفلي') {
                      MovingNavigation.navTo(context,
                          page: AddCBCTView2(
                            patientId: widget.patientId,
                            examinationOption: selectedOption!,
                          ));
                    } else if (selectedOption == 'ساحة 5*5 مميزة للبية') {
                      MovingNavigation.navTo(context, page: Teeth(patientId: widget.patientId,));
                    } else if (selectedOption == 'كامل الجمجمة' ||
                        selectedOption == 'الفكين معا') {
                      try {
                        int? detailId = await LocalDataSource.getDetailId(
                          "لا يوجد",
                          "C.B.C.T",
                          selectedOption!,
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
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
