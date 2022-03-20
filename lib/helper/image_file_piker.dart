import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerHelper {
  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    return pickedFile;
  }

  Future<FilePickerResult?> getPDF() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );
  }

  Future<FilePickerResult?> getDocument() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
  }
}