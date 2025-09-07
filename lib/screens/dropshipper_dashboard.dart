import 'package:flutter/material.dart';

class DropshipperDashboard extends StatelessWidget {
  const DropshipperDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dropshipper Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Surplus Items',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('Wireless Headphones'),
                subtitle: const Text('Profit: 25% | Price: ₹1,200'),
                trailing: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Listed to Shopify!')),
                    );
                  },
                  child: const Text('List to Shopify'),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: const Text('Smart Watch'),
                subtitle: const Text('Profit: 30% | Price: ₹2,500'),
                trailing: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Listed to Shopify!')),
                    );
                  },
                  child: const Text('List to Shopify'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
