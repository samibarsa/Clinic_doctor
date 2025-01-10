// ignore_for_file: use_build_context_synchronously

import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/GetPrice/get_price_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/pages/cnofirm_add_order.dart';
import 'package:doctor_app/Features/AddOrder/presentation/widgets/add_radio_body.dart';
import 'package:doctor_app/Features/Home/data/local/local_data_source.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPanoView2 extends StatefulWidget {
  const AddPanoView2(
      {super.key, required this.examinationOption, required this.patientId});

  final String examinationOption;
  final int patientId;

  @override
  State<AddPanoView2> createState() => _AddPanoView2State();
}

class _AddPanoView2State extends State<AddPanoView2> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    final List<String> options = ['لا شيء', 'CD', 'Film', 'CD+Film'];

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
                      appBarTitle: "صورة ماجيك بانوراما",
                      value1: widget.examinationOption == "مفصل TMJ"
                          ? widget.examinationOption
                          : "لا يوجد",
                      value2: selectedOption!,
                      value3: "${state.price.toString()} ل.س",
                      value4: '',
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
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            centerTitle: true,
            title: const Text("صورة ماجيك بانوراما"),
          ),
          body: BlocBuilder<GetPriceCubit, GetPriceState>(
            builder: (context, state) {
              if (state is GetPriceLoading) {
                return Center(
                  child: CircularProgressIndicator(),
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
                title: "اختر شكل الصورة:",
                onTap: () async {
                  if (selectedOption != null) {
                    try {
                      int? detailId = await LocalDataSource.getDetailId(
                        "لا يوجد",
                        "بانوراما",
                        "لا يوجد",
                      );

                      if (detailId != null) {
                        BlocProvider.of<GetPriceCubit>(context)
                            .getPrice(detailId, selectedOption!);
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('خطأ: $e')),
                      );
                    }
                  }
                },
                titleButton: "تأكيد",
              );
            },
          ),
        ),
      ),
    );
  }
}
