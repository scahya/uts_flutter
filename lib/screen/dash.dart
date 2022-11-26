import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './components/userInfo.dart';
import './components/grid.dart';

class Dashboard extends StatefulWidget {
  String Name, Email, DateBirth, Password;
  // const Dasboard({super.key});
  Dashboard(
      {Key? key,
      required this.Name,
      required this.Email,
      required this.DateBirth,
      required this.Password})
      : super(key: key);
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  late final _userData = {
    "Name": widget.Name,
    "Email": widget.Email,
    "DateBirth": widget.DateBirth,
    "Password": widget.Password
  };
  int selectedIndex = 0;
  late final List<Widget> _pages = <Widget>[
    UserInfo(userData: _userData),
    Grid(),
    Icon(
      Icons.dangerous_outlined,
      size: 150,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // final UserData userData;
  @override
  Widget build(BuildContext context) {
    // returning MaterialApp
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home:
          // scaffold
          Scaffold(
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          slivers: <Widget>[
            // silverappbar for gradient widget
            SliverAppBar(
              pinned: true,
              expandedHeight: 50,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  // LinearGradient
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    // colors for gradient
                    colors: [
                      Color(0x99ef6b63),
                      Color(0xccef6b63),
                      Color(0xffef6b63),
                      Color(0xffef6b63),
                    ],
                  ),
                ),
              ),
              // title of appbar
              title: Text(
                selectedIndex == 0
                    ? "User Information"
                    : selectedIndex == 1
                        ? "Grid"
                        : "Dasboard",
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Body Element
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: _pages.elementAt(selectedIndex),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex, //New
          selectedItemColor: Color(0xffef6b63),
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'User',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label: 'Grid',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dangerous_outlined),
              label: 'Nope',
            ),
          ],
        ),
      ),
    );
  }
}
