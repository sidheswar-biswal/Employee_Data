//This dart file list out the datas in the app

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/data.dart';


class DataList extends StatefulWidget { //Creating a StatefulWidget
  final List<Data> data; //Accessing the list of datas taken
  final Function deleteTx; //Creating a Function to delete data if required

  DataList(this.data, this.deleteTx);

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: widget.data.isEmpty //Condition if no data has taken
          ? Column(
        children: <Widget>[ //Creating a widget if no data has taken
          Text(
            'No Data added yet!', //If no data has taken the app will show 'No Data added yet!'
            style: Theme.of(context).textTheme.titleMedium, //styling of text of 'No Data added yet!'
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/waiting.png', //This image will be shown if no data has been added
                fit: BoxFit.cover,
              )),
        ],
      )
          : ListView.builder(
        itemBuilder: (ctx, index) { //Taking index and ctx
          return Card( //Returning a card for a entry
            elevation: 5,
            color: (widget.data[index].years >= 5 && widget.data[index].active == 1) ? Colors.green : Colors.white, //condition of colour if years of joining >= 5 and employee is active with organisation and vice versa
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar( //Creating a CircleAvatar
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('${widget.data[index].years}',), //In the above CircleAvatar, the years of joining of a employee will be shown as text
                  ),
                ),
              ),
              title: Text(
                widget.data[index].name, //Accessing the entered name to the Card
                style: Theme.of(context).textTheme.titleMedium, //Giving style of text
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(widget.data[index].date), //Accessing the entered date to the Card
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete), //Creating a delete icon
                color: Theme.of(context).errorColor, //Giving colour of delete button
                onPressed: () => widget.deleteTx(widget.data[index].id), //On pressing the delete icon the selected employee data will be deleted
              ),
            ),
          );
        },
        itemCount: widget.data.length,
      ),
    );
  }
}
