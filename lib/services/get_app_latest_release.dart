import 'package:flutter/services.dart';

import '../models/app_release.dart';

const kAppReleaseJsonPath = 'assets/app_release_latest.json';

Future<AppRelease> getAppLatestRelease() async {
  await Future.delayed(const Duration(seconds: 6));

  final json = await rootBundle.loadString(kAppReleaseJsonPath);

  return Future.value(AppRelease.fromJson(json));
}
