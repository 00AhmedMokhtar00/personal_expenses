import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function addTransaction;

  NewTransaction({@required this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime tranDate;

  submitData() {
    if (titleController.text.length >= 1 &&
        double.parse(amountController.text) >= 1) {
      widget.addTransaction(
          titleController.text, double.parse(amountController.text),tranDate??DateTime.now());
      Navigator.of(context).pop();
    }
  }

  _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 1),
            lastDate: DateTime.now())
        .then((pickedDate) {
          if(pickedDate == null)
            return;
          else {
            setState(() {
              tranDate = pickedDate;
            });
          }
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQ = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: MediaQ.viewInsets.bottom + 5),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: ' Title',
                contentPadding: EdgeInsets.all(8),
              ),
              controller: titleController,
              onSubmitted: (_) => submitData,
            ),
            TextField(
              decoration: InputDecoration(labelText: ' Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(tranDate != null?DateFormat.yMMMd().format(tranDate):'No Date Chosen'),
                  InkWell(
                    onTap: _datePicker,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.blue)),
                      child: Text(
                        'Choose Date',
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Theme.of(context).primaryColor),
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onTap: submitData,
            )
          ],
        ),
      ),
    );
  }
}
