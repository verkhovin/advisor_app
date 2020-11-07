class Suggestion {
  final int id;
  final String name;
  final double userAverage;
  final double allAverage;

  Suggestion(this.id, this.name, this.userAverage, this.allAverage);

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      json['id'], json['nameEng'], json['currentUserAverage'], json['allUsersAverage']
    );
  }
}