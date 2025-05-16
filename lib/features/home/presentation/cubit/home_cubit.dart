import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anemia_hemeglobin_app/core/network/api_helper.dart';
import 'package:anemia_hemeglobin_app/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiHelper apiHelper;

  HomeCubit(this.apiHelper) : super(HomeInitial());

  Future<void> performAnemiaTest(String imagePath, String testType) async {
    emit(HomeLoading());
    try {
      // Implement API call for anemia test
      emit(HomeTestSuccess('Anemia test completed'));
    } catch (e) {
      emit(HomeTestFailure(e.toString()));
    }
  }

  Future<void> performHemoglobinTest(String imagePath, int age, String gender) async {
    emit(HomeLoading());
    try {
      // Implement API call for hemoglobin test
      emit(HomeTestSuccess('Hemoglobin test completed'));
    } catch (e) {
      emit(HomeTestFailure(e.toString()));
    }
  }
}