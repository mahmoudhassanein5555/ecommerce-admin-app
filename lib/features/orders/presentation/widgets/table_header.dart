import 'package:ecommerce_admin_app/core/constants/app_colors.dart';
import 'package:ecommerce_admin_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(AppStrings.orderIdLabel, style: _headerTextStyle),
          ),
          Expanded(
            flex: 2,
            child: Text(AppStrings.dateLabel, style: _headerTextStyle),
          ),
          Expanded(
            flex: 3,
            child: Text(AppStrings.customerLabel, style: _headerTextStyle),
          ),
          Expanded(
            flex: 2,
            child: Text(AppStrings.amountLabel, style: _headerTextStyle),
          ),
          Expanded(
            flex: 2,
            child: Text(AppStrings.paymentLabel, style: _headerTextStyle),
          ),
          Expanded(
            flex: 2,
            child: Text(AppStrings.statusLabel, style: _headerTextStyle),
          ),
          SizedBox(
            width: 84,
            child: Text(AppStrings.actionsLabel, style: _headerTextStyle),
          ),
        ],
      ),
    );
  }
}

const _headerTextStyle = TextStyle(
  fontSize: 12,
  letterSpacing: 1.2,
  fontWeight: FontWeight.w700,
  color: AppColors.tableHeaderText,
);
