import 'package:contact_form/ui/addDetails.dart';
import 'package:contact_form/ui/view-contacts.dart';
import 'package:contact_form/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:contact_form/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:lottie/lottie.dart';

import 'cubit/contact_bloc.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( BlocProvider(
      create:  (context) => ContactBloc(viewContacts: ViewContacts()),
      child: MyApp(),));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    scaffoldMessengerKey: Utils.messengerkey,
      debugShowCheckedModeBanner: false,
      title: 'Contact Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: textColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            padding: EdgeInsets.all(defaultPadding),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: textFieldBorder,
          enabledBorder: textFieldBorder,
          focusedBorder: textFieldBorder,
        ),
      ),
      home: Home(),
    );
  }


}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Stack(
       fit: StackFit.expand,
       children: [
         Lottie.asset('assets/images/contacts.json'),
         SafeArea(
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
             child: Column(
               children: [
                 Spacer(),
                 Spacer(),
                 SizedBox(
                   width: double.infinity,
                   child: ElevatedButton(
                     onPressed: () => Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => UserPage(),
                       ),
                     ),
                     style: TextButton.styleFrom(
                       backgroundColor: Color(0xFF375AB4),
                     ),
                     child: Text("Add contact"),
                   ),
                 ),
                 Padding(
                   padding:
                   const EdgeInsets.symmetric(vertical: defaultPadding),
                   child: SizedBox(
                     width: double.infinity,
                     child: ElevatedButton(
                       onPressed: () => Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => ViewContacts(),
                           )),
                       style: TextButton.styleFrom(
                         // backgroundColor: Color(0xFF6CD8D1),
                         elevation: 0,
                         backgroundColor: Color(0xFF375AB4),
                         shape: RoundedRectangleBorder(
                           side: BorderSide(color: Color(0xFF375AB4)),
                         ),
                       ),
                       child: Text("View all contacts"),
                     ),
                   ),
                 ),
                 const SizedBox(height: defaultPadding),
               ],
             ),
           ),
         ),
       ],
     )
    );
  }
}



