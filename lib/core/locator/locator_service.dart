import 'package:dock/core/dock/dock_main.dart';
import 'package:dock/product/extensions/object_extensions/object_extensions.dart';
import 'package:dock/typedefs.dart';
import 'package:flutter/material.dart';

part 'locator_impl.dart';

/// Global instance of [_LocatorImpl] class
// ignore: non_constant_identifier_names
final Locator = _LocatorImpl();

/// [_LocatorException]
@immutable
final class _LocatorException implements Exception {
  const _LocatorException({required this.message});

  final String message;

  @override
  String toString() => message;
}
