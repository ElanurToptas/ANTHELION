import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  TextEditingController _textEditingController = TextEditingController();
  bool isContainerOpen = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void toggleContainer(bool hasFocus) {
    setState(() {
      isContainerOpen = hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Metin Alanı',
              ),
              onChanged: (value) {
                // Metin alanında değişiklik olduğunda burası çalışır
              },
              onTap: () {
                toggleContainer(true);
              },
              onSubmitted: (value) {
                toggleContainer(false);
              },
            ),
            if (isContainerOpen) Container(height: 200, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
