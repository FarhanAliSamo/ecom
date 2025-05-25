import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ecom/core/app_colors.dart';
import 'package:ecom/core/app_constants.dart';

class WishlistAmountCard extends StatelessWidget {
  final double productTotalAmount;
  final double discountAmount;
  final double discountAmountTotal;

  const WishlistAmountCard({
    super.key,
    required this.productTotalAmount,
    required this.discountAmount,
    required this.discountAmountTotal,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final formatter = NumberFormat.simpleCurrency(decimalDigits: 2);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkScaffold : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRow(
            title: 'Total Amount',
            value: formatter.format(productTotalAmount),
            color: AppColors.descriptionText,
            isDark: isDark,
          ),
          _buildRow(
            title: 'Discount',
            value: '- ${formatter.format(discountAmount)}',
            color: Colors.red,
            isDark: isDark,
          ),
          const Divider(height: 20),
          _buildRow(
            title: 'Final Amount',
            value: formatter.format(discountAmountTotal),
            color: AppColors.primary,
            isDark: isDark,
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required String title,
    required String value,
    required Color color,
    required bool isDark,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: AppConstants.fontPoppins,
              fontSize: AppConstants.small,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              color: isDark
                  ? AppColors.darkDescriptionText
                  : AppColors.descriptionText,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: AppConstants.fontPoppins,
              fontSize: AppConstants.small,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
