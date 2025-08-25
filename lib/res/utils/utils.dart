import 'package:e_commerce/res/components/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatIndianCurrency(double amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    );

    return formatter.format(amount);
  }

 static String getOrderStatus(String status) {
    switch (status) {
      case "0":
        return "Pending";
      case "1":
        return "Confirmed";
      case "2":
        return "Out for Delivery";
      case "3":
        return "Delivered";
      case "4":
        return "Cancelled";
      default:
        return "Pending";
    }
  }

  static Color getOrderStatusColor(String status) {
    switch (status) {
      case "0": // Pending
        return Colors.orange;
      case "1": // Confirmed
        return Colors.blue;
      case "2": // Out for Delivery
        return Colors.purple;
      case "3": // Delivered
        return Colors.green;
      case "4": // Cancelled
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

   static IconData getThemeIcon(AppThemeMode theme) {
    switch (theme) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  static String getThemeDisplayName(AppThemeMode theme) {
    switch (theme) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System';
    }
  }
}
