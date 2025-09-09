import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trade021_assignment/components/small_stock_price_card.dart';

class AllStockPrices extends StatefulWidget {
  const AllStockPrices({super.key});

  @override
  State<AllStockPrices> createState() => _AllStockPricesState();
}

class _AllStockPricesState extends State<AllStockPrices> {
  List _all_stocks = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString(
      'assets/stock_price_data.json',
    );
    final data = json.decode(response);
    setState(() {
      _all_stocks = data["stocks"];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _all_stocks.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width / 2.5,
            padding: const EdgeInsets.all(8),
            child: SmallStockPriceCard(
              stockName: _all_stocks[index]["stockName"],
              stockPrice: (_all_stocks[index]["stockPrice"] as num).toDouble(),
            ),
          );
        },
      ),
    );
  }
}
