import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PackageInfo.fromPlatform().then(
        (info) => info.version,
      ),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Version ${snapshot.data}',
          ),
        );
      },
    );
  }
}
