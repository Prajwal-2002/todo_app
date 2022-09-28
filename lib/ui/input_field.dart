import 'package:flutter/material.dart';
import 'package:todo_app/ui/theme.dart';

class MyInputField extends StatelessWidget {
  final String title, hint;
  final Widget? widget;
  final TextEditingController? ctr;
  final TextInputAction tia;
  const MyInputField({
    super.key,
    required this.title,
    required this.hint,
    this.widget,
    this.ctr,
    required this.tia,
  });

  @override
  Widget build(BuildContext context) {
    final field = TextFormField(
      readOnly: widget == null ? false : true,
      autofocus: false,
      controller: ctr,
      keyboardType: TextInputType.text,
      /*validator: (value) {
        if (value!.isEmpty) {
          return ("This field is required");
        }
        return null;
      },*/
      onSaved: (valve) {
        ctr?.text = valve!;
      },
      //cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
      textInputAction: tia,
      decoration: InputDecoration(
        suffixIcon: widget,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle(),
          ),
          const SizedBox(
            height: 5,
          ),
          field,
        ],
      ),
    );
  }
}
