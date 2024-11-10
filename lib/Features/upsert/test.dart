import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              // قم بتعريف دالة لاسترجاع mode_name و option_name و examination_type_name باستخدام order_id
              Future<void> getModeOptionAndTypeName(int orderId) async {
                try {
                  final response =
                      await Supabase.instance.client.from('orders').select('''
        examinationdetails!inner(
          mode:examinationmodes(mode_name),
          option:examinationoptions(option_name),
          type:examinationtypes(type_name)
        )
      ''').eq('order_id', orderId).single();

                  final data = response;
                  final modeName =
                      data['examinationdetails']['mode']['mode_name'];
                  final optionName =
                      data['examinationdetails']['option']['option_name'];
                  final examinationTypeName =
                      data['examinationdetails']['type']['type_name'];

                  log(data.toString());
                  log('Mode Name: $modeName');
                  log('Option Name: $optionName');
                  log('Examination Type Name: $examinationTypeName');
                } catch (e) {
                  log(e.toString());
                }
              }

              await getModeOptionAndTypeName(44);
            },
            child: Icon(Icons.add)),
      ),
    );
  }
}
