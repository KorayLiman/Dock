/// [ObserverError] while no Observable detected inside Observer Widget
final class ObserverError extends Error {
  ObserverError();

  @override
  String toString() {
    return '''
      You did not insert any observables in Observer
      ''';
  }
}
