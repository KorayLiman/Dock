import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter/src/typedefs.dart';
import 'package:flutter/material.dart';

import 'register_strategy.dart';

part 'locator_impl.dart';

@visibleForTesting

/// Creates new Locator instance for testing only
// ignore: non_constant_identifier_names,  library_private_types_in_public_api
_LocatorImpl get TestLocator => _LocatorImpl();

/// Global instance of [_LocatorImpl] class
// ignore: non_constant_identifier_names
final Locator = _LocatorImpl();

/// [LocatorException]
@immutable
final class LocatorException implements Exception {
  const LocatorException({required this.message});

  final String message;

  @override
  String toString() => message;
}
