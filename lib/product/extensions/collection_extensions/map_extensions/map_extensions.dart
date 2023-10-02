/// [Map] EXTENSION
extension MapExtension<T, M> on Map<T, M>? {
  /// Returns true if map is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns true if map is not null or not empty
  bool get isNotNullAndNotEmpty => this != null && this!.isNotEmpty;
}
