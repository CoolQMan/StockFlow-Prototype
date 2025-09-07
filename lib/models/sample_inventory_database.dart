// Sample Inventory Database for AI Analytics
class SampleInventoryDatabase {
  static const Map<String, dynamic> inventoryData = {
    "products": [
      {
        "id": "SW001",
        "name": "Smart Watch Series X",
        "category": "Electronics",
        "sku": "SW001-BLK",
        "purchasePrice": 2500,
        "sellingPrice": 4500,
        "currentStock": 15,
        "lastSold": "2024-08-15",
        "daysInStock": 45,
        "sellThroughRate": 0.75,
        "turnoverRate": 2.1,
        "blockedCash": 67500,
        "supplier": "TechCorp Ltd",
        "location": "Warehouse A",
      },
      {
        "id": "WE002",
        "name": "Wireless Earbuds Pro",
        "category": "Electronics",
        "sku": "WE002-WHT",
        "purchasePrice": 1200,
        "sellingPrice": 2800,
        "currentStock": 8,
        "lastSold": "2024-07-20",
        "daysInStock": 120,
        "sellThroughRate": 0.45,
        "turnoverRate": 1.2,
        "blockedCash": 22400,
        "supplier": "AudioTech Inc",
        "location": "Warehouse B",
      },
      {
        "id": "LP003",
        "name": "Leather Wallet Premium",
        "category": "Accessories",
        "sku": "LP003-BRN",
        "purchasePrice": 800,
        "sellingPrice": 1800,
        "currentStock": 25,
        "lastSold": "2024-09-01",
        "daysInStock": 15,
        "sellThroughRate": 0.85,
        "turnoverRate": 3.2,
        "blockedCash": 45000,
        "supplier": "LeatherWorks",
        "location": "Warehouse A",
      },
      {
        "id": "TS004",
        "name": "Cotton T-Shirt Basic",
        "category": "Clothing",
        "sku": "TS004-BLU",
        "purchasePrice": 300,
        "sellingPrice": 800,
        "currentStock": 50,
        "lastSold": "2024-08-25",
        "daysInStock": 30,
        "sellThroughRate": 0.65,
        "turnoverRate": 1.8,
        "blockedCash": 40000,
        "supplier": "FashionHub",
        "location": "Warehouse C",
      },
      {
        "id": "BK005",
        "name": "Programming Book - Flutter",
        "category": "Books",
        "sku": "BK005-FLT",
        "purchasePrice": 400,
        "sellingPrice": 900,
        "currentStock": 12,
        "lastSold": "2024-06-15",
        "daysInStock": 180,
        "sellThroughRate": 0.25,
        "turnoverRate": 0.8,
        "blockedCash": 10800,
        "supplier": "TechBooks Ltd",
        "location": "Warehouse B",
      },
      {
        "id": "PH006",
        "name": "Smartphone Case Silicone",
        "category": "Accessories",
        "sku": "PH006-CLR",
        "purchasePrice": 150,
        "sellingPrice": 400,
        "currentStock": 40,
        "lastSold": "2024-09-05",
        "daysInStock": 5,
        "sellThroughRate": 0.95,
        "turnoverRate": 4.5,
        "blockedCash": 16000,
        "supplier": "PhoneAccessories",
        "location": "Warehouse A",
      },
      {
        "id": "HD007",
        "name": "Bluetooth Headphones",
        "category": "Electronics",
        "sku": "HD007-BLK",
        "purchasePrice": 1800,
        "sellingPrice": 3500,
        "currentStock": 6,
        "lastSold": "2024-07-10",
        "daysInStock": 135,
        "sellThroughRate": 0.35,
        "turnoverRate": 1.0,
        "blockedCash": 21000,
        "supplier": "AudioTech Inc",
        "location": "Warehouse B",
      },
      {
        "id": "BG008",
        "name": "Backpack Laptop 15\"",
        "category": "Accessories",
        "sku": "BG008-GRY",
        "purchasePrice": 1200,
        "sellingPrice": 2800,
        "currentStock": 18,
        "lastSold": "2024-08-20",
        "daysInStock": 35,
        "sellThroughRate": 0.70,
        "turnoverRate": 2.5,
        "blockedCash": 50400,
        "supplier": "BagMasters",
        "location": "Warehouse C",
      },
    ],
    "categories": [
      {
        "name": "Electronics",
        "totalProducts": 3,
        "totalBlockedCash": 110900,
        "avgSellThrough": 0.52,
        "avgTurnover": 1.43,
      },
      {
        "name": "Accessories",
        "totalProducts": 3,
        "totalBlockedCash": 111400,
        "avgSellThrough": 0.83,
        "avgTurnover": 3.4,
      },
      {
        "name": "Clothing",
        "totalProducts": 1,
        "totalBlockedCash": 40000,
        "avgSellThrough": 0.65,
        "avgTurnover": 1.8,
      },
      {
        "name": "Books",
        "totalProducts": 1,
        "totalBlockedCash": 10800,
        "avgSellThrough": 0.25,
        "avgTurnover": 0.8,
      },
    ],
    "warehouses": [
      {
        "name": "Warehouse A",
        "totalProducts": 3,
        "totalBlockedCash": 128500,
        "capacity": 1000,
        "utilization": 0.75,
      },
      {
        "name": "Warehouse B",
        "totalProducts": 3,
        "totalBlockedCash": 54200,
        "capacity": 800,
        "utilization": 0.65,
      },
      {
        "name": "Warehouse C",
        "totalProducts": 2,
        "totalBlockedCash": 90400,
        "capacity": 600,
        "utilization": 0.85,
      },
    ],
    "analytics": {
      "totalBlockedCash": 269100,
      "totalProducts": 8,
      "avgSellThroughRate": 0.64,
      "avgTurnoverRate": 2.16,
      "agingBreakdown": {
        "0-30_days": 3,
        "31-60_days": 2,
        "61-90_days": 1,
        "91-120_days": 1,
        "120+_days": 1,
      },
      "topBlockedCashCategories": [
        "Accessories",
        "Electronics",
        "Clothing",
        "Books",
      ],
    },
  };

