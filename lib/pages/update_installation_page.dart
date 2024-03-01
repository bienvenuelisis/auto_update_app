import 'dart:io';

import 'package:auto_update_app/utils/download_file.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';

import '../models/app_release.dart';
import '../utils/save_apk_file.dart';
import '../widgets/version_widget.dart';

class UpdateLatestVersionPage extends StatefulWidget {
  const UpdateLatestVersionPage(
    this.latestRelease, {
    super.key,
  });

  final AppRelease latestRelease;

  @override
  State<UpdateLatestVersionPage> createState() =>
      _UpdateLatestVersionPageState();
}

class _UpdateLatestVersionPageState extends State<UpdateLatestVersionPage> {
  double _downloadPercent = 0;

  File? _releaseApkFile;

  @override
  void initState() {
    super.initState();

    _downloadAndSaveLatestReleaseApkFile();
  }

  bool get downloaded => _releaseApkFile != null;

  set downloadPercent(double value) {
    setState(() {
      _downloadPercent = value;
    });
  }

  Future<void> install() async {
    try {
      OpenFilex.open(_releaseApkFile?.path);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _downloadAndSaveLatestReleaseApkFile() async {
    final bytes = await downloadFile(
      widget.latestRelease.downloadUrl,
      onReceiveProgress: (actualBytes, totalBytes) {
        if (actualBytes < totalBytes) {
          downloadPercent = (actualBytes / totalBytes);
        }
      },
    );

    final file = await saveApkFile(
      widget.latestRelease.packageName,
      bytes,
    );

    setState(() {
      _releaseApkFile = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          Navigator.of(context).pop();
        }

        return;
      },
      child: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'Installing version ${widget.latestRelease.version}...',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              downloaded
                                  ? "Tap on \"Install\"."
                                  : 'Please wait, the app is being downloaded.',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        minHeight: 10,
                        semanticsLabel: '${_downloadPercent * 100} %',
                        color: Theme.of(context).colorScheme.primary,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                        value: _downloadPercent,
                      ),
                    ),
                    Center(child: Text('${(_downloadPercent * 100).ceil()} %')),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: downloaded ? install : null,
                      child: const Text("Install"),
                    ),
                    const Spacer(),
                    const VersionWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
