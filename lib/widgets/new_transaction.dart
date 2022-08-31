// import 'package:flutter/material.dart';
//
// class NewTransaction extends StatefulWidget {
//   final Function addNewTx;
//
//   NewTransaction(this.addNewTx);
//
//   @override
//   State<NewTransaction> createState() => _NewTransactionState();
// }
//
// class _NewTransactionState extends State<NewTransaction> {
//   final titleInputController = TextEditingController();
//
//   final amountInputController = TextEditingController();
//
//   void submitData() {
//     final enteredTitle = titleInputController.text;
//     final enteredAmount = double.parse(amountInputController.text);
//     if (enteredTitle.isEmpty || enteredAmount <= 0) {
//       return;
//     }
//     widget.addNewTx(enteredTitle, enteredAmount);
//
//     Navigator.of(context).pop(); // to Close model sheet after transaction done
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       child: Container(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             TextField(
//               decoration: InputDecoration(labelText: 'Title'),
//               // onChanged: (value) {
//               //   title = value;
//               // },
//               controller: titleInputController,
//               onSubmitted: (value) => submitData(),
//             ),
//             TextField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Amount'),
//               // onChanged: (value) {
//               //   amount = value;
//               // },
//               controller: amountInputController,
//               onSubmitted: (value) => submitData(),
//             ),
//             FlatButton(
//               onPressed: submitData,
//               child: Text('Add Transaction'),
//               textColor: Colors.purple,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
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
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  AdaptiveFlatButton('Choose Date', _presentDatePicker),
                ],
              ),
            ),
            Expanded(
              child: RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: _submitData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
