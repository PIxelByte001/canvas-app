import 'package:flutter/material.dart';
import '../services/draggable_object.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'add.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TextObject> textObjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Canvas'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
        ),

        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Spacer(),
              Material(
                color: Theme.of(context).colorScheme.inversePrimary,
                child: InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TextEditorScreen(),
                      ),
                    );

                    if (result != null && result is TextObject) {
                      setState(() {
                        textObjects.add(result);
                      });
                    }
                  },
                  child: Container(
                    child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                        child: Text(
                          'Add text',
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                ),
              ),
              Spacer(),
              Container(
                decoration: const BoxDecoration(
                  border: DashedBorder.fromBorderSide(
                    dashLength: 10,
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Stack(
                  children: [
                    ...textObjects.map((textObject) {
                      return
                      Positioned(
                        left: textObject.position.dx - MediaQuery.of(context).size.width * 0.05,
                        top: textObject.position.dy - MediaQuery.of(context).size.height * 1/6,
                        child: Draggable(
                          feedback: Text(
                            textObject.text,
                            style: textObject.style,
                          ),
                          childWhenDragging: Container(),
                          onDragEnd: (details) {
                            setState(() {
                              textObject.position = details.offset;
                            });
                          },
                          child: Text(
                            textObject.text,
                            style: textObject.style,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              Spacer()
            ])));
  }
}