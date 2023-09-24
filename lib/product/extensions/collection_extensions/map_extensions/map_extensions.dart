extension MapExtension on Map<dynamic, dynamic>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullAndNotEmpty => this != null && this!.isNotEmpty;
}
