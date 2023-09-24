/// LIST EXTENSION
extension ListExtension on List<dynamic>? {
  /// Returns true if list is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns true if list is not null or not empty
  bool get isNotNullAndNotEmpty => this != null && this!.isNotEmpty;

  /// Returns true if list doesn't contain given object
  bool notContains(Object? object) {
    if (this == null || object == null) return true;
    return !this!.contains(object);
  }
}
