import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/data/models/auth/login_request.dart';
import 'package:recipe_app/data/models/auth/register_request.dart';
import 'package:recipe_app/data/models/user/user.dart';
import 'package:recipe_app/data/repositories/auth_repository.dart';

import '../../data/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(InitialAuthState()) {
    on<LoginAuthEvent>(_onLogin);
    on<RegisterAuthEvent>(_onRegister);
    on<LogoutAuthEvent>(_onLogout);
  }

  void _onLogin(LoginAuthEvent event, emit) async {
    emit(LoadingAuthState());

    try {
      await authRepository.login(event.request);
      final user = await userRepository.getUser();

      emit(AuthenticatedAuthState(user: user));
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  void _onRegister(RegisterAuthEvent event, emit) async {
    emit(LoadingAuthState());

    try {
      await authRepository.register(event.request);
      final user = await userRepository.getUser();

      emit(AuthenticatedAuthState(user: user));
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  void _onLogout(LogoutAuthEvent event, emit) async {
    emit(LoadingAuthState());

    try {
      await authRepository.logout();
      emit(UnAuthenticatedAuthState());
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }
}