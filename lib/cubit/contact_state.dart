part of 'contact_bloc.dart';
abstract class ContactState extends Equatable {
  const ContactState();
  @override
  List<Object> get props => [];
}
class ContactLoading extends ContactState {
  @override
  List<Object> get props => [];
}


class ContactLoaded extends ContactState {
  final List<User> mydata; // Data loaded successfully and stored as a list of User objects
  ContactLoaded(this.mydata); // Constructor to initialize with loaded data

  @override
  List<Object> get props => [mydata];
}
// ContactError state: Indicates that an error occurred during data loading
class ContactError extends ContactState {
  final String message;
  ContactError(this.message);
  @override
  List<Object> get props => [message];
}
