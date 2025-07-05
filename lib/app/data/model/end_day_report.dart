// lib/models/end_of_day_report_model.dart
import 'daily_summary_model.dart';
import 'inventory_item.dart';

class EndOfDayReport {
  final DailySummary dailySummary;
  final List<InventoryItem> remainingInventory;

  EndOfDayReport({required this.dailySummary, required this.remainingInventory});
}
