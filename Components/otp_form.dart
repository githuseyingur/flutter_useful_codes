class DeliveryOtpForm extends StatelessWidget {
  
  RegisterOtpController registerOtpController = Get.put(RegisterOtpController());

  DeliveryOtpForm({
    super.key,
    this.otpLength = 4,
    required this.currentCode

    // required this.authController
  });
//final AuthController authController;
  final int otpLength;
  final String currentCode;

  @override
  Widget build(BuildContext context) {
    return  Form(
        child: SizedBox(
          width: 1.sw,
          height: 70.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: PinFieldAutoFill(
              onCodeChanged: (value) {
                if (value != null) {
                  registerOtpController.otpCode.value = value;
                }
              },
              currentCode: currentCode,
              decoration: BoxLooseDecoration(
                bgColorBuilder: const FixedColorBuilder(Color(0xffF4F4F4)),
                strokeColorBuilder: PinListenColorBuilder(
                    const Color(0xff765299), const Color(0xFFEFEFEF)),
                radius: Radius.circular(10.r),
                strokeWidth: 2.w,
                textStyle: TextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff765299),
                ),
              ),
              cursor: Cursor(
                color: const Color(0xff765299),
                width: 2.w,
                height: 30.h,
                enabled: true,
              ),
              keyboardType: TextInputType.number,
              codeLength: otpLength,
            ),
          ),
        ),
      );
  }
}
