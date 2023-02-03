// ignore: file_names
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  // ignore: no_leading_underscores_for_local_identifiers
  final ImagePicker _imagePicker = ImagePicker();

  XFile? file = await _imagePicker.pickImage(source: source);
  if (file != null) {
    return file;
  }
}
