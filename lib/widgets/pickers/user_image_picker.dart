import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(this.imagePickFn, {super.key});
  final PickFile imagePickFn;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    final imageFile = File(image!.path);
    setState(() {
      _pickedImage = imageFile;
    });
    widget.imagePickFn(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor),
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text('Add image'),
        ),
      ],
    );
  }
}

typedef PickFile = Function(File pickedImage);
