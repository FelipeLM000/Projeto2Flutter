import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
    final double totalIncome;

    final double totalExpense;

    final double balance;

    const SummaryCard({
        super.key,
        required this.totalIncome,
        required this.totalExpense,
        required this.balance,
    })

    @override
    Widget build(BuildContext context) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.all(16),
            child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                        colors: [
                            colorScheme.primary.withValues(alpha: 0.7),
                            colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                    ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                )
            ),
        );
    }
}