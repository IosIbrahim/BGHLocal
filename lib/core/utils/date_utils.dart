import 'package:easy_localization/easy_localization.dart';

extension DateTimeFormat on DateTime {
  String toFormattedDate() {
    return DateFormat("d MMMM yyyy").format(this); // For "16 March 2025"
  }

  String toFormattedTime() {
    return DateFormat("hh:mm a").format(this); // For "08:00 AM" or "08:00 PM"
  }
}
