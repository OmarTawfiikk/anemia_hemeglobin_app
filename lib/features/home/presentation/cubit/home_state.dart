abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeTestSuccess extends HomeState {
  final String message;
  HomeTestSuccess(this.message);
}
class HomeTestFailure extends HomeState {
  final String error;
  HomeTestFailure(this.error);
}