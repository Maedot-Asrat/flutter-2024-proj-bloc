import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/Buissness_logic/users/users_event.dart';
import 'package:zemnanit/Buissness_logic/users/users_state.dart';
import 'package:zemnanit/Data/Repositories/users_repo.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersRepository _usersRepository;

  UserBloc(this._usersRepository) : super(UserInitial()) {
    on<GetUsers>(_onGetUsers);
    on<CreateUser>(_onCreateUser);
    on<UpdateUser>(_onUpdateUser);
    on<DeleteUser>(_onDeleteUser);
  }

  Future<void> _onGetUsers(GetUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await _usersRepository.getUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onCreateUser(CreateUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final createdUser = await _usersRepository.createUser(event.user);
      if (state is UserLoaded) {
        emit(UserLoaded([...(state as UserLoaded).users, createdUser]));
      } else {
        emit(UserLoaded([createdUser]));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  //

  Future<void> _onUpdateUser(UpdateUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final updatedUser = await _usersRepository.updateUser(event.user);
      final users = [...(state as UserLoaded).users];
      final index = users.indexWhere((user) => user.id == updatedUser.id);
      users[index] = updatedUser;
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      await _usersRepository.deleteUser(event.user);
      final users = [...(state as UserLoaded).users];
      users.removeWhere((user) => user.id == event.user.id);
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
