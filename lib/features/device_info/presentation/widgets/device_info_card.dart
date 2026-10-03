import 'package:flutter/material.dart';
import 'package:flutter_device_features/core/constants/app_spacing.dart';
import 'package:flutter_device_features/core/widgets/app_section_title.dart';
import 'package:flutter_device_features/features/device_info/data/device_info_service.dart';

class DeviceInfoCard extends StatelessWidget {
  const DeviceInfoCard({super.key, required this.deviceInfo});

  final DeviceInfo deviceInfo;

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.headlineSmall;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppSectionTitle(title: 'Device Model'),
          const SizedBox(height: AppSpacing.small),
          Text(
            deviceInfo.model,
            style: valueStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.large),
          const AppSectionTitle(title: 'Operating System'),
          const SizedBox(height: AppSpacing.small),
          Text(
            deviceInfo.osVersion,
            style: valueStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
