import 'package:flutter/material.dart';

class SmallStockPriceCard extends StatelessWidget {
  final String stockName;
  final double stockPrice;

  const SmallStockPriceCard({
    super.key,
    required this.stockName,
    required this.stockPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            stockName,
            style: const TextStyle(
              fontFamily: 'josh',
              fontWeight: FontWeight.w400,
              color: Color(0xff18181b),
              fontSize: 16,
            ),
          ),
          Text(
            stockPrice.toStringAsFixed(2),
            style: const TextStyle(
              fontFamily: 'josh',
              fontWeight: FontWeight.w300,
              color: Color(0xff25894b),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
