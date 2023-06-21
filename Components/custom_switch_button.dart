//flutter pub add switch_button                  (switch_button: ^0.0.1)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:switch_button/switch_button.dart';

class MyCustomSwichButton extends StatelessWidget {
  MyCustomSwichButton(
      {super.key,
      required this.isInputText,
      this.switchText,
      this.activeColor,
      this.inactiveColor,
      this.switchValue = false,
      required this.onToggle});

  bool isInputText;
  Text? switchText;
  Color? activeColor;
  Color? inactiveColor;
  bool switchValue;
  Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      child: SwitchButton(
        inactiveColor: inactiveColor,
        backgroundColor:
            switchValue ? const Color(0xffF2F2F2) : const Color(0xffF2F2F2),
        toggleColor: Colors.white,
        activeColor: activeColor,
        value: switchValue, // driversController.state.value,
        onToggle: onToggle,
        child: Center(
          child: Visibility(
            visible: isInputText,
            child: Text(
              switchText.toString(),
              style: TextStyle(
                color: switchValue
                    ? const Color(0xff1C8339)
                    : const Color(0xffEF5448),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
