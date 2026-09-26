import 'package:flutter/material.dart';

class Transaction {
  final String title;
  final String category;
  final String date;
  final String time;
  final double amount;
  final String sign;
  final IconData icon;
  final Color color;
  final String description;

  Transaction({
    required this.title,
    required this.category,
    required this.date,
    required this.time,
    required this.amount,
    required this.sign,
    required this.icon,
    required this.color,
    String? description,
  }) : description = description ?? title;
}
