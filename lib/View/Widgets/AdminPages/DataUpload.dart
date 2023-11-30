import 'package:flutter/material.dart';

class DataUpload extends StatelessWidget {
  const DataUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Изменение данных'),
          backgroundColor: Colors.orangeAccent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StyledButton(
                text: 'Изменить преподавателей',
                color: Colors.orange,
                onPressed: () {
                },
              ),
              const SizedBox(height: 20),
              StyledButton(
                text: 'Изменить аудитории',
                color: Colors.lightGreen,
                onPressed: () => {
                },
              ),
              const SizedBox(height: 20),
              StyledButton(
                text: 'Изменить группы',
                color: Colors.deepOrange,
                onPressed: () {
                },
              ),
              const SizedBox(height: 20),
              StyledButton(
                text: 'Изменить предметы',
                color: Colors.green,
                onPressed: () {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StyledButton extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const StyledButton({super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  State<StyledButton> createState() => _StyledButtonState();
}

class _StyledButtonState extends State<StyledButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          color: _isHovered ? widget.color.withOpacity(0.5) : widget.color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
