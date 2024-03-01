// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppRelease {
  AppRelease({
    required this.downloadUrl,
    required this.packageName,
    required this.version,
  });

  factory AppRelease.fromJson(String source) =>
      AppRelease.fromMap(json.decode(source) as Map<String, dynamic>);

  factory AppRelease.fromMap(Map<String, dynamic> map) {
    return AppRelease(
      downloadUrl: (map['download_url'] ?? '') as String,
      packageName: (map['package_name'] ?? '') as String,
      version: (map['version'] ?? '') as String,
    );
  }

  final String downloadUrl;
  final String packageName;
  final String version;
}
