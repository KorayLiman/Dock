import 'package:intl/intl.dart';

/// [DateTime] Extension
extension DateTimeExtension on DateTime {
  String get toddMMyyyyHHmm => DateFormat('dd.MM.yyyy HH:mm').format(this);
}
