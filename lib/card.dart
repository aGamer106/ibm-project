
import 'package:flutter/material.dart';

class businessCard{
  String _phoneNumber;
  String _firstName;
  String _lastName;
  String _jobTitle;
  Image _picture;


  businessCard({required String phoneNumber,required String firstName, required String lastName, required String jobTitle, Image? picture})
      : _phoneNumber = phoneNumber,
        _firstName = firstName,
        _lastName = lastName,
        _jobTitle = jobTitle,
        _picture = picture?? Image.asset('assets/default.png');

  void displayCard(BuildContext context){

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('AR Business Card'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Name: $_firstName'),
                Text('Title: $_jobTitle'),
                _picture, // Display picture if available
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }

    static int getUserID(){
      //query command to get userID

      return 1;
    }

  }
