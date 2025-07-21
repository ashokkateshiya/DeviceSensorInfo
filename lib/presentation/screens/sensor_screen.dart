import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/sensor_bloc.dart';
import '../widgets/loading_animation.dart';

class SensorScreen extends StatefulWidget {
  const SensorScreen({super.key});

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SensorBloc>().loadGyroscopeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sensor Info')),
      body: BlocBuilder<SensorBloc, SensorState>(
        builder: (context, state) {
          if (state is SensorLoading) {
            return const LoadingAnimation();
          } else if (state is FlashlightToggled) {
            return Center(
              child: Text('Flashlight is ${state.status ? "ON" : "OFF"}'),
            );
          } else if (state is GyroscopeDataLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Gyroscope X: ${state.data["x"]}'),
                  Text('Gyroscope Y: ${state.data["y"]}'),
                  Text('Gyroscope Z: ${state.data["z"]}'),
                  const SizedBox(height: 16),
                  const Text(
                    'Use buttons below to refresh or toggle flashlight',
                  ),
                ],
              ),
            );
          } else if (state is SensorError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Initializing...'));
          }
        },
      ),
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton.extended(
              heroTag: 'flash',
              onPressed: () => context.read<SensorBloc>().toggleFlashlight(),
              label: const Text('Toggle Flashlight'),
              icon: const Icon(Icons.flashlight_on),
            ),
            const SizedBox(height: 16),
            FloatingActionButton.extended(
              heroTag: 'gyro',
              onPressed: () => context.read<SensorBloc>().loadGyroscopeData(),
              label: const Text('Refresh Gyroscope'),
              icon: const Icon(Icons.sensors),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
