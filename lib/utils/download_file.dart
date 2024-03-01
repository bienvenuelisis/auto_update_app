import 'package:http/http.dart' as http;

Future<List<int>> downloadFile(
  String fileUrl, {
  void Function(int actualBytes, int totalBytes)? onReceiveProgress,
}) async {
  late int totalSize;

  int received = 0;

  late http.StreamedResponse response;

  final List<int> bytes = [];

  response = await http.Client().send(http.Request('GET', Uri.parse(fileUrl)));

  totalSize = response.contentLength ?? 0;

  await response.stream.listen((value) {
    bytes.addAll(value);

    received += value.length;

    onReceiveProgress?.call(received, totalSize);
  }).asFuture();

  return bytes;
}
