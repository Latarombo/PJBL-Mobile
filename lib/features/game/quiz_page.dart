import 'package:flutter/material.dart';
import 'models/quiz_model.dart';
import 'data/quiz_data.dart';
import 'widgets/quiz_option_card.dart';
import '../../../shared/theme/app_colors.dart';

class QuizPage extends StatefulWidget {
  final String category;

  const QuizPage({
    super.key,
    this.category = 'Tari Tradisional',
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // State Management
  late QuizSession quizSession;
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool isAnswered = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    quizSession = QuizData.getQuizByCategory(widget.category);
  }

  QuizQuestion get currentQuestion =>
      quizSession.questions[currentQuestionIndex];

  // Method untuk handle pilihan jawaban
  void selectAnswer(int index) {
    if (!isAnswered) {
      setState(() {
        selectedAnswerIndex = index;
      });
    }
  }

  // Method untuk submit jawaban (saat tombol Lanjut pertama kali ditekan)
  void submitAnswer() {
    if (selectedAnswerIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Silakan pilih jawaban terlebih dahulu'),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    setState(() {
      isAnswered = true;
      // Cek apakah jawaban benar
      if (selectedAnswerIndex == currentQuestion.correctAnswerIndex) {
        score++;
      }
    });
  }

  // Method untuk lanjut ke pertanyaan berikutnya
  void nextQuestion() {
    if (currentQuestionIndex < quizSession.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        isAnswered = false;
      });
    } else {
      // Quiz selesai, tampilkan hasil
      _showResultDialog();
    }
  }

  // Method untuk handle tombol Lanjut
  void handleNext() {
    if (isAnswered) {
      nextQuestion();
    } else {
      submitAnswer();
    }
  }

  // Dialog hasil quiz
  void _showResultDialog() {
    final result = QuizResult(
      correctAnswers: score,
      totalQuestions: quizSession.totalQuestions,
      pointsEarned: score * 10,
      completedAt: DateTime.now(),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: result.percentage >= 70
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.warning.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  result.percentage >= 70
                      ? Icons.emoji_events
                      : Icons.refresh,
                  size: 40,
                  color: result.percentage >= 70
                      ? AppColors.success
                      : AppColors.warning,
                ),
              ),

              const SizedBox(height: 20),

              // Title
              Text(
                result.grade,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 12),

              // Score
              Text(
                'Skor: ${result.correctAnswers}/${result.totalQuestions}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),

              const SizedBox(height: 8),

              // Percentage
              Text(
                'Persentase: ${result.percentage.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 8),

              // Points
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: AppColors.accent, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '+${result.pointsEarned} Poin',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        _resetQuiz();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Ulang Quiz',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        Navigator.pop(context); // Back to home
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.dark,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Selesai',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reset quiz
  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswerIndex = null;
      isAnswered = false;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          quizSession.category,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'menu',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text(
                    '${currentQuestionIndex + 1} dari ${quizSession.totalQuestions}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (currentQuestionIndex + 1) /
                            quizSession.totalQuestions,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.accent,
                        ),
                        minHeight: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Image (placeholder dengan decorasi)
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: AppColors.accentGreen,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            quizSession.imagePath ??
                                'assets/images/pakaian_adat.png',
                          ),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {},
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.1),
                              Colors.black.withValues(alpha: 0.3),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Question Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        currentQuestion.question,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Options - Reusable QuizOptionCard
                    ...List.generate(
                      currentQuestion.options.length,
                      (index) => QuizOptionCard(
                        optionText: currentQuestion.options[index],
                        isSelected: selectedAnswerIndex == index,
                        isCorrect: isAnswered &&
                            index == currentQuestion.correctAnswerIndex,
                        isWrong: isAnswered &&
                            selectedAnswerIndex == index &&
                            index != currentQuestion.correctAnswerIndex,
                        isAnswered: isAnswered,
                        onTap: () => selectAnswer(index),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Button Lanjut
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: handleNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedAnswerIndex != null
                              ? AppColors.dark
                              : AppColors.disabled,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          isAnswered ? 'Lanjut' : 'Konfirmasi',
                          style: TextStyle(
                            color: selectedAnswerIndex != null
                                ? Colors.white
                                : AppColors.onDisabled,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}