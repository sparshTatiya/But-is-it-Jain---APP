class ScanResult {
  final List<String> jain;
  final List<String> nonJain;
  final List<String> uncertain;

  ScanResult({
    required this.jain,
    required this.nonJain,
    required this.uncertain,
  });

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      jain: List<String>.from(json['jain_ingredients'] ?? []),
      nonJain: List<String>.from(json['non_jain_ingredients'] ?? []),
      uncertain: List<String>.from(json['uncertain_ingredients'] ?? []),
    );
  }
}
