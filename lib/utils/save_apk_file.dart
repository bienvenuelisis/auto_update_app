import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<File> saveApkFile(String fileName, List<int> bytes) async {
  final path = join(
    (await getApplicationDocumentsDirectory()).path,
    '$fileName.apk',
  );

  final file = File(path);

  await file.writeAsBytes(bytes);

  return file;
}
