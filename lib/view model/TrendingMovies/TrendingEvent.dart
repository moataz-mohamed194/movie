import 'package:equatable/equatable.dart';

class TrendingEvents extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class TrendingDoFetchEvents extends TrendingEvents{
  final String cityName;
  TrendingDoFetchEvents(this.cityName);
  @override
  List<Object> get props => [cityName];
}