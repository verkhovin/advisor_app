class PlanStatusScreenData {
  final Summary summary;
  final List<CategoryPlan> categories;

  PlanStatusScreenData(this.summary, this.categories);

  factory PlanStatusScreenData.fromJson(Map<String, dynamic> json) {
    return PlanStatusScreenData(
        Summary(json['summary']['spent'], json['summary']['planned']),
        (json['categories'] as List).map((e) =>
            CategoryPlan(e['name'], e['spent'], e['planned'], e['status'])).toList());
  }
}

class Summary {
  final double spent;
  final double planned;

  Summary(this.spent, this.planned);
}

class CategoryPlan {
  final String name;
  final double spent;
  final double planned;
  final String status;

  CategoryPlan(this.name, this.spent, this.planned, this.status);
}
