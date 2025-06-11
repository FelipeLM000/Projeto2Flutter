import 'summary_card.dart';
import 'summary_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SummaryCarousel extends StatefulWidget {
  /// Total income amount
  final double totalIncome;

  /// Total expense amount
  final double totalExpense;

  const SummaryCarousel({})
  
}







class _SummaryCarouselState extends State<SummaryCarousel>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  
  }