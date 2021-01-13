import 'package:equatable/equatable.dart';

class PostEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class DoFetchEvents extends PostEvents{
  final String cityName;
  DoFetchEvents(this.cityName);
  @override
  List<Object> get props => [cityName];
}