import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';

/// QuizOptionCard - Reusable Widget
/// Widget card pilihan jawaban yang bisa dipakai ulang untuk semua soal
class QuizOptionCard extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final bool isAnswered;
  final VoidCallback onTap;

  const QuizOptionCard({
    super.key,
    required this.optionText,
    required this.isSelected,
    required this.isCorrect,
    required this.isWrong,
    required this.isAnswered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Tentukan warna background berdasarkan state
    Color backgroundColor = AppColors.surfaceWhite;
    Color borderColor = const Color(0xFFE0E0E0);
    Color textColor = AppColors.textPrimary;
    IconData? icon;

    if (isAnswered) {
      if (isCorrect) {
        backgroundColor = AppColors.success;
        borderColor = AppColors.success.withValues(alpha: 0.8);
        textColor = Colors.white;
        icon = Icons.check_circle;
      } else if (isWrong) {
        backgroundColor = AppColors.error;
        borderColor = AppColors.error.withValues(alpha: 0.8);
        textColor = Colors.white;
        icon = Icons.cancel;
      }
    } else if (isSelected) {
      backgroundColor = const Color(0xFFE3F2FD); // Biru muda
      borderColor = const Color(0xFF2196F3);
    }

    return GestureDetector(
      onTap: isAnswered ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            if (icon != null)
              Icon(icon, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }
}