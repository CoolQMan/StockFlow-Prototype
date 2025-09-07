import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../models/sample_skus.dart';
import '../models/sku_item.dart';
import 'package:lottie/lottie.dart';

class ARScannerScreen extends StatefulWidget {
  const ARScannerScreen({super.key});

  @override
  State<ARScannerScreen> createState() => _ARScannerScreenState();
}

class _ARScannerScreenState extends State<ARScannerScreen> {
  CameraController? _controller;
  bool _isInitialized = false;
  SKUItem? _scanned;
  bool _showLottie = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        // Auto-detect after 3 seconds
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _scanned = sampleSKUs.first;
              _showLottie = true;
            });
            // hide after short delay
            Future.delayed(const Duration(milliseconds: 900), () {
              if (mounted) setState(() => _showLottie = false);
            });
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildInsightRow(String label, String value) {
    return Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
                fontSize: 14,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.keyboard),
            onPressed: () {
              // Manual SKU entry
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Enter SKU'),
                  content: const TextField(
                    decoration: InputDecoration(hintText: 'Enter SKU code'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('SKU entered manually')),
                        );
                      },
                      child: const Text('Search'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          if (_isInitialized && _controller != null)
            CameraPreview(_controller!)
          else
            const Center(child: CircularProgressIndicator()),
          // Overlay
          Center(
            child: Container(
              width: 250,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Scan SKU',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Scan result overlay (shows selected SKU from sample data)
          if (_scanned != null)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Card(
                color: const Color.fromRGBO(0, 0, 0, 0.8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SKU Detected: ${_scanned!.sku}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Lottie success overlay
                      if (_showLottie)
                        Center(
                          child: SizedBox(
                            width: 160,
                            height: 160,
                            child: Lottie.asset(
                              'assets/lottie/scan_success.json',
                              repeat: false,
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),
                      Text(
                        _scanned!.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildInsightRow('Price:', '₹1,200'),
                      _buildInsightRow(
                        'Stock:',
                        '${_scanned!.daysInStock > 0 ? (100 - _scanned!.daysInStock).toString() : '0'} units',
                      ),
                      _buildInsightRow(
                        'Last Sold:',
                        '${_scanned!.daysInStock} days ago',
                      ),
                      _buildInsightRow('Turnover:', '${_scanned!.turnover}x'),
                      _buildInsightRow(
                        'Sell-through:',
                        '${_scanned!.sellThrough}%',
                      ),
                      _buildInsightRow(
                        'Days in Stock:',
                        '${_scanned!.daysInStock} days',
                      ),
                      const SizedBox(height: 12),
                      if (_scanned!.daysInStock > 60)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 152, 0, 0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            '⚠️ Aging Inventory - Consider discount',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'insights',
        onPressed: () {
          // Show detailed insights
          showModalBottomSheet(
            context: context,
            backgroundColor: Theme.of(context).colorScheme.surface,
            builder: (context) => Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Insights',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInsightRow('Category:', 'Electronics'),
                  _buildInsightRow('Supplier:', 'TechCorp Ltd'),
                  _buildInsightRow('Cost Price:', '₹800'),
                  _buildInsightRow('Margin:', '33.3%'),
                  _buildInsightRow('Total Value:', '₹54,000'),
                  _buildInsightRow('Storage Cost:', '₹150/day'),
                  _buildInsightRow('Supplier Rating:', '4.5/5'),
                  _buildInsightRow('Reorder Point:', '10 units'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Discount applied: 25% off'),
                              ),
                            );
                          },
                          child: const Text('Apply Discount'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to liquidation list'),
                              ),
                            );
                          },
                          child: const Text('Liquidate'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.analytics),
      ),
    );
  }
}
