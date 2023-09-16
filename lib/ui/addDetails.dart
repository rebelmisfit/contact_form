
import 'package:contact_form/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:contact_form/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/contact_bloc.dart';
import '../Utils/utils.dart';



class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerAddress = TextEditingController();


  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Add contact"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        },
      ),
      backgroundColor: primaryColor,
    ),
  body: ListView(
    padding: EdgeInsets.all(16),
    children: [

      TextField(
          decoration : decoration('First Name'),
        controller: controllerFirstName,
          ),
      const SizedBox(height: 24),
      TextField(
        decoration : decoration('Last Name'),
        controller: controllerLastName,
      ),
      const SizedBox(height: 24),
      TextField(
        decoration : decoration('Phone'),
        keyboardType: TextInputType.number,
        controller: controllerPhone,
      ),
      const SizedBox(height: 24),
      TextField(
        decoration : decoration('Address'),
        controller: controllerAddress,
      ),
      const SizedBox(height: 24),
      ElevatedButton(
          onPressed: (){
            final user = User(
              Firstname: controllerFirstName.text,
              Lastname: controllerLastName.text,
              phone: int.tryParse(controllerPhone.text) ?? 0,
              address: controllerAddress.text,


            );
          createUser(user);
          },
     child: Text('Create contact') ,),



    ],
  ),
  );
  InputDecoration decoration(String label) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
  );



}

// Function for creating a new user in Firestore
  Future createUser (User user) async {

    final docUser = FirebaseFirestore.instance.collection("users").doc();
   user.id = docUser.id;
    final json = user.toJson();
    await docUser.set(json);
    Utils.showSnackBarSuccess('Contact added to Firestore');

    }



class User {
  String id;
  final String Firstname;
  final String Lastname;
  final int phone;
  final String address;


// User class for representing user data
  User({
    this.id = '',
    required this.Firstname,
    required this.Lastname,
    required this.phone,
    required this.address,

  });
  // Convert user data to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first name': Firstname,
      'last name': Lastname,
      'phone': phone,
      'address': address,
    };
  }

// Create a User object from a JSON map
  static User fromJson(Map<String, dynamic> json) {
    final id = json['id']??'';
    final firstName = json['first name']??'';
    final lastName = json['last name']??'';
    final phone = json['phone']??'';
    final address = json['address']??'';

    return User(
      id: id ?? '',
      Firstname: firstName ,
      Lastname: lastName ,
      phone: phone ,
      address: address ,
    );
  }

}
