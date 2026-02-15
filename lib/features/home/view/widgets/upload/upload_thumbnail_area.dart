import 'dart:io';

import 'package:client/core/theme/color_pallete.dart';
import 'package:client/core/widgets/dashed_rect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadThumbnailArea extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback onSelectImage;

  const UploadThumbnailArea({
    super.key,
    required this.selectedImage,
    required this.onSelectImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelectImage,
      child: selectedImage != null
          ? Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    selectedImage!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.pencil,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            )
          : DashedRect(
              color: ColorPallete.borderColor,
              strokeWidth: 2,
              gap: 4,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorPallete.cardColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.photo_on_rectangle,
                      size: 40,
                      color: ColorPallete.greyColor,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Select Thumbnail',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: ColorPallete.subtitleText,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
