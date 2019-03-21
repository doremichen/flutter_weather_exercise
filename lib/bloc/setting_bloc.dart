///
/// Used to convert event to state
///
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

enum TemperatureUnits {
  fahrenheit,
  celsius
}

// Setting event start ===========================================
abstract class SettingEvent extends Equatable {}
class TemperatureUnitsToggled extends SettingEvent {}
// Setting event end =============================================
// Setting state start ===========================================
class SettingState extends Equatable {
  final TemperatureUnits units;

  SettingState({@required this.units}): assert(units != null),
                                        super([units]);
}
// Setting state end =============================================
// Setting bloc
// Used to convert event to state
class SettingBloc extends Bloc<SettingEvent, SettingState> {
  @override
  SettingState get initialState => SettingState( units: TemperatureUnits.celsius);

  @override
  Stream<SettingState> mapEventToState(SettingState currentState,
      SettingEvent event) async* {
      if (event is TemperatureUnitsToggled) {
        yield SettingState(
          units: currentState.units == TemperatureUnits.celsius
              ? TemperatureUnits.celsius
              : TemperatureUnits.fahrenheit,
        );
      }
  }

}