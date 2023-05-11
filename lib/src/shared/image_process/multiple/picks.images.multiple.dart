import 'package:file_picker/file_picker.dart';

Future<List<PlatformFile>> pickPhotos() async {
  final file = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.image,
    dialogTitle: 'Pick Images',
  );
  if (file == null) return [];
  return file.files;
}