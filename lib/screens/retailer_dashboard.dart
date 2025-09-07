import 'package:flutter/material.dart';
import 'cart_screen.dart';

class RetailerDashboard extends StatelessWidget {
  const RetailerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retailer Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Browse Surplus by Category',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('Electronics'),
                subtitle: const Text('MOQ: 10 pcs | Starting ₹800'),
                trailing: const Chip(label: Text('10 pcs')),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                title: const Text('Clothing'),
                subtitle: const Text('MOQ: 25 pcs | Starting ₹300'),
                trailing: const Chip(label: Text('25 pcs')),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const CartScreen()));
                },
                child: const Text('View Cart & Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
