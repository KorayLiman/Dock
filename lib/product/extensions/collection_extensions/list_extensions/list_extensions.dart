extension ListExtension on List<dynamic>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullAndNotEmpty => this != null && this!.isNotEmpty;

  bool notContains(Object? object) {
    if (this == null || object == null) return true;
    return !this!.contains(object);
  }
}
