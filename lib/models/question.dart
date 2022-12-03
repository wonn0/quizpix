class Question {
  final int type;
  final String question;
  final String answer;
  final List<String>? choices;

  const Question(this.type, this.question, this.answer, this.choices);
}