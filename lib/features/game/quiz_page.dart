import 'package:flutter/material.dart';
import 'dart:async';
import 'models/quiz_model.dart';
import 'data/quiz_data.dart';
import 'widgets/quiz_option_card.dart';
import '../../shared/theme/app_colors.dart';

class QuizPage extends StatefulWidget {
  final String category;

  const QuizPage({super.key, this.category = 'Tari Tradisional'});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // State Management
  late QuizSession quizSession;
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  bool isAnswered = false;
  int correctAnswers = 0;
  int totalPoints = 0;
  int streak = 0; // combo benar berturut-turut

  Timer? _autoAdvanceTimer;

  @override
  void initState() {
    super.initState();
    quizSession = QuizData.getQuizByCategory(widget.category);
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    super.dispose();
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

  // Method untuk handle tombol Lanjut (sekarang jadi submit dan auto-advance)
  void handleNext() {
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

      if (selectedAnswerIndex == currentQuestion.correctAnswerIndex) {
        correctAnswers++;
        streak++;

        int basePoint = 10;
        int bonus = streak >= 3 ? 5 : 0; // bonus jika benar 3x berturut
        totalPoints += basePoint + bonus;
      } else {
        streak = 0; // reset combo jika salah
      }
    });

    _autoAdvanceTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) {
        _nextQuestion();
      }
    });
  }

  // Method untuk lanjut ke pertanyaan berikutnya
  void _nextQuestion() {
    if (currentQuestionIndex < quizSession.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        isAnswered = false;
      });
    } else {
      _showResultDialog();
    }
  }

  // Dialog hasil quiz
  void _showResultDialog() {
    final result = QuizResult(
      correctAnswers: correctAnswers,
      totalQuestions: quizSession.totalQuestions,
      pointsEarned: totalPoints,
      completedAt: DateTime.now(),
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                  result.percentage >= 70 ? Icons.emoji_events : Icons.refresh,
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
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),

              const SizedBox(height: 8),

              // Percentage
              Text(
                'Persentase: ${result.percentage.toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
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
                        Navigator.pop(context);
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
                        Navigator.pop(context);
                        Navigator.pop(context);
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
    _autoAdvanceTimer?.cancel();

    setState(() {
      currentQuestionIndex = 0;
      selectedAnswerIndex = null;
      isAnswered = false;
      correctAnswers = 0;
      totalPoints = 0;
      streak = 0;
    });
  }

  // Dialog konfirmasi restart
  void _showRestartDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Ulang Quiz?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          'Semua progress akan hilang. Apakah Anda yakin ingin mengulang quiz dari awal?',
          style: TextStyle(color: Colors.grey[700]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _resetQuiz();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.dark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Ya, Ulang',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
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
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            offset: const Offset(0, 50),
            onSelected: (value) {
              switch (value) {
                case 'restart':
                  _showRestartDialog();
                  break;
                case 'exit':
                  Navigator.pop(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'restart',
                child: Row(
                  children: [
                    Icon(Icons.refresh, size: 20, color: AppColors.textPrimary),
                    SizedBox(width: 12),
                    Text('Ulang Quiz'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'exit',
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                    SizedBox(width: 12),
                    Text('Keluar'),
                  ],
                ),
              ),
            ],
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
                        value:
                            (currentQuestionIndex + 1) /
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

            // Main Content - Scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // ✅ CONDITIONAL IMAGE - Hanya tampil jika soal punya gambar
                    if (currentQuestion.hasImage) ...[
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          color: AppColors.accentGreen,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(currentQuestion.imageUrl!),
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
                    ],

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

                    // Options
                    ...List.generate(
                      currentQuestion.options.length,
                      (index) => QuizOptionCard(
                        optionText: currentQuestion.options[index],
                        isSelected: selectedAnswerIndex == index,
                        isCorrect:
                            isAnswered &&
                            index == currentQuestion.correctAnswerIndex,
                        isWrong:
                            isAnswered &&
                            selectedAnswerIndex == index &&
                            index != currentQuestion.correctAnswerIndex,
                        isAnswered: isAnswered,
                        onTap: () => selectAnswer(index),
                      ),
                    ),

                    // Extra space untuk scroll agar konten tidak tertutup tombol
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),

            // Button Lanjut - Fixed di bottom
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isAnswered ? null : handleNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedAnswerIndex != null
                        ? AppColors.dark
                        : AppColors.disabled,
                    disabledBackgroundColor: AppColors.disabled,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Lanjut',
                    style: TextStyle(
                      color: selectedAnswerIndex != null && !isAnswered
                          ? Colors.white
                          : AppColors.onDisabled,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
