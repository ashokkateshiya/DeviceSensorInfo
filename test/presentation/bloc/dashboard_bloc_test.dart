import 'package:device_sensor_info/domain/entities/device_info.dart';
import 'package:device_sensor_info/presentation/bloc/dashboard_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../mocks/mocks.mocks.dart';

void main() {
  late DashboardBloc bloc;
  late MockGetDeviceInfoUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetDeviceInfoUseCase();
    bloc = DashboardBloc(mockUseCase);
  });

  final mockDeviceInfo = DeviceInfo(
    deviceName: 'Pixel',
    osVersion: 'Android 14',
    batteryLevel: 85,
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [Loading, Loaded] when fetchInfo succeeds',
    build: () {
      when(mockUseCase.call()).thenAnswer((_) async => mockDeviceInfo);
      return bloc;
    },
    act: (bloc) => bloc.loadDeviceInfo(),
    expect: () => [
      isA<DashboardLoading>(),
      isA<DashboardLoaded>().having(
        (s) => s.info.deviceName,
        'deviceName',
        'Pixel',
      ),
    ],
    verify: (_) {
      verify(mockUseCase.call()).called(1);
    },
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [Loading, Error] when fetchInfo fails',
    build: () {
      when(mockUseCase.call()).thenThrow(Exception('Failure'));
      return bloc;
    },
    act: (bloc) => bloc.loadDeviceInfo(),
    expect: () => [isA<DashboardLoading>(), isA<DashboardError>()],
    verify: (_) {
      verify(mockUseCase.call()).called(1);
    },
  );
}
