import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

//* -----------------------------TR--------------------------------
//* TR: Bu kitaplığın kullanımı için gerekli paketler
//* -url_launcher
//* -package_info_plus
//* -dio
//* -lottie
//* -----------------------------EN--------------------------------
//* EN: This library requires the following packages
//* -url_launcher
//* -package_info
//* -dio
//* -lottie

class NewVersionCheck {
  BuildContext? context;
  String? androidPackageName;
  String? iosPackageName;
  String? currentVersion;
  String? title;
  String? versionDescription;
  String? updateButton;
  String? cancelButton;
  String? lottieUrl;
  Color? updateButtonColor;
  Color? cancelButtonColor;
  bool? isCancelButton;
  bool? barrierDismissible;

  Dio dio = Dio();

  NewVersionCheck.newVersionCheckControl(
    this.context,
    this.androidPackageName,
    this.iosPackageName, {
    this.title,
    this.versionDescription,
    this.updateButton,
    this.cancelButton,
    this.lottieUrl,
    this.updateButtonColor = Colors.green,
    this.cancelButtonColor = Colors.red,
    this.isCancelButton = false,
    this.barrierDismissible = false,
  }) {
    getVersion();
    newVersionCheckControl();
  }

  Future getVersion() async {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      currentVersion = packageInfo.version;
    });
  }

  void newVersionCheckControl() {
    if (Platform.isAndroid) {
      _checkPlayStore(androidPackageName!);
    } else {
      _checkAppleStore(iosPackageName!);
    }
  }

  _checkPlayStore(String packageName) async {
    String? errorMsg;
    String? newVersion;
    String? url;

    final uri = Uri.https(
        "play.google.com", "/store/apps/details", {"id": packageName});
    try {
      final response = await dio.get(uri.toString());
      if (response.statusCode != 200) {
        errorMsg =
            "Can't find an app in the Google Play Store with the id: $packageName";
      } else {
        //   print(response.body);
        newVersion = RegExp(r',\[\[\["([0-9,\.]*)"]],')
            .firstMatch(response.data)!
            .group(1);
        url = uri.toString();
        //  newVersionAlert(context!, newVersion!, url);
        if (newVersion != currentVersion) {
          newVersionAlert(context!, newVersion!, url);
        }
        print(newVersion);
      }
    } catch (e) {
      errorMsg = "$e";
    }
  }

  _checkAppleStore(String packageName) async {
    String? errorMsg;
    String? newVersion;
    String? url;
    var uri =
        Uri.https("itunes.apple.com", "/lookup", {"bundleId": packageName});
    try {
      final response = await dio.get(uri.toString());
      if (response.statusCode != 200) {
        errorMsg =
            "Can't find an app in the Apple Store with the id: $packageName";
      } else {
        final jsonObj = jsonDecode(response.data);
        final List results = jsonObj['results'];
        if (results.isEmpty) {
          errorMsg =
              "Can't find an app in the Apple Store with the id: $packageName";
        } else {
          newVersion = jsonObj['results'][0]['version'];
          url = jsonObj['results'][0]['trackViewUrl'];
          if (newVersion != currentVersion) {
            newVersionAlert(context!, newVersion!, url!);
          }
          print(newVersion);
        }
      }
    } catch (e) {
      errorMsg = "$e";
    }
  }

  void newVersionAlert(BuildContext context, String newVersion, String url) {
    showDialog(
      barrierDismissible: barrierDismissible!,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // title: Text(title + " !"),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(lottieUrl ??
                "https://assets2.lottiefiles.com/packages/lf20_xjhwr9wv.json"),
            const SizedBox(height: 10),
            Text(
              title ?? "Uygulamanızı Güncelleyin",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              (versionDescription == "")
                  ? "$versionDescription$newVersion"
                  : "Yeni Versiyon $newVersion",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16, color: Colors.black, wordSpacing: 1),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: updateButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {
                openAnyUrl(url);
                Navigator.pop(context);
              },
              child: Text(updateButton ?? "Güncelle"),
            ),
            (isCancelButton == true)
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: cancelButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(cancelButton ?? "Şimdi değil"),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Future<void> openAnyUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
