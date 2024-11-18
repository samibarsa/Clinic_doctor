// ignore_for_file: use_build_context_synchronously

import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/AddOrder/addorder_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/maneger/cubit/GetPrice/get_price_cubit.dart';
import 'package:doctor_app/Features/AddOrder/presentation/pages/cnofirm_add_order.dart';
import 'package:doctor_app/Features/AddOrder/presentation/widgets/add_radio_body.dart';
import 'package:doctor_app/Features/Home/data/local/local_data_source.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/core/utils/navigator/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCBCTView3 extends StatefulWidget {
  const AddCBCTView3(
      {super.key,
      required this.examinationOption,
      required this.patientId,
      required this.examinationMode});

  final String examinationOption;
  final String examinationMode;
  final int patientId;

  @override
  State<AddCBCTView3> createState() => _AddPanoView2State();
}

class _AddPanoView2State extends State<AddCBCTView3> {
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${state.price} الكلفه')),
                );

                if (selectedOption != null) {
                  MovingNavigation.navTo(
                    context,
                    page: ConfirmAddOrder(
                      appBarTitle: "صورة تصوير مقطعيC.B.C.T",
                      value1: widget.examinationOption,
                      value3: selectedOption!,
                      value4: "${state.price.toString()} ل.س",
                      patientId: widget.patientId,
                      value2: widget.examinationMode,
                      onTap: () async {
                        await BlocProvider.of<AddOrderCubit>(context).addOrder(
                            state,
                            selectedOption!,
                            widget.examinationOption,
                            widget.patientId,
                            widget.examinationMode,
                            "C.B.C.T");
                        BlocProvider.of<OrderCubit>(context).fetchOrders();
                      },
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
                centerTitle: true,
                title: const Text("صورة تصوير مقطعيC.B.C.T"),
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
                        widget.examinationMode,
                        "C.B.C.T",
                        widget.examinationOption,
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
              ),
            );
          },
        ),
      ),
    );
  }
}