//No. of inputs in the data
//Global Variable

class Data { //Creating a class
  final String id; //For employee id
  final String name; //For employee name
  final double years; //For years from joining
  final int active; //Whether the employee is active with organisation or not
  final DateTime date; //To enter the date to a data entry

  Data({
    required this.id,
    required this.name,
    required this.years,
    required this.active,
    required this.date,
  });
}
