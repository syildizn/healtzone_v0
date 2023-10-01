import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // flutter_svg kütüphanesi
import 'package:intl/intl.dart';

class CategoryModel {
  final String name;
  final String svgPath; // SVG dosyasının yolu
  final void Function(BuildContext context) onTap;

  CategoryModel({
    required this.name,
    required this.svgPath,
    required this.onTap,
  });
}
