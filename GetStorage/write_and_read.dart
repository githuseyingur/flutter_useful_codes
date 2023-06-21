  //! WRITE
  Future setCourierVersion(String courierVersion) async {
    final box = GetStorage();
    await box.write('courierVersion', courierVersion);
  }

 //! READ
  Future<String> getCourierVersion() async {
    final box = GetStorage();
    final getBox = box.read<String>('courierVersion');
    return getBox ?? "";
  }
