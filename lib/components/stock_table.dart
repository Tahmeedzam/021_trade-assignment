import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class StockTable extends StatefulWidget {
  const StockTable({super.key});

  @override
  State<StockTable> createState() => _StockTableState();
}

class _StockTableState extends State<StockTable> {
  List<dynamic> _all_clients = [];
  List<dynamic> _all_stocks = [];
  List clientAddedFilter = [];
  List stockAddedFilter = [];
  // List<String> _data = [];
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String clientResponse = await rootBundle.loadString(
      'assets/clients.json',
    );
    final clientData = json.decode(clientResponse);
    setState(() {
      _all_clients = clientData["clients"];
    });

    //For stock
    final String stockResponse = await rootBundle.loadString(
      'assets/stock_data.json',
    );
    final stockData = json.decode(stockResponse);
    setState(() {
      _all_stocks = stockData["StockData"];
    });
  }

  List<dynamic> getClientSuggestion(String query) {
    return _all_clients.where((element) {
      final name = element['clientName'].toString().toLowerCase();
      final id = element['clientId'].toString().toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input) || id.contains(input);
    }).toList();
  }

  List<dynamic> getStockSuggestion(String query) {
    return _all_stocks.where((element) {
      final Ticker = element['Ticker'].toString().toLowerCase();
      final input = query.toLowerCase();
      return Ticker.contains(input);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(63),
              blurRadius: 5.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            ExpansionTile(
              title: Text(
                'Clients',
                style: TextStyle(
                  fontFamily: 'josh',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xff18181b),
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: clientAddedFilter.map((client) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffE4E4E7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              client,
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  clientAddedFilter.remove(client);
                                });
                              },
                              child: Icon(Icons.close, size: 14),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TypeAheadField<dynamic>(
                              builder: (context, controller, focusNode) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    autofocus: false,

                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Search client Id',
                                      labelStyle: TextStyle(
                                        fontFamily: 'josh',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemBuilder: (context, dynamic suggestions) {
                                return ListTile(
                                  tileColor: Color(0xffF4F4F5),
                                  title: Text(suggestions['clientName']),
                                  subtitle: Text(suggestions['clientId']),
                                );
                              },
                              onSelected: (value) {
                                setState(() {
                                  _clientController.text = value['clientId'];
                                  clientAddedFilter.add(value['clientName']);
                                });
                              },
                              suggestionsCallback: (String search) {
                                return getClientSuggestion(search);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          clientAddedFilter = [];
                        });
                      },
                      child: Text(
                        'Clear all',
                        style: TextStyle(
                          fontFamily: 'josh',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffdc2626),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),

            //Stocks Drop down
            ExpansionTile(
              title: Text(
                'Stocks',
                style: TextStyle(
                  fontFamily: 'josh',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Color(0xff18181b),
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: stockAddedFilter.map((stock) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffE4E4E7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              stock,
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  stockAddedFilter.remove(stock);
                                });
                              },
                              child: Icon(Icons.close, size: 14),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: TypeAheadField<dynamic>(
                              builder: (context, controller, focusNode) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: TextField(
                                    controller: controller,
                                    focusNode: focusNode,
                                    autofocus: false,

                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText:
                                          'Seach for stocks, future, options or index',
                                      labelStyle: TextStyle(
                                        fontFamily: 'josh',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemBuilder: (context, dynamic suggestions) {
                                return ListTile(
                                  tileColor: Color(0xffF4F4F5),
                                  title: Text(suggestions['Ticker']),
                                );
                              },
                              onSelected: (value) {
                                setState(() {
                                  // _stockController.text = value['clientName'];
                                  stockAddedFilter.add(value['Ticker']);
                                });
                              },
                              suggestionsCallback: (String search) {
                                return getStockSuggestion(search);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          stockAddedFilter = [];
                        });
                      },
                      child: Text(
                        'Clear all',
                        style: TextStyle(
                          fontFamily: 'josh',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffdc2626),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      clientAddedFilter = [];

                      stockAddedFilter = [];
                    });
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 3.7,
                    decoration: BoxDecoration(
                      color: Color(0xffdc2626),

                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(63),
                          blurRadius: 4.0,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 5),
                        Icon(Icons.cancel, color: Color(0xfffffefe)),
                        SizedBox(width: 2),
                        Text(
                          'Cancel all',
                          style: TextStyle(
                            fontFamily: 'josh',
                            color: Color(0xfffffefe),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
