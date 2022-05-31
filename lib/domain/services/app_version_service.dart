import 'dart:convert';
import 'dart:io';
import 'package:***REMOVED***/core/asset_images.dart';
import 'package:***REMOVED***/presentation/ui/widgets/dialogs/app_version_dialog.dart';
import 'package:***REMOVED***/presentation/ui/widgets/dialogs/info_bottomsheet.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppVersionService {
  static bool skipped = false;

  static Future checkVersion() async {
    if (skipped) {
      return;
    }
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appVersion = packageInfo.version;

      String platform = '';
      if (Platform.isAndroid) {
        platform = 'Android';
      } else if (Platform.isIOS) {
        platform = 'Ios';
      } else {
        throw Exception('Unsupported platform');
      }

      var response = await http.get(Uri.parse(
          'http://***REMOVED******REMOVED***AppVersion/V2/$platform'));

      AppVersion desiredVersion = AppVersion.fromJson(response.body);

      int an = int.parse(desiredVersion.version.split('.').join().toString());

      int bn = int.parse(appVersion.split('.').join().toString());

      if (an > bn) {
        await Get.bottomSheet(
          InfoBottomSheet(
              headerText: 'Update app please',
              mainText:
                  'A new version of this application is available, please update',
              actions: [
                InfoAction(
                    text: 'Update',
                    callback: () {
                      launch(desiredVersion.downloadUrl);
                    })
              ],
              headerIconPath: AssetImages.info),
          // isDismissible: false,
        );
        skipped = true;
      }
    } catch (e) {
      print(e);
    }
  }
}

class AppVersion {
  final String version;
  final String downloadUrl;
  AppVersion({
    required this.version,
    required this.downloadUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'version': version,
      'downloadUrl': downloadUrl,
    };
  }

  factory AppVersion.fromMap(Map<String, dynamic> map) {
    return AppVersion(
      version: map['Version'] ?? '',
      downloadUrl: map['DownloadUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppVersion.fromJson(String source) =>
      AppVersion.fromMap(json.decode(source));

  @override
  String toString() =>
      'AppVersion(version: $version, downloadUrl: $downloadUrl)';
}
