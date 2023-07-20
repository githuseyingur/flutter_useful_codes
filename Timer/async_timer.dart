//DEFINE THIS FUNCTION IN ASYNCHRONOUS FUNCTION
void stopwatch() {
    int i = 0;
    Timer _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      i++;
      if (i == 8) {
        Get.snackbar('HATA', 'İşlem Başarısız Oldu! Lütfen Tekrar Deneyiniz...',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    });
  } 

//ASYNCHRONOUS FUNCTION
onpressed() async{
  stopwatch(); // not use await
  // other operations with await
}

//DESCRIPTION OF THIS FILE : When the button is clicked, the time starts, then it is checked whether the transactions have been made within a certain period of time.
