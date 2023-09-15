import 'dart:async';
import 'package:contact_form/ui/view-contacts.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:contact_form/ui/view-contacts.dart';
import '../ui/addDetails.dart';
import '../ui/view-contacts.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
   final ViewContacts viewContacts;
  ContactBloc({required this.viewContacts}): super(ContactLoading()){
on<GetData> ((event,emit) async { //Defining a GetData event handler.
  emit(ContactLoading()); // Emitting the ContactLoading state to indicate data loading.
  await Future.delayed(Duration(seconds: 1));
  try
      {
        final data = await viewContacts.fetchData();
        emit(ContactLoaded(data));
      } catch (e) {
    emit(ContactError(e.toString())); // Handling errors by emitting ContactError state with an error message.
      }

  });
    }

  }

