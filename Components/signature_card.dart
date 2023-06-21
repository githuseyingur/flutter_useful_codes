// flutter pub add syncfusion_flutter_signaturepad

import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class SignatureCard extends StatelessWidget {
  SignatureCard({Key? key, required this.signaturePadKey}) : super(key: key);
  GlobalKey<SfSignaturePadState> signaturePadKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      height: 150.h,
      width: 360.w,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Colors.white,
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: Stack(
          children: [
            SfSignaturePad(
              key: signaturePadKey,
              minimumStrokeWidth: 1,
              maximumStrokeWidth: 3,
              strokeColor: Colors.black,
              backgroundColor: Colors.transparent,
            ),
            Positioned(
                //right: MediaQuery.of(context).size.width / 2.5,
                left: MediaQuery.of(context).size.width / 3.4,
                top: 20.h,
                child: Text(
                  'İmzanızı Atın',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                )),
          ],
        ),
      ),
    );
  }
}
