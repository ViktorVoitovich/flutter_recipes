import 'steps.dart';

class AnalyzedInstructions {
  String name;
  List<Steps> steps;

  AnalyzedInstructions({this.name, this.steps});

  factory AnalyzedInstructions.fromJson(Map<String, dynamic> json) {
    return AnalyzedInstructions(
      name: json['name'] as String,
      steps: (json['steps'] as List<dynamic>)
          ?.map((step) => step == null
              ? null
              : Steps.fromJson(step as Map<String, dynamic>))
          ?.toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'steps': steps?.map((step) => step?.toJson())?.toList(),
    };
  }
}
