import 'package:flutter/material.dart';

typedef TwoPointsSelectedCallback = void Function(Offset, Offset);

class CanvasController extends ChangeNotifier {
  final List<Offset> _points = [];
  List<Offset> get points => _points;

  TwoPointsSelectedCallback? onTwoPointsSelected;

  CanvasController();

  void addPoint(Offset point) {
    if (_points.length == 2) {
      _points.clear();
    }
    _points.add(point);
    notifyListeners();
    if (_points.length % 2 == 0) {
      final lastIndex = _points.length - 1;
      onTwoPointsSelected?.call(_points[lastIndex - 1], _points[lastIndex]);
    }
  }

  void addTwoPointSelectedCallback(TwoPointsSelectedCallback callback) {
    onTwoPointsSelected = callback;
    notifyListeners();
  }

  void undo() {
    if (_points.isEmpty) return;
    _points.removeLast();
    notifyListeners();
  }

  void clear() {
    _points.clear();
    notifyListeners();
  }
}
