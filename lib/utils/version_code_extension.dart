extension VersionCode on String {
  double get versionCode => double.parse(
        trim().replaceAll(".", ""),
      );
}
