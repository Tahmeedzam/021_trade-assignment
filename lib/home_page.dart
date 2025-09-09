import 'package:flutter/material.dart';

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
                      'Lalit Kumar',
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
        body: Column(children: [
            
          ],
        ),
      ),
    );
  }
}
