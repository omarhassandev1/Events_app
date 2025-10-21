import 'package:evently_application/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({
    super.key,
    required this.activeIcon,
    required this.inActiveIcon,
    required this.value,
    required this.onToggle,
  });

  final Widget activeIcon;
  final Widget inActiveIcon;
  final bool value;
  final Function(bool) onToggle;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      padding: 2,
      width: 70.0,
      height: 40.0,
      toggleSize: 35.0,
      borderRadius: 40.0,
      activeColor: AppColors.mainColor,
      inactiveColor: AppColors.lightBg,
      inactiveSwitchBorder: Border.all(width: 4, color: AppColors.mainColor),
      inactiveToggleColor: AppColors.mainColor,
      value: value,
      activeIcon: activeIcon,
      inactiveIcon: inActiveIcon,
      onToggle: onToggle,
    );
  }
}
