import 'package:flutter/material.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/budget_bar_widget.dart';
import '../../widgets/scan_button_widget.dart';
import '../../widgets/basket_preview_widget.dart';
import '../../widgets/bottom_nav_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  // Mock data for demonstration
  final String userName = 'Shivam';
  final bool isSyncActive = true;
  final double currentSpending = 1250.50;
  final double budgetLimit = 2000.00;

  // Mock basket items
  final List<BasketItem> basketItems = [
    BasketItem(name: 'Organic Milk 1L', price: 65.00, quantity: 2),
    BasketItem(name: 'Whole Wheat Bread', price: 45.00, quantity: 1),
    BasketItem(name: 'Fresh Apples (1kg)', price: 180.00, quantity: 1),
    BasketItem(name: 'Greek Yogurt', price: 120.00, quantity: 3),
    BasketItem(name: 'Orange Juice 1L', price: 95.00, quantity: 1),
  ];

  void _handleScanButton() {
    // Placeholder for future barcode scanning functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Scan feature coming soon! 📱'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });

    // Show placeholder messages for other tabs
    if (index == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Shared Cart view coming soon! 🛒'),
          duration: Duration(seconds: 2),
        ),
      );
    } else if (index == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('QR Pass for paperless exit coming soon! 🎫'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with greeting and sync status
                    HeaderWidget(
                      userName: userName,
                      isSyncActive: isSyncActive,
                    ),

                    const SizedBox(height: 24),

                    // Budget Bar
                    BudgetBarWidget(
                      currentSpending: currentSpending,
                      budgetLimit: budgetLimit,
                    ),

                    const SizedBox(height: 24),

                    // Scan Button - Main Action
                    ScanButtonWidget(onPressed: _handleScanButton),

                    const SizedBox(height: 24),

                    // Shared Basket Preview
                    BasketPreviewWidget(items: basketItems),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            BottomNavWidget(
              currentIndex: _currentNavIndex,
              onTap: _handleNavTap,
            ),
          ],
        ),
      ),
    );
  }
}
