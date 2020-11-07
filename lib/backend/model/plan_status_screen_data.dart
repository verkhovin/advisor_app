class PlanStatusScreenData {
  final Summary summary;
  final List<CategoryPlan> categories;

  PlanStatusScreenData(this.summary, this.categories);

  factory PlanStatusScreenData.fromJson(Map<String, dynamic> json) {
    return PlanStatusScreenData(
        Summary(json['summary']['spent'], json['summary']['planned']),
        (json['category'] as List).map((e) =>
            CategoryPlan(e['id'], e['name'], e['spent'], e['planned'], e['status'])).toList());
  }

  Map<String, dynamic> toJson() =>
      {
        'summary': null,
        'category': this.categories.map((c) => {
          'id': c.id,
          'planned': c.planned
        }).toList(),
      };
}

class Summary {
  final double spent;
  double planned;

  Summary(this.spent, this.planned);
}

class CategoryPlan {
  final int id;
  final String name;
  final double spent;
  double planned;
  final String status;

  CategoryPlan(this.id, this.name, this.spent, this.planned, this.status);
}
