import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_device_info_usecase.dart';
import '../../domain/entities/device_info.dart';

abstract class DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DeviceInfo info;
  DashboardLoaded(this.info);
}

class DashboardError extends DashboardState {
  final String error;
  DashboardError(this.error);
}

class DashboardBloc extends Cubit<DashboardState> {
  final GetDeviceInfoUseCase useCase;
  DashboardBloc(this.useCase) : super(DashboardLoading());

  Future<void> loadDeviceInfo() async {
    emit(DashboardLoading());
    try {
      final info = await useCase.call();
      emit(DashboardLoaded(info));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
