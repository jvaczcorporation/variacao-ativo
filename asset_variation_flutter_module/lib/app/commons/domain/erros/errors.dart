abstract class Failure implements Exception {
  String get message;
  const Failure();
}

class FailureRepository extends Failure {
  @override
  final String message;

  FailureRepository({
    required this.message,
  });
}

class FailureDatasource extends Failure {
  @override
  final String message;

  FailureDatasource({
    required this.message,
  });
}
