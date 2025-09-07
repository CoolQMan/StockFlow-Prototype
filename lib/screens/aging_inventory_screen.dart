import 'package:flutter/material.dart';
import '../models/sku_item.dart';
import '../models/sample_skus.dart';
// ...existing code...

class AgingInventoryScreen extends StatefulWidget {
  const AgingInventoryScreen({super.key});

  @override
  State<AgingInventoryScreen> createState() => _AgingInventoryScreenState();
}

class _AgingInventoryScreenState extends State<AgingInventoryScreen> {
  String _filter = 'all';
  int? _customMin;
  int? _customMax;

  // Use shared sample SKUs
  List<SKUItem> get _items => List.from(sampleSKUs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aging Inventory')),
      body: Column(
        children: [
          // Filter buttons
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 4),
                  FilterChip(
                    label: const Text('All'),
                    selected: _filter == 'all',
                    onSelected: (selected) {
                      if (selected) setState(() => _filter = 'all');
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('30 Days'),
                    selected: _filter == '30',
                    onSelected: (selected) {
                      if (selected) setState(() => _filter = '30');
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('60 Days'),
                    selected: _filter == '60',
                    onSelected: (selected) {
                      if (selected) setState(() => _filter = '60');
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('90 Days'),
                    selected: _filter == '90',
                    onSelected: (selected) {
                      if (selected) setState(() => _filter = '90');
                    },
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: Text(
                      _filter == 'custom' &&
                              _customMin != null &&
                              _customMax != null
                          ? 'Custom ($_customMin-$_customMax)'
                          : 'Custom',
                    ),
                    selected: _filter == 'custom',
                    onSelected: (selected) async {
                      if (selected) {
                        // open custom range dialog
                        final result = await showDialog<List<int>?>(
                          context: context,
                          builder: (context) {
                            final minController = TextEditingController();
                            final maxController = TextEditingController();
                            return AlertDialog(
                              title: const Text('Custom range (days)'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: minController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Min days',
                                    ),
                                  ),
                                  TextField(
                                    controller: maxController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Max days',
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, null),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    final min = int.tryParse(
                                      minController.text,
                                    );
                                    final max = int.tryParse(
                                      maxController.text,
                                    );
                                    if (min == null ||
                                        max == null ||
                                        min > max) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Enter a valid min and max (min <= max)',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    Navigator.pop(context, [min, max]);
                                  },
                                  child: const Text('Apply'),
                                ),
                              ],
                            );
                          },
                        );
                        if (result != null && result.length == 2) {
                          setState(() {
                            _customMin = result[0];
                            _customMax = result[1];
                            _filter = 'custom';
                          });
                        }
                      } else {
                        setState(() => _filter = 'all');
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
          // Table header - removed as it's no longer a table
          // Items list
          Expanded(
            child: ListView.builder(
              itemCount: (() {
                final list = _items.where((s) {
                  final days = s.daysInStock;
                  if (_filter == 'all') return true;
                  if (_filter == '30') return days <= 30;
                  if (_filter == '60') return days > 30 && days <= 60;
                  if (_filter == '90') return days > 60 && days <= 90;
                  if (_filter == 'custom' &&
                      _customMin != null &&
                      _customMax != null)
                    return days >= _customMin! && days <= _customMax!;
                  return true;
                }).toList();
                return list.length;
              })(),
              itemBuilder: (context, index) {
                final filtered = _items.where((s) {
                  final days = s.daysInStock;
                  if (_filter == 'all') return true;
                  if (_filter == '30') return days <= 30;
                  if (_filter == '60') return days > 30 && days <= 60;
                  if (_filter == '90') return days > 60 && days <= 90;
                  if (_filter == 'custom' &&
                      _customMin != null &&
                      _customMax != null)
                    return days >= _customMin! && days <= _customMax!;
                  return true;
                }).toList();
                final item = filtered[index];
                return TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: item.daysInStock <= 30
                            ? LinearGradient(
                                colors: [
                                  const Color(
                                    0xFF10B981,
                                  ).withValues(alpha: 0.08),
                                  const Color(
                                    0xFF059669,
                                  ).withValues(alpha: 0.04),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : item.daysInStock <= 60
                            ? LinearGradient(
                                colors: [
                                  const Color(
                                    0xFFF59E0B,
                                  ).withValues(alpha: 0.08),
                                  const Color(
                                    0xFFD97706,
                                  ).withValues(alpha: 0.04),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  const Color(
                                    0xFFEF4444,
                                  ).withValues(alpha: 0.08),
                                  const Color(
                                    0xFFDC2626,
                                  ).withValues(alpha: 0.04),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: item.daysInStock <= 30
                              ? const Color(0xFF10B981).withValues(alpha: 0.2)
                              : item.daysInStock <= 60
                              ? const Color(0xFFF59E0B).withValues(alpha: 0.2)
                              : const Color(0xFFEF4444).withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            // Thumbnail with subtle gradient
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.1),
                                    Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.05),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  item.name
                                      .split(' ')
                                      .map((s) => s[0])
                                      .take(2)
                                      .join(),
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Last sold: ${item.lastSold.day}/${item.lastSold.month}/${item.lastSold.year}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.6),
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 4,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: item.daysInStock <= 30
                                              ? const Color(
                                                  0xFF10B981,
                                                ).withValues(alpha: 0.1)
                                              : item.daysInStock <= 60
                                              ? const Color(
                                                  0xFFF59E0B,
                                                ).withValues(alpha: 0.1)
                                              : const Color(
                                                  0xFFEF4444,
                                                ).withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: item.daysInStock <= 30
                                                ? const Color(
                                                    0xFF10B981,
                                                  ).withValues(alpha: 0.3)
                                                : item.daysInStock <= 60
                                                ? const Color(
                                                    0xFFF59E0B,
                                                  ).withValues(alpha: 0.3)
                                                : const Color(
                                                    0xFFEF4444,
                                                  ).withValues(alpha: 0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          '${item.daysInStock} days',
                                          style: TextStyle(
                                            color: item.daysInStock <= 30
                                                ? const Color(0xFF065F46)
                                                : item.daysInStock <= 60
                                                ? const Color(0xFF92400E)
                                                : const Color(0xFF991B1B),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceContainerHighest
                                              .withValues(alpha: 0.3),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          '${item.sellThrough}% sell-through',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.8),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceContainerHighest
                                              .withValues(alpha: 0.3),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          '${item.turnover}x turnover',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.8),
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Redesigned bottom sheet
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  builder: (_) => Container(
                                    padding: const EdgeInsets.all(20),
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          'SKU: ${item.sku}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Days in Stock: ${item.daysInStock}',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Sell-through: ${item.sellThrough}%',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Turnover: ${item.turnover}x',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                        const SizedBox(height: 16),
                                        const Text(
                                          'Actions:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Apply Discount'),
                                        ),
                                        const SizedBox(height: 8),
                                        OutlinedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Liquidate'),
                                        ),
                                        const Spacer(),
                                        Align(
                                          alignment: Alignment.center,
                                          child: TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('Close'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.more_vert,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
