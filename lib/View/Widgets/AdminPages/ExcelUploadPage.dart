import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../State/Models/FileUploadModel.dart';

class ExcelUploadPage extends StatelessWidget {
  const ExcelUploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Загрузить расписание из Excel'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<FileUploadModel>(context, listen: false).pickAndUploadFile();
                },
                child: const Text('Выберите файл'),
              ),
              const SizedBox(height: 16),
              Consumer<FileUploadModel>(
                builder: (context, fileUploadModel, child) {
                  return Column(
                    children: [
                      if (fileUploadModel.isLoading)
                        const CircularProgressIndicator()
                      else if(fileUploadModel.filePath.isNotEmpty)
                        Column(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green, size: 32),
                            const SizedBox(height: 8),
                            Text(
                              'Файл ${fileUploadModel.filePath} был успешно загружен',
                              style: const TextStyle(fontSize: 16, color: Colors.green),
                            ),
                          ],
                        )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