  // Get formatted data for AI context
  static String getFormattedDatabase() {
    return '''
INVENTORY DATABASE:

PRODUCTS:
${inventoryData['products']!.map((product) => '''
- ${product['name']} (${product['category']})
  SKU: ${product['sku']}
  Stock: ${product['currentStock']} units
  Days in Stock: ${product['daysInStock']}
  Sell-through Rate: ${(product['sellThroughRate'] * 100).toInt()}%
  Turnover Rate: ${product['turnoverRate']}x
  Blocked Cash: ₹${product['blockedCash']}
  Last Sold: ${product['lastSold']}
  Location: ${product['location']}
''').join()}

CATEGORIES SUMMARY:
${inventoryData['categories']!.map((category) => '''
- ${category['name']}: ${category['totalProducts']} products, ₹${category['totalBlockedCash']} blocked
''').join()}

WAREHOUSES:
${inventoryData['warehouses']!.map((warehouse) => '''
- ${warehouse['name']}: ${warehouse['totalProducts']} products, ₹${warehouse['totalBlockedCash']} blocked
''').join()}

OVERALL ANALYTICS:
- Total Blocked Cash: ₹${inventoryData['analytics']['totalBlockedCash']}
- Total Products: ${inventoryData['analytics']['totalProducts']}
- Average Sell-through: ${(inventoryData['analytics']['avgSellThroughRate'] * 100).toInt()}%
- Average Turnover: ${inventoryData['analytics']['avgTurnoverRate']}x

AGING BREAKDOWN:
${inventoryData['analytics']['agingBreakdown'].entries.map((entry) => '- ${entry.key.replaceAll('_', ' ')}: ${entry.value} products').join('\n')}
''';
  }
}
