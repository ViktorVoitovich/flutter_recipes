class Steps {
  int number;
  String step;

  Steps({
    this.number,
    this.step,
  });

  factory Steps.fromJson(Map<String, dynamic> json) {
    return Steps(
      number: json['number'] as int,
      step: json['step'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'step': step,
    };
  }
}
