
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

    }



  }
