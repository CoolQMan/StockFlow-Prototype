class SKUItem {
  final String sku;
  final String name;
  final DateTime lastSold;
  final int daysInStock;
  final double turnover;
  final double sellThrough;

  SKUItem({
    required this.sku,
    required this.name,
    required this.lastSold,
    required this.daysInStock,
    required this.turnover,
    required this.sellThrough,
  });
}
