import 'package:equatable/equatable.dart';
import 'package:movie/model/models/TrendingModel.dart';

class TrendingStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class TrendingInitialState extends TrendingStates{}
class LoadingState extends TrendingStates{}
class FetchSuccess extends TrendingStates{
  List<Results> posts;
  FetchSuccess({this.posts});
}
class ErrorState extends TrendingStates{
  String message;
  ErrorState({this.message});
}