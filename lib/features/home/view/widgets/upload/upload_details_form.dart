import 'package:client/core/theme/color_pallete.dart';
import 'package:client/core/widgets/custom_text_form_field.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class UploadDetailsForm extends StatelessWidget {
  final TextEditingController songNameController;
  final TextEditingController artistNameController;
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;

  const UploadDetailsForm({
    super.key,
    required this.songNameController,
    required this.artistNameController,
    required this.selectedColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Song Details'),
        const SizedBox(height: 12),
        CustomTextFormField(hint: 'Song Title', controller: songNameController),
        const SizedBox(height: 16),
        CustomTextFormField(
          hint: 'Artist Name',
          controller: artistNameController,
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('Theme Color'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorPallete.cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorPallete.borderColor),
          ),
          child: Column(
            children: [
              ColorPicker(
                color: selectedColor,
                onColorChanged: onColorChanged,
                heading: Text(
                  'Select Primary Color',
                  style: TextStyle(
                    color: ColorPallete.subtitleText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subheading: const SizedBox(height: 8),
                padding: EdgeInsets.zero,
                pickersEnabled: const {
                  ColorPickerType.wheel: true,
                  ColorPickerType.both: false,
                  ColorPickerType.primary: false,
                  ColorPickerType.accent: false,
                  ColorPickerType.bw: false,
                  ColorPickerType.custom: false,
                },
                wheelDiameter: 180,
                wheelWidth: 16,
                hasBorder: true,
                borderColor: ColorPallete.borderColor,
                borderRadius: 20,
                enableShadesSelection: false,
                spacing: 10,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: selectedColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Selected Color',
                    style: TextStyle(
                      color: ColorPallete.subtitleText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: ColorPallete.gradient2,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: ColorPallete.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
