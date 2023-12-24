import 'package:flutter/material.dart';

@immutable
final class AutomationKey<Automation> extends ValueKey<Automation> {
  const AutomationKey(super.value);
}
