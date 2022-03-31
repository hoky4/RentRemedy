import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageFilePicker
{
  void showFilePicker(BuildContext context)
  {
    showDialog(context: context, 
      builder: (_) => 
        AlertDialog(title:const Text("Select an Image"), 
          actions: <Widget>[ 
            TextButton(child: const Text("Camera"), onPressed: () => {pickImg(ImageSource.camera, context)},),  
            TextButton(child: const Text("Media Gallery"), onPressed: () => {pickImg(ImageSource.gallery, context)},)
          ],
        ),
      barrierDismissible: true);
  }

  final Future<void> Function(XFile file) onImagePicked;

  const ImageFilePicker({required this.onImagePicked});

  void pickImg(ImageSource source, BuildContext context) async
  {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if(image != null)
    {
      onImagePicked(image);
    }
    Navigator.of(context).pop();
  }

}