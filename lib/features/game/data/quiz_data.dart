import '../models/quiz_model.dart';

/// QuizData - Data Provider untuk Quiz
/// Mengikuti prinsip Parameterized
class QuizData {
  /// Get quiz berdasarkan kategori
  static QuizSession getQuizByCategory(String category) {
    switch (category.toLowerCase()) {
      case 'tari tradisional':
        return _getTariQuiz();
      case 'pakaian adat':
        return _getPakaianAdatQuiz();
      case 'rumah adat':
        return _getRumahAdatQuiz();
      case 'musik nusantara':
        return _getMusikNusantaraQuiz();
      default:
        return _getTariQuiz();
    }
  }

  /// Quiz Tari Tradisional
  static QuizSession _getTariQuiz() {
    return QuizSession(
      id: 'tari_001',
      title: 'Kuis Tari Tradisional',
      category: 'Tari Tradisional',
      totalQuestions: 10,
      imagePath: 'assets/images/pakaian_adat.png',
      questions: [
        QuizQuestion(
          id: 'tari_q1',
          question: 'Tarian tradisional apa yang ditarikan oleh wanita digambar tersebut?',
          options: [
            'a. Tari Piring',
            'b. Tari Topeng',
            'c. Tari Payung',
            'd. Tari Tarian',
          ],
          correctAnswerIndex: 1,
          category: 'Tari Tradisional',
        ),
        QuizQuestion(
          id: 'tari_q2',
          question: 'Dari mana asal tari Pendet?',
          options: [
            'a. Jawa Barat',
            'b. Bali',
            'c. Sumatera Barat',
            'd. Jawa Timur',
          ],
          correctAnswerIndex: 1,
          category: 'Tari Tradisional',
        ),
        QuizQuestion(
          id: 'tari_q3',
          question: 'Tari Saman berasal dari daerah?',
          options: [
            'a. Aceh',
            'b. Bali',
            'c. Jawa Tengah',
            'd. Papua',
          ],
          correctAnswerIndex: 0,
          category: 'Tari Tradisional',
        ),
        QuizQuestion(
          id: 'tari_q4',
          question: 'Tari Kecak biasanya ditarikan oleh berapa orang?',
          options: [
            'a. 10-20 orang',
            'b. 50-100 orang',
            'c. 5 orang',
            'd. 2 orang',
          ],
          correctAnswerIndex: 1,
          category: 'Tari Tradisional',
        ),
        QuizQuestion(
          id: 'tari_q5',
          question: 'Properti yang digunakan dalam Tari Piring adalah?',
          options: [
            'a. Selendang',
            'b. Piring',
            'c. Payung',
            'd. Keris',
          ],
          correctAnswerIndex: 1,
          category: 'Tari Tradisional',
        ),
        QuizQuestion(
          id: 'tari_q6',
          question: 'Tari Jaipong berasal dari provinsi?',
          options: [
            'a. Jawa Timur',
            'b. Jawa Barat',
            'c. Jawa Tengah',
            'd. Banten',
          ],
          correctAnswerIndex: 1,
          category: 'Tari Tradisional',
        ),
        QuizQuestion(
          id: 'tari_q7',
          question: 'Gerakan tari yang paling khas dari Tari Saman adalah?',
          options: [
            'a. Gerakan tangan',
            'b. Gerakan kaki',
            'c. Tepuk tangan kompak',
            'd. Putaran badan',
          ],
          correctAnswerIndex: 2,
          category: 'Tari Tradisional',
        ),
        QuizQuestion(
          id: 'tari_q8',
          question: 'Tari Reog berasal dari kota?',
          options: [
            'a. Ponorogo',
            'b. Surabaya',
            'c. Malang',
            'd. Kediri',
          ],
          correctAnswerIndex: 0,
          category: 'Tari Tradisional',
        ),
        QuizQuestion(
          id: 'tari_q9',
          question: 'Musik pengiring Tari Pendet biasanya menggunakan?',
          options: [
            'a. Angklung',
            'b. Gamelan',
            'c. Gendang',
            'd. Sasando',
          ],
          correctAnswerIndex: 1,
          category: 'Tari Tradisional',
        ),
        QuizQuestion(
          id: 'tari_q10',
          question: 'Tari Serimpi berasal dari daerah?',
          options: [
            'a. Yogyakarta',
            'b. Solo',
            'c. Keduanya benar',
            'd. Bali',
          ],
          correctAnswerIndex: 2,
          category: 'Tari Tradisional',
        ),
      ],
    );
  }

  /// Quiz Pakaian Adat
  static QuizSession _getPakaianAdatQuiz() {
    return QuizSession(
      id: 'pakaian_001',
      title: 'Kuis Pakaian Adat',
      category: 'Pakaian Adat',
      totalQuestions: 10,
      imagePath: 'assets/images/pakaian_adat.png',
      questions: [
        QuizQuestion(
          id: 'pakaian_q1',
          question: 'Pakaian adat Kebaya berasal dari daerah?',
          options: [
            'a. Jawa',
            'b. Sumatera',
            'c. Bali',
            'd. Papua',
          ],
          correctAnswerIndex: 0,
          category: 'Pakaian Adat',
        ),
        QuizQuestion(
          id: 'pakaian_q2',
          question: 'Ulos adalah pakaian adat dari?',
          options: [
            'a. Jawa Barat',
            'b. Sumatera Utara',
            'c. Sulawesi',
            'd. Kalimantan',
          ],
          correctAnswerIndex: 1,
          category: 'Pakaian Adat',
        ),
        // Tambahkan 8 pertanyaan lagi...
      ],
    );
  }

  /// Quiz Rumah Adat
  static QuizSession _getRumahAdatQuiz() {
    return QuizSession(
      id: 'rumah_001',
      title: 'Kuis Rumah Adat',
      category: 'Rumah Adat',
      totalQuestions: 10,
      imagePath: 'assets/images/rumah_adat.png',
      questions: [
        QuizQuestion(
          id: 'rumah_q1',
          question: 'Rumah Gadang berasal dari provinsi?',
          options: [
            'a. Jawa Barat',
            'b. Sumatera Barat',
            'c. Sumatera Utara',
            'd. Bali',
          ],
          correctAnswerIndex: 1,
          category: 'Rumah Adat',
        ),
        // Tambahkan pertanyaan lainnya...
      ],
    );
  }

  /// Quiz Musik Nusantara
  static QuizSession _getMusikNusantaraQuiz() {
    return QuizSession(
      id: 'musik_001',
      title: 'Kuis Musik Nusantara',
      category: 'Musik Nusantara',
      totalQuestions: 10,
      imagePath: 'assets/images/musik_nusantara.png',
      questions: [
        QuizQuestion(
          id: 'musik_q1',
          question: 'Angklung berasal dari daerah?',
          options: [
            'a. Jawa Timur',
            'b. Jawa Barat',
            'c. Bali',
            'd. Sumatera',
          ],
          correctAnswerIndex: 1,
          category: 'Musik Nusantara',
        ),
        // Tambahkan pertanyaan lainnya...
      ],
    );
  }

  /// Get semua kategori quiz yang tersedia
  static List<String> getAvailableCategories() {
    return [
      'Tari Tradisional',
      'Pakaian Adat',
      'Rumah Adat',
      'Musik Nusantara',
    ];
  }
}