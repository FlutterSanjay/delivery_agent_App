import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class Warehouse with CustomDropdownListFilter {
  final String id; // warehouse ID
  final String name; // Warehouse Name
  final IconData icon;

  const Warehouse({required this.id, required this.name, this.icon = Icons.warehouse});

  @override
  String toString() => name;

  factory Warehouse.fromMap(Map<String, dynamic> map) {
    return Warehouse(
      id: map['warehouseId'], // ✅ API me "warehouseId"
      name: map['warehouseName'], // ✅ API me "warehouseName"
    );
  }
  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}
