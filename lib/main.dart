import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/platform_channel.dart';
import 'data/datasource/device_info_remote_datasource.dart';
import 'data/repository/device_info_repository_impl.dart';
import 'domain/usecases/get_device_info_usecase.dart';
import 'presentation/bloc/dashboard_bloc.dart';
import 'presentation/bloc/sensor_bloc.dart';
import 'core/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final platformChannel = PlatformChannel();
    final datasource = DeviceInfoRemoteDatasource(platformChannel);
    final repository = DeviceInfoRepositoryImpl(datasource);
    final useCase = GetDeviceInfoUseCase(repository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DashboardBloc(useCase)),
        BlocProvider(create: (_) => SensorBloc(platformChannel)),
      ],
      child: MaterialApp(
        title: 'Device Info & Sensor App',
        theme: ThemeData(primarySwatch: Colors.blue),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: AppRoutes.dashboard,
      ),
    );
  }
}
