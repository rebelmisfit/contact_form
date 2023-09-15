part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Create extends ContactEvent {
  final String Firstname;
  final String Lastname;
  final String phone;
  final String address;

  Create(this.Firstname, this.Lastname, this.phone, this.address);

}

// GetData event: Used to request data retrieval
class GetData extends ContactEvent
{
  GetData();
}
