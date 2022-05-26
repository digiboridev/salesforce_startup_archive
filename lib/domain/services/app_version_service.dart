import 'dart:convert';
import 'dart:io';
import 'package:***REMOVED***/presentation/ui/widgets/dialogs/app_version_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionService {
  static Future checkVersion() async {
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
        appVersionDialog(
            current: appVersion,
            desired: desiredVersion.version,
            ulr: desiredVersion.downloadUrl);
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
