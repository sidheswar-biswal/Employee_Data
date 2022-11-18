//This dart file take the input to the app for a new data

import 'package:flutter/material.dart';

class NewData extends StatefulWidget { //Creating a StatefulWidget
  final Function addTx; //Initializing a function to add new data

  NewData(this.addTx);

  @override
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  final _nameController = TextEditingController(); //For entering name
  final _yearsController = TextEditingController(); //For entering year
  final _activeController = TextEditingController(); //For enter active status
  late DateTime _selectedDate;

  void _submitData() {
    if (_yearsController.text.isEmpty) {
      return;
    }
    final enteredName = _nameController.text; //To enter the name in text type
    final enteredYears = double.parse(_yearsController.text); //To enter the year of joining in double type
    final enteredActive = int.parse(_activeController.text); //To enter if the employee is active with organisation or not in integer type

    if (enteredName.isEmpty || enteredYears <= 0 || _selectedDate == null || enteredActive > 1) {
      return;
    } //To return if input is not given

    widget.addTx(   //Setting up of widget for above parameters taken
      enteredName,
      enteredYears,
      enteredActive,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return; //To return if date is not chosen
      }
      setState(() {
        _selectedDate = pickedDate; //Taking the entry of date for a data
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[   //Creating a Widget for the data entry
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              controller: _nameController,
              onSubmitted: (_) => _submitData(), //Input for Name
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Years from joining'),
              controller: _yearsController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(), //Input for Years from joining
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Active with Organisation?'
              '(1 for Yes and 0 for No)'),
              controller: _activeController,
              onSubmitted: (_) => _submitData(), //Input for Active with Organisation or not in terms of 1 and 0
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,  //Giving colour of text of Choose Date button
                    child: Text(
                      'Choose Date',  //To choose a date
                      style: TextStyle(
                        fontWeight: FontWeight.bold, //Styling of text of Choose Date button
                      ),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Data'), //Creating a button to add the above input data
              color: Theme.of(context).primaryColor, //Giving colour of Add data button
              textColor: Theme.of(context).textTheme.button?.color, //Giving text colour of Add data inside Add data button
              onPressed: _submitData, //onPressed command
            ),
          ],
        ),
      ),
    );
  }
}