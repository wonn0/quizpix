class Question {
  final String? url;
  final String? quiz;
  final String type;
  final String question;
  final String answer;
  final List<String>? choices;

  const Question(
      this.url, this.quiz, this.type, this.question, this.answer, this.choices);

  Question.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        quiz = json['quiz'],
        type = json['type'],
        question = json['question'],
        answer = json['answer'],
        choices = json['choices'];

  Map<String, dynamic> toJson() => {
        'url': url,
        'quiz': quiz,
        'type': type,
        'question': question,
        'answer': answer,
        'choices': choices,
      };
}
