// 1-CONTROLLER
import 'package:get/get.dart';

class ProfileCalendarController extends GetxController {
  RxList<DateTime?> calenderPickerValue = <DateTime?>[].obs;
}

// 2-PAGE


//DESCRIPTIONS

final today = DateUtils.dateOnly(DateTime.now());
ProfileCalendarController profileCalendarController = Get.put(
    ProfileCalendarController(),
    permanent: true, //* bu controller çağrıldıktan sonra kapatılmasın diye eklediğimiz kod 
);


//WIDGET

Column(
          children: [
            Obx(
              () => CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  firstDayOfWeek: 1,
                  calendarType: CalendarDatePicker2Type.multi,
                  dayBuilder: ({
                    required date,
                    textStyle,
                    decoration,
                    isSelected,
                    isDisabled,
                    isToday,
                  }) {
                    Widget? dayWidget;
                    if (isToday == true) {
                      dayWidget = Container(
                        margin: context.screenValue < 684
                            ? EdgeInsets.symmetric(horizontal: 8.w)
                            : EdgeInsets.symmetric(horizontal: 19.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected == true
                              ? const Color(0xFF69488E)
                              : Colors.orangeAccent,
                        ),
                        child: Center(
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Text(
                                MaterialLocalizations.of(context)
                                    .formatDecimal(date.day),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 27.5),
                              //   child: Container(
                              //     height: 4,
                              //     width: 4,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(1),
                              //       color:
                              //           isSelected == true ? Colors.red : Colors.green,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      );
                    }
                    return dayWidget;
                  },
                  selectedDayTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  dayBorderRadius: BorderRadius.circular(10),

                  selectedDayHighlightColor: const Color(0xFF69488E),

                  centerAlignModePicker: true,
                  customModePickerIcon: const SizedBox(),
                  // dayBuilder: _dayBuilder,
                  //yearBuilder: _yearBuilder,
                ),
                value: profileCalendarController.calenderPickerValue.value.obs,
                onValueChanged: (dates) {
                  // setState(() {
                  profileCalendarController.calenderPickerValue.value = dates;
                  print(
                      "Seçilen tarihler:${profileCalendarController.calenderPickerValue.value.toString()}\n}");
                  //  });
                },
              ),
            ),
          ],
        )
