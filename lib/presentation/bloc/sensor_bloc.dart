import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/platform_channel.dart';

abstract class SensorState {}

class SensorInitial extends SensorState {}

class SensorLoading extends SensorState {}

class FlashlightToggled extends SensorState {
  final bool status;
  FlashlightToggled(this.status);
}

class GyroscopeDataLoaded extends SensorState {
  final Map<String, dynamic> data;
  GyroscopeDataLoaded(this.data);
}

class SensorError extends SensorState {
  final String message;
  SensorError(this.message);
}

class SensorBloc extends Cubit<SensorState> {
  final PlatformChannel platformChannel;
  bool _flashStatus = false;

  SensorBloc(this.platformChannel) : super(SensorInitial());

  Future<void> toggleFlashlight() async {
    try {
      emit(SensorLoading());
      _flashStatus = !_flashStatus;
      await platformChannel.toggleFlashlight(_flashStatus);
      emit(FlashlightToggled(_flashStatus));
    } catch (e) {
      emit(SensorError(e.toString()));
    }
  }

  Future<void> loadGyroscopeData() async {
    try {
      emit(SensorLoading());
      final data = await platformChannel.getGyroscopeData();
      emit(GyroscopeDataLoaded(data));
    } catch (e) {
      emit(SensorError(e.toString()));
    }
  }
}
