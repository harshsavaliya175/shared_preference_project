import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preference_project/common/height_size_box.dart';

Widget commonTextFiled({
  required TextEditingController controller,
  required String textFiledText,
  bool readOnly = false,
  required IconData prefixIcon,
  TextInputType? keyboardType,
  required String hintText,
  String? Function(String?)? validator,
  void Function()? onTap,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          textFiledText,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
      heightSizeBox(5),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          hintStyle: const TextStyle(fontSize: 18),
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        readOnly: readOnly,
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onTap: onTap,
      ),
    ],
  );
}
