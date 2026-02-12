import '../models/quiz_model.dart';

/// QuizData - Data Provider untuk Quiz
/// Mengikuti prinsip Parameterized
/// Support MIX soal dengan gambar dan tanpa gambar
class QuizData {
  /// Get quiz berdasarkan kategori
  static QuizSession getQuizByCategory(String category) {
    switch (category.toLowerCase()) {
      case 'tari tradisional':
      case 'tarian tradisional':
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

  /// Quiz Tari Tradisional - MIX soal dengan & tanpa gambar
  static QuizSession _getTariQuiz() {
    return QuizSession(
      id: 'tari_001',
      title: 'Kuis Tari Tradisional',
      category: 'Tari Tradisional',
      totalQuestions: 10,
      imagePath: 'assets/images/pakaian_adat.png',
      questions: [
        // ✅ Soal 1: DENGAN GAMBAR
        QuizQuestion(
          id: 'tari_q1',
          question: 'Tarian tradisional apa yang ditarikan oleh wanita di gambar tersebut?',
          options: [
            'a. Tari Piring',
            'b. Tari Topeng',
            'c. Tari Payung',
            'd. Tari Gambyong',
          ],
          correctAnswerIndex: 1,
          category: 'Tari Tradisional',
          imageUrl: 'assets/images/pakaian_adat.png', // ADA GAMBAR
        ),

        // ❌ Soal 2: TANPA GAMBAR (text only)
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
          // imageUrl: null, // TIDAK ADA GAMBAR (dihilangkan atau null)
        ),

        // ❌ Soal 3: TANPA GAMBAR (text only)
        QuizQuestion(
          id: 'tari_q3',
          question: 'Tari Saman berasal dari daerah mana?',
          options: [
            'a. Aceh',
            'b. Bali',
            'c. Jawa Tengah',
            'd. Papua',
          ],
          correctAnswerIndex: 0,
          category: 'Tari Tradisional',
          // TIDAK ADA imageUrl
        ),

        // ✅ Soal 4: DENGAN GAMBAR
        QuizQuestion(
          id: 'tari_q4',
          question: 'Tarian pada gambar biasanya ditarikan oleh berapa orang?',
          options: [
            'a. 10-20 orang',
            'b. 50-100 orang',
            'c. 5 orang',
            'd. 2 orang',
          ],
          correctAnswerIndex: 1,
          category: 'Tari Tradisional',
          imageUrl: 'assets/images/rumah_adat.png', // ADA GAMBAR
        ),

        // ❌ Soal 5: TANPA GAMBAR
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

        // ❌ Soal 6: TANPA GAMBAR
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

        // ❌ Soal 7: TANPA GAMBAR
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

        // ✅ Soal 8: DENGAN GAMBAR
        QuizQuestion(
          id: 'tari_q8',
          question: 'Tarian pada gambar berasal dari kota?',
          options: [
            'a. Ponorogo',
            'b. Surabaya',
            'c. Malang',
            'd. Kediri',
          ],
          correctAnswerIndex: 0,
          category: 'Tari Tradisional',
          imageUrl: 'assets/images/musik_nusantara.png', // ADA GAMBAR
        ),

        // ❌ Soal 9: TANPA GAMBAR
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

        // ❌ Soal 10: TANPA GAMBAR
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

  /// Quiz Pakaian Adat - MIX soal
  static QuizSession _getPakaianAdatQuiz() {
    return QuizSession(
      id: 'pakaian_001',
      title: 'Kuis Pakaian Adat',
      category: 'Pakaian Adat',
      totalQuestions: 10,
      imagePath: 'assets/images/pakaian_adat.png',
      questions: [
        // DENGAN GAMBAR
        QuizQuestion(
          id: 'pakaian_q1',
          question: 'Pakaian adat pada gambar berasal dari daerah?',
          options: [
            'a. Jawa',
            'b. Sumatera',
            'c. Bali',
            'd. Papua',
          ],
          correctAnswerIndex: 0,
          category: 'Pakaian Adat',
          imageUrl: 'assets/images/pakaian_adat.png',
        ),

        // TANPA GAMBAR
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

        // TANPA GAMBAR
        QuizQuestion(
          id: 'pakaian_q3',
          question: 'Songket adalah kain tradisional dari?',
          options: [
            'a. Palembang',
            'b. Jakarta',
            'c. Bali',
            'd. Makassar',
          ],
          correctAnswerIndex: 0,
          category: 'Pakaian Adat',
        ),

        // DENGAN GAMBAR
        QuizQuestion(
          id: 'pakaian_q4',
          question: 'Nama pakaian adat pada gambar adalah?',
          options: [
            'a. Baju Bodo',
            'b. Kebaya',
            'c. Ulos',
            'd. Koteka',
          ],
          correctAnswerIndex: 1,
          category: 'Pakaian Adat',
          imageUrl: 'assets/images/pakaian_adat.png',
        ),

        // TANPA GAMBAR
        QuizQuestion(
          id: 'pakaian_q5',
          question: 'Baju Kurung berasal dari daerah?',
          options: [
            'a. Riau',
            'b. Jawa Tengah',
            'c. Bali',
            'd. NTT',
          ],
          correctAnswerIndex: 0,
          category: 'Pakaian Adat',
        ),

        // Tambahkan 5 soal lagi sesuai kebutuhan...
      ],
    );
  }

  /// Quiz Rumah Adat - MIX soal
  static QuizSession _getRumahAdatQuiz() {
    return QuizSession(
      id: 'rumah_001',
      title: 'Kuis Rumah Adat',
      category: 'Rumah Adat',
      totalQuestions: 10,
      imagePath: 'assets/images/rumah_adat.png',
      questions: [
        // DENGAN GAMBAR
        QuizQuestion(
          id: 'rumah_q1',
          question: 'Rumah adat pada gambar berasal dari provinsi?',
          options: [
            'a. Jawa Barat',
            'b. Sumatera Barat',
            'c. Sumatera Utara',
            'd. Bali',
          ],
          correctAnswerIndex: 1,
          category: 'Rumah Adat',
          imageUrl: 'assets/images/rumah_adat.png',
        ),

        // TANPA GAMBAR
        QuizQuestion(
          id: 'rumah_q2',
          question: 'Rumah Tongkonan berasal dari?',
          options: [
            'a. Papua',
            'b. Sulawesi Selatan',
            'c. Kalimantan',
            'd. Maluku',
          ],
          correctAnswerIndex: 1,
          category: 'Rumah Adat',
        ),

        // Tambahkan soal lainnya...
      ],
    );
  }

  /// Quiz Musik Nusantara - MIX soal
  static QuizSession _getMusikNusantaraQuiz() {
    return QuizSession(
      id: 'musik_001',
      title: 'Kuis Musik Nusantara',
      category: 'Musik Nusantara',
      totalQuestions: 10,
      imagePath: 'assets/images/musik_nusantara.png',
      questions: [
        // TANPA GAMBAR
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

        // DENGAN GAMBAR
        QuizQuestion(
          id: 'musik_q2',
          question: 'Alat musik pada gambar bernama?',
          options: [
            'a. Gamelan',
            'b. Angklung',
            'c. Sasando',
            'd. Kolintang',
          ],
          correctAnswerIndex: 0,
          category: 'Musik Nusantara',
          imageUrl: 'assets/images/musik_nusantara.png',
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