class AppFailure {
  final String message;
  AppFailure([this.message = "Sorry, something went wrong!"]);

  @override
  String toString() => 'Appailure(message: $message)';
}