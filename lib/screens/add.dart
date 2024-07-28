import 'package:flutter/material.dart';
import '../services/draggable_object.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TextEditorScreen extends StatefulWidget {
  @override
  _TextEditorScreenState createState() => _TextEditorScreenState();
}

class _TextEditorScreenState extends State<TextEditorScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _fonts = ['Arial', 'Verdana', 'Times New Roman'];
  String _selectedFont = 'Arial';
  double _fontSize = 16.0;
  Color _color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Text'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Enter the text'),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedFont,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFont = newValue!;
                });
              },
              items: _fonts.map((font) {
                return DropdownMenuItem(
                  value: font,
                  child: Text(font),
                );
              }).toList(),
              hint: Text('Select Font'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text('Font Size:'),
                Expanded(
                  child: Slider(
                    value: _fontSize,
                    min: 5,
                    max: 72,
                    divisions: 15,
                    onChanged: (double value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ColorPicker(
              pickerColor: _color,
              onColorChanged: (Color color) {
                setState(() {
                  _color = color;
                });
              },
              showLabel: false,
              pickerAreaHeightPercent: 0.8,
            ),
            Spacer(),
            Material(
              color: Theme.of(context).colorScheme.inversePrimary,
              child: InkWell(
                onTap: () {
                  final textObject = TextObject(
                    text: _textController.text,
                    style: TextStyle(
                      fontFamily: _selectedFont,
                      fontSize: _fontSize,
                      color: _color,
                    ),
                    position: Offset(MediaQuery.of(context).size.width * 0.1, MediaQuery.of(context).size.height * 0.5,), // Default starting position
                  );

                  Navigator.pop(context, textObject);
                },
                child: Container(
                  child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 16),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}