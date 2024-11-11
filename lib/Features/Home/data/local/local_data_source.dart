import 'dart:convert';

import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/services.dart';

class LocalDataSource {
  static Future<int?> getDetailId(
      String modeName, String typeName, String optionName) async {
    // قراءة الملف كـ String
    final String response = await rootBundle.loadString(FilesPath.detilesJson);

    // تحويل النص من JSON إلى قائمة من الكائنات
    final List<dynamic> data = json.decode(response);

    // البحث عن الكائن المطابق
    for (var item in data) {
      if (item['examinationmodes']['mode_name'] == modeName &&
          item['examinationtypes']['type_name'] == typeName &&
          item['examinationoptions']['option_name'] == optionName) {
        return item['detail_id'];
      }
    }

    // إذا لم يتم العثور على أي تطابق، قم بإرجاع null
    return null;
  }
}
