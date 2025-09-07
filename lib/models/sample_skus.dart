import 'sku_item.dart';

final List<SKUItem> sampleSKUs = [
  SKUItem(
    sku: 'WH-001',
    name: 'Wireless Headphones',
    lastSold: DateTime.now().subtract(const Duration(days: 45)),
    daysInStock: 45,
    turnover: 0.8,
    sellThrough: 65.0,
  ),
  SKUItem(
    sku: 'SW-002',
    name: 'Smart Watch',
    lastSold: DateTime.now().subtract(const Duration(days: 120)),
    daysInStock: 120,
    turnover: 0.3,
    sellThrough: 25.0,
  ),
  SKUItem(
    sku: 'BS-003',
    name: 'Bluetooth Speaker',
    lastSold: DateTime.now().subtract(const Duration(days: 75)),
    daysInStock: 75,
    turnover: 0.6,
    sellThrough: 45.0,
  ),
  SKUItem(
    sku: 'GM-004',
    name: 'Gaming Mouse',
    lastSold: DateTime.now().subtract(const Duration(days: 90)),
    daysInStock: 90,
    turnover: 0.4,
    sellThrough: 35.0,
  ),
  SKUItem(
    sku: 'UC-005',
    name: 'USB Cable',
    lastSold: DateTime.now().subtract(const Duration(days: 30)),
    daysInStock: 30,
    turnover: 1.2,
    sellThrough: 80.0,
  ),
];
