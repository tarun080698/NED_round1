import 'package:flutter/material.dart';
import 'package:round_1/core/text_styles.dart';
import 'package:intl/intl.dart';

class FinanceCard extends StatelessWidget {
  const FinanceCard({super.key, required this.results});

  final Map<String, dynamic> results;

  @override
  Widget build(BuildContext context) {
    String paymentFrequency = results['payment_frequency'] ?? 'monthly';
    int multiplyingFactor = paymentFrequency == 'weekly' ? 52 : 12;

    double fundingAmount = results['funding_amount'];
    double feesPercentage = results['desired_fee_percentage'];
    double revenueAmount = results['revenue_amount'];
    print({fundingAmount, feesPercentage});
    double fees = fundingAmount * feesPercentage;
    double totalRevenueShare = fundingAmount + fees;

    double expectedTransfersA = totalRevenueShare * multiplyingFactor;
    double expectedTransfersB = revenueAmount * feesPercentage;
    double expectedTransfers = (expectedTransfersB != 0)
        ? (expectedTransfersA / expectedTransfersB)
        : 0;

    DateTime currentDate = DateTime.now();

    DateTime expectedCompletionDate = (paymentFrequency == "weekly")
        ? currentDate.add(Duration(days: expectedTransfers.toInt() * 7))
        : currentDate.add(Duration(days: expectedTransfers.toInt() * 30));

    int days = results['repayment_delay'] == '30 days'
        ? 30
        : results['repayment_delay'] == '60 days'
            ? 60
            : results['repayment_delay'] == '90 days'
                ? 90
                : 0;

    expectedCompletionDate = expectedCompletionDate
        .add(Duration(days: days)); // ✅ Add repayment delay

    // ✅ Format date as "Month d, yyyy"
    String formattedCompletionDate =
        DateFormat("MMMM d, yyyy").format(expectedCompletionDate);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // ✅ Move `color` inside `BoxDecoration`
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Results', style: AppTextStyles.subTitle),
          const SizedBox(height: 20), // ✅ Fix spacing issue
          CardItem(
            itemKey: "Annual Business Revenue",
            itemValue: '\$${revenueAmount.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 10), // ✅ Proper spacing
          CardItem(
            itemKey: "Funding Amount",
            itemValue: '\$${fundingAmount.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 10),
          CardItem(
            itemKey: "Fees",
            itemValue: '(${(feesPercentage * 100)}%) '
                '\$${fees.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 10),
          CardItem(
            itemKey: "Total Revenue Share",
            itemValue: '\$${totalRevenueShare.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 10),
          CardItem(
            itemKey: "Expected transfers",
            itemValue: expectedTransfers.toStringAsFixed(0),
          ),
          const SizedBox(height: 10),
          CardItem(
            itemKey: "Expected completion date",
            itemValue: formattedCompletionDate,
            highlight: true,
          ),
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem(
      {required this.itemKey,
      required this.itemValue,
      this.highlight = false,
      super.key});
  final String itemKey;
  final String itemValue;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(itemKey, style: AppTextStyles.bodyTextMedium),
        Text(itemValue,
            style: AppTextStyles.bodyTextMedium
                .copyWith(color: highlight ? Colors.blue : Colors.black)),
      ],
    );
  }
}
