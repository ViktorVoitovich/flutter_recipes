import 'analyzed_instructions.dart';

class Recipe {
  double healthScore;
  int id;
  String title;
  int readyInMinutes;
  int servings;
  String image;
  String summary;
  List<AnalyzedInstructions> analyzedInstructions;

  Recipe({
    this.healthScore,
    this.id,
    this.title,
    this.image,
    this.readyInMinutes,
    this.servings,
    this.analyzedInstructions,
    this.summary,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      healthScore: json['healthScore'] as double,
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      summary: json['summary'] as String,
      readyInMinutes: json['readyInMinutes'] as int,
      servings: json['servings'] as int,
      analyzedInstructions: (json['analyzedInstructions'] as List<dynamic>)
          ?.map((instructions) => instructions == null
              ? null
              : AnalyzedInstructions.fromJson(
                  instructions as Map<String, dynamic>))
          ?.toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'healthScore': healthScore,
      'id': id,
      'title': title,
      'readyInMinutes': readyInMinutes,
      'servings': servings,
      'image': image,
      'summary': summary,
      'analyzedInstructions': analyzedInstructions
          ?.map((instructions) => instructions?.toJson())
          ?.toList(),
    };
  }
}
