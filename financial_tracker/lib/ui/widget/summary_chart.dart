import 'package:flutter/material.dart';


import '../../common/utils/formatter.dart';

///Widget to display financial data in chart form
class SummaryChart extends StatelessWidget {
  /// Total income amount
  final double totalIncome;

  /// Total Expensive amount
  final double totalExpense;

  /// Map containing transactions separated by type
  ///final Map<String, List<TransactionEntity>> transactions;

  const SummaryChart({
    super.key,
    required this.totalIncome,
    required this.totalExpense,
    //required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Chart title
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                Icons.pie_chart,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                'Receitas vs. Despesas',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
              ),
            ],
          ),
        ),

        //Choose between pie chart and bar chart based on data avaibability
        if (totalIncome == 0 && totalExpense == 0)
          _buildEmptyState(context)
        else
          Container(
            height: 160,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Pie chart section
                Expanded(flex: 3, child: _buildPieChart(context)),
                const SizedBox(width: 10),
                // Legend section
              ],
            )
          )
      ],
    );
  }
}