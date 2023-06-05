import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoProvider {
  PackageInfo packageInfo;
  PackageInfoProvider({required this.packageInfo});
  String? getAppVersion() {
    return packageInfo.version;
  }
}
