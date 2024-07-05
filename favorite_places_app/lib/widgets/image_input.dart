import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera_alt_sharp),
      label: const Text('Add Image'),
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primaryFixed,
      ),
      onPressed: _takePicture,
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            _selectedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      );
    }
    final BoxDecoration imageDec = BoxDecoration(
      color: Theme.of(context).colorScheme.secondaryContainer,
      border: Border.all(
        width: 1,
        color: Theme.of(context).colorScheme.secondaryFixed.withOpacity(0.8),
      ),
      borderRadius: BorderRadius.circular(10),
    );

    return Container(
        decoration: imageDec,
        alignment: Alignment.center,
        height: 250,
        width: double.infinity,
        child: content);
  }
}
