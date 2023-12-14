import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../blogic/requests/requesters/FileUploadRequester.dart';


class FileUploadModel with ChangeNotifier {
  String _filePath = '';
  bool _isLoading = false;
  String? _error;

  String get filePath => _filePath;

  bool get isLoading => _isLoading;

  String? get error => _error;



  void setFilePath(String filePath){
    _filePath = filePath;

  }

  Future<void> pickAndUploadFile() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    var storage = statuses[Permission.storage];
    var manageExternalStorage = statuses[Permission.manageExternalStorage];
    if (storage!.isGranted || manageExternalStorage!.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );



      if (result != null && result.files.isNotEmpty) {
        final selectedFile = result.files.first;
        if (selectedFile != null) {
          setFilePath(selectedFile.name);
          if (selectedFile.bytes != null) {
            await _uploadFile(selectedFile.bytes!, selectedFile.name);
          } else if (selectedFile.path != null) {
            final fileBytes = await File(selectedFile.path!).readAsBytes();
            await _uploadFile(fileBytes, selectedFile.name);
          } else {
            print('File bytes and path are both null');
          }
        } else {
          print('Selected file is null');
        }
      }
    }
  }

  Future<void> _uploadFile(Uint8List fileBytes, String fileName) async {
    _isLoading = true;
    notifyListeners();

    try {
      await FileUploadRequester().uploadFile(fileBytes, fileName);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
