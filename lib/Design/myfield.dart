import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy_bites/Color_Me/Color_me.dart';
import 'package:healthy_bites/Responsive/responsive_ui.dart';
import 'package:healthy_bites/Responsive/size_config.dart';

class MyField extends StatelessWidget {
  final String? hint;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? icon;
  final String? label;
  final String? preText;
  final Widget? sicon;

  final String? error;
  String? validValue;
  final onPress;
  double? _width;
  double? _pixelRatio;
  bool? large;
  bool? medium;

  MyField({
    this.hint,
    this.textEditingController,
    this.keyboardType,
    this.icon,
    this.label,
    this.preText,
    this.onPress,
    this.validValue,
    this.error,
    this.sicon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width!, _pixelRatio!);
    medium = ResponsiveWidget.isScreenMedium(_width!, _pixelRatio!);
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      //elevation: large ? 6 : (medium ? 4 : 2),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onPress,
        obscuringCharacter: "*",
        style: TextStyle(fontSize: 2.5 * SizeConfig.textMultiplier!),
        cursorColor: Color_me.main,
        decoration: InputDecoration(
            suffixIcon: sicon,
            prefixIcon: Icon(icon),
            labelText: label,
            hintText: hint,
            prefixText: preText,
            labelStyle: TextStyle(color: Colors.grey),
            border: new OutlineInputBorder(
                borderSide: new BorderSide(
              color: Color_me.main,
              width: 1,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              width: 1,
              color: Color_me.main,
            )),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 1, color: Colors.red)),
            errorStyle: TextStyle(
              color: Colors.red,
            )),
        validator: (value) {
          if (value!.isEmpty) {
            return error;
          } else {
            return null;
          }
        },
        onSaved: (value) {
          validValue = value;
        },
      ),
    );
  }
}
