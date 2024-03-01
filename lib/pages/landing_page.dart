import 'package:auto_update_app/models/app_release.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../services/get_app_latest_release.dart';
import '../utils/version_code_extension.dart';
import 'home_page.dart';
import 'update_installation_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    _checkIfAppIsUpToDate().then(
      (app) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => app.upToDate
                ? const HomePage()
                : UpdateLatestVersionPage(app.latestRelease),
          ),
        );
      },
    );
  }

  Future<({bool upToDate, AppRelease latestRelease})>
      _checkIfAppIsUpToDate() async {
    final appLatestRelease = await getAppLatestRelease();

    final appLatestVersionCode = appLatestRelease.version.versionCode;

    final appActualVersionCode = await PackageInfo.fromPlatform().then(
      (info) => info.version.versionCode,
    );

    return (
      latestRelease: appLatestRelease,
      upToDate: appLatestVersionCode == appActualVersionCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            SizedBox(height: 24),
            Text('Checking for updates...'),
          ],
        ),
      ),
    );
  }
}
