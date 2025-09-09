import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:trade021_assignment/components/all_stock_prices.dart';
import 'package:trade021_assignment/components/small_stock_price_card.dart';
import 'package:trade021_assignment/components/stock_table.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xffffffff),
          leading: GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Image(image: AssetImage('assets/images/tradeLogo.png')),
            ),
          ),
          title: Text(
            "PORTFOLIO",
            style: TextStyle(fontFamily: 'josh', fontWeight: FontWeight.w600),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Color(0xffF4F4F5),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xffE4E4E7),
                      child: Text(
                        'LK',
                        style: TextStyle(
                          fontFamily: 'josh',
                          fontSize: 24,
                          color: Color(0xff18181b),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Lalit K',
                      style: TextStyle(
                        color: Color(0xff18181b),
                        fontSize: 24,
                        fontFamily: 'josh',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text(
                  'MARKETWATCH',
                  style: TextStyle(
                    color: Color(0xff18181b),
                    fontSize: 16,
                    fontFamily: 'josh',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'EXCHANGE FILES',
                  style: TextStyle(
                    color: Color(0xff18181b),
                    fontSize: 16,
                    fontFamily: 'josh',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_down),
                title: const Text(
                  'PORTFOLIO',
                  style: TextStyle(
                    color: Color(0xff18181b),
                    fontSize: 16,
                    fontFamily: 'josh',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_down),
                title: const Text(
                  'FUNDS',
                  style: TextStyle(
                    color: Color(0xff18181b),
                    fontSize: 16,
                    fontFamily: 'josh',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color(0xffF4F4F5),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                AllStockPrices(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Open Orders',
                        style: TextStyle(
                          fontFamily: 'josh',
                          color: Color(0xff18181b),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3.7,
                        decoration: BoxDecoration(
                          color: Color(0xffE4E4E7),

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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.file_download_outlined,
                              size: 20,
                              color: Color(0xff18181b),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'Download',
                                style: TextStyle(
                                  fontFamily: 'josh',
                                  color: Color(0xff18181b),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //
                SizedBox(height: 5),
                StockTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
