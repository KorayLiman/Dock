final class ObserverError implements Exception {
  const ObserverError();
  @override
  String toString() {
    return '''
      You did not insert any observables in Observer
      ''';
  }
}
