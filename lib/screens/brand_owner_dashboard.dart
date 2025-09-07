import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BrandOwnerDashboard extends StatelessWidget {
  const BrandOwnerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Brand Owner Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Liquidation Channels',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 40,
                      title: 'B2B',
                      color: Colors.blue,
                    ),
                    PieChartSectionData(
                      value: 35,
                      title: 'B2C Thrift',
                      color: Colors.green,
                    ),
                    PieChartSectionData(
                      value: 25,
                      title: 'Donation',
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Tier 2/3 Reach',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              color: Colors.grey[300],
              child: const Center(
                child: Text(
                  'Dummy Map\nHighlighted Cities: Mumbai, Delhi, Bangalore',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
