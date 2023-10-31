import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../State/MyDataModel.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataModel = Provider.of<MyDataModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Counter: ${dataModel.counter}'),
            ElevatedButton(
              onPressed: () {
                dataModel.incrementCounter();
              },
              child: const Text('Increment Counter'),
            ),
          ],
        ),
      ),
    );
  }
}
