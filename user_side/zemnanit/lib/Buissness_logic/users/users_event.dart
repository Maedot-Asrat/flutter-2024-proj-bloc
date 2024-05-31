import 'package:equatable/equatable.dart';
import 'package:zemnanit/Data/Models/user_Model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUsers extends UserEvent {}

class CreateUser extends UserEvent {
  final User user;

  const CreateUser(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateUser extends UserEvent {
  final User user;

  const UpdateUser(this.user);

  @override
  List<Object> get props => [user];
}

class DeleteUser extends UserEvent {
  final User user;

  const DeleteUser(this.user);

  @override
  List<Object> get props => [user];
}
