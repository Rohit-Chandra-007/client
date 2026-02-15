import 'dart:io';

import 'package:client/core/theme/color_pallete.dart';
import 'package:client/core/widgets/dashed_rect.dart';
import 'package:client/features/home/view/widgets/audio_wave.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadTrackArea extends StatelessWidget {
  final File? selectedAudio;
  final VoidCallback onSelectAudio;

  const UploadTrackArea({
    super.key,
    required this.selectedAudio,
    required this.onSelectAudio,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedAudio != null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorPallete.cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorPallete.borderColor),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedAudio!.path.split(Platform.pathSeparator).last,
                        style: const TextStyle(
                          color: ColorPallete.whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Ready to upload',
                        style: TextStyle(
                          color: ColorPallete.greenColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: onSelectAudio,
                  icon: const Icon(CupertinoIcons.arrow_swap, size: 16),
                  label: const Text('Change'),
                  style: TextButton.styleFrom(
                    foregroundColor: ColorPallete.whiteColor,
                    backgroundColor: ColorPallete.borderColor.withValues(
                      alpha: 0.5,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 60,
              child: AudioWave(wavePath: selectedAudio!.path),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: onSelectAudio,
      child: DashedRect(
        color: ColorPallete.borderColor,
        strokeWidth: 2,
        gap: 4,
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorPallete.cardColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.music_note_2,
                size: 28,
                color: ColorPallete.greyColor,
              ),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Song File',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ColorPallete.subtitleText,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Supports MP3, WAV',
                    style: TextStyle(
                      color: ColorPallete.greyColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
