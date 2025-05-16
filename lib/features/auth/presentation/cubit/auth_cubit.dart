import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anemia_hemeglobin_app/features/auth/data/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChanged());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(ConfirmPasswordVisibilityChanged());
  }

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final authModel = await authRepository.login(
        email: email,
        password: password,
      );
      emit(LoginSuccess(authModel));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String dateOfBirth,
  }) async {
    emit(RegisterLoading());
    try {
      final authModel = await authRepository.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        dateOfBirth: dateOfBirth,
      );
      emit(RegisterSuccess(authModel));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      // Only clear session-specific data, not user data
      await authRepository.clearSessionData();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError('Logout failed: ${e.toString()}'));
    }
  }
}