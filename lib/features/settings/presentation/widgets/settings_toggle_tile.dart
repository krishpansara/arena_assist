import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import 'settings_list_tile.dart';

class SettingsToggleTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const SettingsToggleTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<SettingsToggleTile> createState() => _SettingsToggleTileState();
}

class _SettingsToggleTileState extends State<SettingsToggleTile> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      icon: widget.icon,
      title: widget.title,
      subtitle: widget.subtitle,
      onTap: () {
        setState(() => _value = !_value);
        widget.onChanged?.call(_value);
      },
      trailing: Switch(
        value: _value,
        onChanged: (val) {
          setState(() => _value = val);
          widget.onChanged?.call(val);
        },
        activeColor: AppColors.onSurface,
        activeTrackColor: AppColors.secondaryDim,
        inactiveThumbColor: AppColors.onSurfaceVariant,
        inactiveTrackColor: AppColors.surfaceContainerHigh,
      ),
    );
  }
}
