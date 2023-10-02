/// [Set] EXTENSION
extension SetExtension<T> on Set<T>? {
  /// Returns true if set is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns true if set is not null or not empty
  bool get isNotNullAndNotEmpty => this != null && this!.isNotEmpty;
}
