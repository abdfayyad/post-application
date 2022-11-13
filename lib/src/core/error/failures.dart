import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{}

class OfflineFailure extends Failure{
  @override
  List<Object?> get props => throw [];
}
class ServerFailure extends Failure{
  @override
  List<Object?> get props => throw [];
}
class EmptyCacheFailure extends Failure{
  @override
  List<Object?> get props => throw [];
}
class WrongDataFailure extends Failure{
  @override
  List<Object?> get props => throw [];
}