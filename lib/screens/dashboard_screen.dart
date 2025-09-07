import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/bottom_nav_bar.dart';
import 'finance_dashboard.dart';
import 'aging_inventory_screen.dart';
import 'actionable_playbooks_screen.dart';
import 'alerts_screen.dart';
import 'conversational_analytics_screen.dart';
import 'ar_scanner_screen.dart';
import 'dropshipper_dashboard.dart';
import 'retailer_dashboard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final role = provider.selectedRole;

    List<Widget> screens = [];

    if (role == UserRole.owner ||
        role == UserRole.planner ||
        role == UserRole.associate) {
      screens = [
        const FinanceDashboard(),
        const AgingInventoryScreen(),
        const ActionablePlaybooksScreen(),
        const AlertsScreen(),
        const ConversationalAnalyticsScreen(),
        const ARScannerScreen(),
      ];
    } else if (role == UserRole.dropshipper) {
      screens = [
        const DropshipperDashboard(),
        const AgingInventoryScreen(),
        const ActionablePlaybooksScreen(),
        const AlertsScreen(),
        const ConversationalAnalyticsScreen(),
        const ARScannerScreen(),
      ];
    } else if (role == UserRole.retailer) {
      screens = [
        const RetailerDashboard(),
        const AgingInventoryScreen(),
        const ActionablePlaybooksScreen(),
        const AlertsScreen(),
        const ConversationalAnalyticsScreen(),
        const ARScannerScreen(),
      ];
    }

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
