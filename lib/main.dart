//This is the main.dart file for the app

import 'package:flutter/material.dart';
import './widgets/new_data.dart';
import './widgets/data_list.dart';
import './models/data.dart';

void main() => runApp(MyApp()); //To run the app

class MyApp extends StatefulWidget {  //Creating a StatefulWidget
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zylu Business Solutions', //Title
      theme: ThemeData(
          primarySwatch: Colors.purple, //Selecting a primarySwatch colour
          accentColor: Colors.amber, //Selecting a accentColor colour
          fontFamily: 'Quicksand', //Selecting a font
          textTheme: ThemeData.light().textTheme.copyWith(
            subtitle1: TextStyle( //Selecting a font style for subtitle1
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            button: TextStyle(color: Colors.white), //Selecting text colour inside a button
          ),
          appBarTheme: AppBarTheme( //Styling of AppBar
            textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget { //Creating a StatefulWidget
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Data> _userDatas = []; //Accessing Data as _userDatas

  List<Data> get data {
    return _userDatas.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewData( //To add a new data
      String txname, double txyears, int txactive, DateTime chosenDate) {
    final newTx = Data(
      name: txname, //Employee name
      years: txyears, //Years from joining
      active: txactive, //Active with Org. or not
      date: chosenDate, //Date of entry
      id: DateTime.now().toString(),
    );

    setState(() {
      _userDatas.add(newTx);
    });
  }

  void _startAddNewData(BuildContext ctx) { //To start adding new datas
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewData(_addNewData),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteData(String id) { //To delete a data
    setState(() {
      _userDatas.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Zylu Business Solutions', //Title
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), //Add data icon
            onPressed: () => _startAddNewData(context), //On pressing Add data icon a user can add an employee data
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DataList(_userDatas, _deleteData),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, //Add icon button location
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewData(context), //Work of add icon
      ),
    );
  }
}
