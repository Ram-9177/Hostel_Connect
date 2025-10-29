import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CsvExporter {
  static Future<String> _getDownloadsPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  static Future<File> saveCsv(String fileName, List<List<dynamic>> rows) async {
    final csv = const ListToCsvConverter().convert(rows);
    final path = await _getDownloadsPath();
    final file = File('$path/$fileName');
    await file.writeAsString(csv);
    try {
      await Share.shareXFiles([XFile(file.path)], text: 'Exported CSV: $fileName');
    } catch (_) {}
    return file;
  }
}


