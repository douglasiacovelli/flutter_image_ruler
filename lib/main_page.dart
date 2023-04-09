import 'package:flutter/material.dart';
import 'package:size_calculator/canvas_controller.dart';
import 'package:size_calculator/my_painter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = CanvasController();
  bool _calibrating = false;
  double _centimeters = 0;
  double _ratio = 0;

  @override
  void initState() {
    super.initState();
    controller.addTwoPointSelectedCallback(_onTwoPointsSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Size calculator'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              setState(() {
                controller.clear();
                _calibrating = true;
              });
            },
            child: const Text(
              'Calibrate',
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () {
              controller.undo();
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => InteractiveViewer(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/sample.jpeg', fit: BoxFit.cover),
              CustomPaint(
                painter: MyPainter(controller),
                size: MediaQuery.of(context).size,
              ),
              SizedBox(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                child: GestureDetector(
                  onTapDown: (details) {
                    controller.addPoint(details.localPosition);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTwoPointsSelected(Offset p1, Offset p2) {
    final distance = (p1 - p2).distance;
    if (_ratio != 0) {
      _showResultDialog(distance);
    }

    if (_calibrating) {
      _showCalibrationDialog(distance);
    }
  }

  void _showResultDialog(double distance) {
    final centimeters = distance * _ratio;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Measurement'),
        content: Text('${centimeters.toStringAsFixed(1)} centimeters'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCalibrationDialog(double distance) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Calibrate'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('How many centimeters are there between the dots?'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _centimeters = double.tryParse(value) ?? 0;
                  _ratio = _centimeters / distance;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _calibrating = false;
                });
                controller.clear();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  }
}
