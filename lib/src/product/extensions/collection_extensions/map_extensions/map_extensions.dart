/// [Map] EXTENSION
extension MapExtension<T, M> on Map<T, M>? {
  /// Returns true if map is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns true if map is not null or not empty
  bool get isNotNullAndNotEmpty => this != null && this!.isNotEmpty;

  /// Returns true if map doesn't contain given key
  bool notContainsKey(T? key) {
    if (this == null || key == null) return true;
    return !this!.containsKey(key);
  }

  /// Returns true if map doesn't contain given value
  bool notContainsValue(M? value) {
    if (this == null || value == null) return true;
    return !this!.containsValue(value);
  }
}
