import 'package:flutter/material.dart';
import 'package:round_1/core/text_styles.dart';
import 'package:intl/intl.dart';

class FinanceCard extends StatelessWidget {
  const FinanceCard({super.key, required this.results});

  final Map<String, dynamic> results;

  @override
  Widget build(BuildContext context) {
    String paymentFrequency = results['payment_frequency'];
    int multiplyingFactor = paymentFrequency == 'weekly' ? 52 : 12;

    double fundingAmount = results['funding_amount'];
    double desiredFeesPercentage = results['desired_fee_percentage']; // 0.6
    double feesPercentage = results['fees_percentage'];
    double revenueAmount = results['revenue_amount'];
    double fees = fundingAmount * desiredFeesPercentage;
    double totalRevenueShare = fundingAmount + fees;

    double expectedTransfers = 0;
    if (revenueAmount > 0 && feesPercentage > 0) {
      expectedTransfers = (totalRevenueShare * multiplyingFactor) /
          (revenueAmount * (feesPercentage / 100));
    }

    int expectedTransfersInt =
        expectedTransfers.isFinite ? expectedTransfers.ceil() : 0;

    DateTime currentDate = DateTime.now();
    Duration durationToAdd = (paymentFrequency == "weekly")
        ? Duration(days: expectedTransfersInt * 7) // Weekly payments
        : Duration(days: expectedTransfersInt * 30); // Monthly payments
    DateTime expectedCompletionDate = currentDate.add(durationToAdd);

    int days = results['repayment_delay'] == '30 days'
        ? 30
        : results['repayment_delay'] == '60 days'
            ? 60
            : results['repayment_delay'] == '90 days'
                ? 90
                : 0;

    expectedCompletionDate = expectedCompletionDate
        .add(Duration(days: days)); // Adding repayment delay

    // Formatting date as "Month d, yyyy"
    String formattedCompletionDate =
        DateFormat("MMMM d, yyyy").format(expectedCompletionDate);

    // computing APR
    // Expected APR = (((desired_fee_percentage*funding_amount)/funding_amount)/[(Expected Completion - Today) in days])x365X100

    double aprNumerator =
        (desiredFeesPercentage * fundingAmount) / fundingAmount;
    int daysUntilCompletion =
        expectedCompletionDate.difference(currentDate).inDays;
    double aprDenominator =
        daysUntilCompletion.toDouble(); // Convert to double for calculation

    double finalApr = ((aprNumerator / aprDenominator) * 365) * 100;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Results', style: AppTextStyles.subTitle),
          const SizedBox(height: 20),
          CardItem(
            itemKey: "Annual Business Revenue",
            itemValue: '\$${revenueAmount.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 10),
          CardItem(
            itemKey: "Funding Amount",
            itemValue: '\$${fundingAmount.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 10),
          CardItem(
            itemKey: "Fees",
            itemValue: '(${(desiredFeesPercentage * 100)}%) '
                '\$${fees.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 10),
          CardItem(
              itemKey: "Expected APR",
              itemValue: '${finalApr.toStringAsFixed(2)}%'),
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
