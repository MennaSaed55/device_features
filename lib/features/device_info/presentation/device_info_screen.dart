import 'package:flutter/material.dart';
import 'package:flutter_device_features/core/constants/app_spacing.dart';
import 'package:flutter_device_features/core/widgets/app_button.dart';
import 'package:flutter_device_features/features/device_info/data/device_info_service.dart';
import 'package:flutter_device_features/features/device_info/presentation/widgets/device_info_card.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  final DeviceInfoService _deviceInfoService = DeviceInfoService();
  late Future<DeviceInfo> _deviceInfoFuture;

  @override
  void initState() {
    super.initState();
    _deviceInfoFuture = _deviceInfoService.loadDeviceInfo();
  }

  void _reload() {
    setState(() {
      _deviceInfoFuture = _deviceInfoService.loadDeviceInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device Info')),
      body: Center(
        child: FutureBuilder<DeviceInfo>(
          future: _deviceInfoFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.large),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Could not read the device information.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.medium),
                    AppButton(
                      label: 'Retry',
                      icon: Icons.refresh,
                      onPressed: _reload,
                    ),
                  ],
                ),
              );
            }

            return DeviceInfoCard(deviceInfo: snapshot.requireData);
          },
        ),
      ),
    );
  }
}
