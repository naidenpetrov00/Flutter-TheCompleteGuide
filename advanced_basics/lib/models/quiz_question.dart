class QuizQuestion {
  final String text;
  final List<String> answers;

  const QuizQuestion(this.text, this.answers);

  List<String> get shuffleAnswers {
    final copyAnswers = List.of(answers);
    copyAnswers.shuffle();
    return copyAnswers;
  }
}
