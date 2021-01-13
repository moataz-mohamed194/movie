import 'package:equatable/equatable.dart';

class MovieEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class DoFetchEvents extends MovieEvents{
  final String cityName;
  DoFetchEvents(this.cityName);
  @override
  List<Object> get props => [cityName];
}