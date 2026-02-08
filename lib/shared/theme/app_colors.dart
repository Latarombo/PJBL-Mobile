import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const primary = Color(	0xfff9f4e4);
  static const onPrimary = Color(0xffffffff);
  static const background = Color(0xFFF9F4E4);
  static final surface = Colors.grey[300]!;

  // Text
  static const textPrimary = Color(0xff270f0f);
  static const textSecondary = Color(0xffffffff);
  static const textDisabled = Color(0xFF9E9E9E);
  

  // Neutral / Dark
  static const dark = Color(0xFF1A2332); //untuk warna tombol utama
  static const onDark = Colors.white; // untuk warna teks pada tombol utama

  // Accent
  static const danger = Color(0xFFD32F2F);
  static const onDanger = Colors.white;

  // Borders & Outlines
  static const outline = Color(0xFFDDDDDD);
  static const disabled = Color(0xFFE0E0E0);
  static const onDisabled = Color(0xFF9E9E9E);

  // Feedback (sementara)
  static const error = Colors.red;
  static const warning = Colors.orange;
  static const success = Colors.green;
  static const info = Colors.blue;
}
