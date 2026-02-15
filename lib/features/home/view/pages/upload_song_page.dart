import 'dart:io';

import 'package:client/core/theme/color_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/home/view/widgets/upload/upload_details_form.dart';
import 'package:client/features/home/view/widgets/upload/upload_thumbnail_area.dart';
import 'package:client/features/home/view/widgets/upload/upload_track_area.dart';
import 'package:client/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _artistNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Color selectedColor = ColorPallete.cardColor;
  File? _selectedAudio;
  File? _selectedImage;
  bool _isUploading = false;

  void selectSong() async {
    final res = await pickAudio();
    if (res != null) {
      setState(() {
        _selectedAudio = res;
      });
    }
  }

  void selectImage() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        _selectedImage = res;
      });
    }
  }

  @override
  void dispose() {
    _songNameController.dispose();
    _artistNameController.dispose();
    super.dispose();
  }

  void _handleUpload() async {
    if (_selectedImage == null) {
      showSnackBar(context, 'Please select a thumbnail image');
      return;
    }
    if (_selectedAudio == null) {
      showSnackBar(context, 'Please select a song file');
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isUploading = true);

    await ref
        .read(homeModelViewProvider.notifier)
        .uploadSong(
          selectedAudio: _selectedAudio!,
          selectedImage: _selectedImage!,
          songName: _songNameController.text.trim(),
          artistName: _artistNameController.text.trim(),
          color: colorToHexCode(selectedColor),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(homeModelViewProvider, (_, next) {
      next?.when(
        data: (data) {
          setState(() => _isUploading = false);
          showSnackBar(context, 'Song uploaded successfully!');
          ref.invalidate(getAllSongsProvider);
          Navigator.pop(context);
        },
        error: (error, stackTrace) {
          setState(() => _isUploading = false);
          showSnackBar(context, error.toString());
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upload Song",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _formKey.currentState?.reset();
              setState(() {
                _selectedAudio = null;
                _selectedImage = null;
                selectedColor = ColorPallete.cardColor;
              });
            },
            icon: const Icon(CupertinoIcons.refresh),
            tooltip: 'Reset Form',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Thumbnail Picker ──
              UploadThumbnailArea(
                selectedImage: _selectedImage,
                onSelectImage: selectImage,
              ),

              const SizedBox(height: 20),

              // ── Audio Picker ──
              UploadTrackArea(
                selectedAudio: _selectedAudio,
                onSelectAudio: selectSong,
              ),

              const SizedBox(height: 24),

              // ── Input Fields & Color Picker ──
              UploadDetailsForm(
                songNameController: _songNameController,
                artistNameController: _artistNameController,
                selectedColor: selectedColor,
                onColorChanged: (color) =>
                    setState(() => selectedColor = color),
              ),

              const SizedBox(height: 32),

              // ── Upload Button ──
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isUploading ? null : _handleUpload,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPallete.gradient2,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                    ),
                    child: _isUploading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Upload Song',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
