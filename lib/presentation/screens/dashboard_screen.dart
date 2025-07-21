import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/loading_animation.dart';
import '../../core/routes.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Automatically trigger fetching device info when screen opens
    context.read<DashboardBloc>().loadDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sensors),
            tooltip: 'Sensor Info',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.sensor);
            },
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const LoadingAnimation();
          } else if (state is DashboardLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '📱 Device: ${state.info.deviceName}',
                    style: _textStyle(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '🛠️ OS Version: ${state.info.osVersion}',
                    style: _textStyle(),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '🔋 Battery: ${state.info.batteryLevel}%',
                    style: _textStyle(),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<DashboardBloc>().loadDeviceInfo(),
                    child: const Text('🔄 Refresh Info'),
                  ),
                ],
              ),
            );
          } else if (state is DashboardError) {
            return Center(child: Text('❌ ${state.error}', style: _textStyle()));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  TextStyle _textStyle() =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
}
