import 'package:dartz/dartz.dart';
import 'package:project/core/error/failures.dart';

/// A generic use case interface
/// Type [T] is the success return type
/// Type [Params] is the parameters for the use case
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Use this when a use case doesn't need any parameters
class NoParams {
  const NoParams();
}
