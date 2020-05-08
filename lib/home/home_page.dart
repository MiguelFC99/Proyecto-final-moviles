import 'package:flutter/material.dart';
import 'package:proyecto_app_moviles/acerca/about.dart';
import 'package:proyecto_app_moviles/documentos/docs.dart';
import 'package:proyecto_app_moviles/imagenes/images.dart';
import 'package:proyecto_app_moviles/utils/constants.dart';

class HomePage extends StatefulWidget {

  HomePage({
    Key key,
  }) : super(key: key);



  final _pages = [
    Images(),
    Docs(),
    About(),
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: IndexedStack(
        index: _currentIndex,
        children: widget._pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Imagenes"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.import_contacts),
            title: Text("Documentos"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Ajustes"),
          ),
        ],
      ),
    );
  }
}
