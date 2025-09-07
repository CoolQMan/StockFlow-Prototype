import 'package:flutter/material.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class RoleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final UserRole role;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.icon,
    required this.role,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define gradient based on role
    LinearGradient cardGradient;
    switch (role) {
      case UserRole.owner:
        cardGradient = AppTheme.primaryGradient;
        break;
      case UserRole.planner:
        cardGradient = AppTheme.secondaryGradient;
        break;
      case UserRole.associate:
        cardGradient = AppTheme.purpleGradient;
        break;
      case UserRole.dropshipper:
        cardGradient = AppTheme.tealGradient;
        break;
      case UserRole.retailer:
        cardGradient = AppTheme.orangeGradient;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: cardGradient.colors.first.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with background
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(icon, size: 32, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
