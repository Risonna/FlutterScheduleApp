import 'package:flutter/material.dart';


import 'NavigationButtonsWidget.dart';


class EntitySelectionWidget extends StatelessWidget {
  final List<ButtonInfo> buttons;

  const EntitySelectionWidget({Key? key, required this.buttons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Страница выбора сущности'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buttons.map((buttonInfo) {
            return CustomButton(
              buttonInfo.label,
              buttonInfo.color,
                  () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => buttonInfo.destination(),
                ));
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ButtonInfo {
  final String label;
  final Color color;
  final Widget Function() destination;

  ButtonInfo(this.label, this.color, this.destination);
}