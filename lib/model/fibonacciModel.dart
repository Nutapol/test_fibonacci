import 'package:flutter/cupertino.dart';

class FibonacciModel {
  final int index;
  final int number;
  final Icon icon;
  final String type;

  const FibonacciModel({
    required this.icon,
    required this.index,
    required this.number,
    required this.type,
  });
}
