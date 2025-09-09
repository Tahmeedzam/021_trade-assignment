import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StockTable extends StatefulWidget {
  const StockTable({super.key});

  @override
  State<StockTable> createState() => _StockTableState();
}

class StockDataGridSource extends DataGridSource {
  late List<DataGridRow> dataGridRows;
  late List<String> _stockDataList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    throw UnimplementedError();
  }

  @override
  // TODO: implement rows
  List<DataGridRow> get rows => dataGridRows;
}

class _StockTableState extends State<StockTable> {
  List<dynamic> _all_clients = [];
  List<dynamic> _all_stocks = [];
  List<dynamic> _stockData = [];
  List clientAddedFilter = [];
  List stockAddedFilter = [];
  List<dynamic> _filteredData = [];
  int? _sortColumnIndex;
  bool _sortAscending = true;

  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
    getFullStockList();
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

  Future<void> getFullStockList() async {
    final String stockResponse = await rootBundle.loadString(
      'assets/stock_data.json',
    );
    final stockData = json.decode(stockResponse);

    setState(() {
      _stockData = stockData['StockData'];
      _filteredData = List.from(_stockData);
    });
  }

  void applyFilter() {
    setState(() {
      _filteredData = _stockData.where((row) {
        final client = row['client'].toString();
        final ticker = row['Ticker'].toString();

        final clientOk =
            clientAddedFilter.isEmpty || clientAddedFilter.contains(client);
        final tickerOk =
            stockAddedFilter.isEmpty || stockAddedFilter.contains(ticker);

        return clientOk && tickerOk;
      }).toList();
    });
  }

  void _sort<T>(
    Comparable<T> Function(dynamic row) getField,
    int columnIndex,
    bool ascending,
  ) {
    _filteredData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
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
            _filteredData.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: PaginatedDataTable(
                      header: const Text("Stock Data"),
                      rowsPerPage: 5,
                      columns: [
                        DataColumn(
                          label: const Text("Time"),
                          onSort: (i, asc) =>
                              _sort((row) => row['time'].toString(), i, asc),
                        ),
                        DataColumn(
                          label: const Text("Client"),
                          onSort: (i, asc) =>
                              _sort((row) => row['client'].toString(), i, asc),
                        ),
                        DataColumn(
                          label: const Text("Ticker"),
                          onSort: (i, asc) =>
                              _sort((row) => row['Ticker'].toString(), i, asc),
                        ),
                        const DataColumn(label: Text("Live")),
                        DataColumn(label: const Text("Side")),
                        DataColumn(label: const Text("Product")),
                        DataColumn(label: const Text("Qty")),
                        DataColumn(
                          label: const Text("Price"),
                          numeric: true,
                          onSort: (i, asc) =>
                              _sort((row) => row['Price'] as num, i, asc),
                        ),
                      ],
                      source: _StockDataSource(_filteredData),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class _StockDataSource extends DataTableSource {
  final List<dynamic> data;
  _StockDataSource(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final row = data[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(row['time'].toString())),
        DataCell(Text(row['client'].toString())),
        DataCell(Text(row['Ticker'].toString())),
        DataCell(
          Icon(
            row['isLive'] == true ? Icons.circle : Icons.circle_outlined,
            color: row['isLive'] == true ? Colors.green : Colors.red,
            size: 12,
          ),
        ),
        DataCell(Text(row['side'].toString())),
        DataCell(Text(row['Product'].toString())),
        DataCell(Text(row['Qty(Executed/Total)'].toString())),
        DataCell(Text(row['Price'].toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
