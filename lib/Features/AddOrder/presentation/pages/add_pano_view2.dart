// ignore_for_file: use_build_context_synchronously

import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/AddOrder/addorder_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/GetPrice/get_price_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/pages/cnofirm_add_order.dart';
import 'package:doctor_app/Features/AddOrder/presentation/widgets/add_radio_body.dart';
import 'package:doctor_app/Features/Home/data/local/local_data_source.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
      child: BlocBuilder<GetPriceCubit, GetPriceState>(
        builder: (context, state) {
          if (state is GetPriceLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetPriceLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${state.price} الكلفه')),
              );
            });
            if (selectedOption != null) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                MovingNavigation.navTo(context,
                    page: ConfirmAddOrder(
                      appBarTitle: "صورة ماجيك بانوراما",
                      value1: widget.examinationOption,
                      value2: selectedOption!,
                      value3: "${state.price.toString()} ل.س",
                      value4: '',
                      onTap: () {
                        BlocProvider.of<AddorderCubit>(context).addOrder(
                            state,
                            selectedOption!,
                            widget.examinationOption,
                            widget.patientId);
                      },
                      patientId: widget.patientId,
                    ));
              });
            }
          } else if (state is GetPriceError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errMessage)),
              );
            });
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("صورة ماجيك بانوراما"),
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
                    // ignore: unused_local_variable
                    int? detailId = await LocalDataSource.getDetailId(
                        "لا يوجد", "بانوراما", widget.examinationOption);
                    BlocProvider.of<GetPriceCubit>(context)
                        .getPrice(detailId!, selectedOption!);
                  }
                },
                titleButton: "تأكيد"),
          );
        },
      ),
    );
  }
}
