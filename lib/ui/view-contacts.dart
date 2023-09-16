
import 'package:contact_form/cubit/contact_bloc.dart';
import 'package:contact_form/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:contact_form/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:contact_form/ui/addDetails.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Utils/utils.dart';
class ViewContacts extends StatefulWidget {
  const ViewContacts({super.key});

  @override
  State<ViewContacts> createState() => _ViewContactsState();

  Future<List<User>> fetchData() async {
    // Create an instance of _ViewContactsState to access its methods
    final state = _ViewContactsState();
    return await state.get();
  }
}
class _ViewContactsState extends State<ViewContacts> {
  @override
  void initState()
  {
    super.initState();
    BlocProvider.of<ContactBloc>(context).add(GetData());
  }

  List<User> userList=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All contacts"),
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

      // body: BlocBuilder<ContactBloc, ContactState>(
      //     builder: (context,state){
      //       if(state is ContactLoaded) // Display the list of contacts when data is loaded
      //         {
      //           List<User> data = state.mydata;
      //           return ListView.builder(
      //               itemCount: data.length,
      //               itemBuilder: (context,index){
      //                 return ListTile(
      //                   leading: CircleAvatar(child: Text('${data[index].phone}')),
      //                   title: Text(data[index].Firstname),
      //                   subtitle: Text(data[index].Lastname),
      //                 );
      //               }
      //           );
      //         }
      //       else if (state is ContactLoading) //Show a loading indicator while data is being fetched
      //         {
      //           return Center(child: CircularProgressIndicator());
      //         }
      //       else if (state is ContactError)
      //         {
      //           return Center(child: Text(state.message));
      //         }
      //       else
      //         {
      //           return Center(child: Text('Something went wrong'));
      //         }
      //     }
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream : FirebaseFirestore.instance.collection('users').orderBy('name').snapshots(),
        builder: (context,snapshot)
          {
            if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No contacts found'));
            }

                return ListView.builder(

                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final contact = snapshot.data!.docs[index];
                    final name = contact['name'];
                    final phone = contact['phone'];
                    final mob = phone.toString();
                    return Padding(
                      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                                color: const Color.fromARGB(255, 132, 131, 131)),
                            color: Colors.cyan[100]),
                        child: ListTile(
                          title: Text(name,style: TextStyle(color: Colors.black),),
                          trailing: Text(phone.toString(),style: TextStyle(color: Colors.black),),
                          // onTap: () {
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) =>
                          //         ContactDetailsPage(contactName: name),
                          //   ));
                          // },
                        ),
                      ),

                    );
                  },
                );



          },

      ),
    );

  }
  Widget buildUser(User user) => ListTile(
   leading: CircleAvatar(child: Text('${user.phone}')),
    title: Text(user.Firstname),
    subtitle: Text(user.Lastname),

  );


Future<List<User>> get() async
{

  try
      {
        final pro = await FirebaseFirestore.instance.collection('users').get();
        pro.docs.forEach((element) {
         return userList.add(User.fromJson(element.data()));
        });
        return userList;

      } on FirebaseException catch(e)
  {
    if(kDebugMode)
      {
        print("Failed with error  '${e.code}' : ${e.message}");
      }
    return userList;
  }
      catch(e)
  {

    Utils.showSnackBarError(e.toString());
    return userList;
   // throw Exception(e.toString());
  }
}

  Future<List<User>> fetchData() async {
    List<User> userList = [];
    try {
      final pro = await FirebaseFirestore.instance.collection('users').get();
      pro.docs.forEach((element) {
        final user = User.fromJson(element.data());
        if (user != null) {
          userList.add(user);
        }
      });
      return userList;
    } catch (e) {
      // Handle the error
      print("Error fetching data: $e");
      return userList; // You can return an empty list or handle the error as needed.
    }
  }

}


