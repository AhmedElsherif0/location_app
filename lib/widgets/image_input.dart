import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as systemPath;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput({required this.onSelectImage});

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takeAPicture() async {
    final imageFile = await ImagePicker().getImage(
            source: ImageSource.camera, maxWidth: 600);

    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final addDirection = await systemPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage =
        await File(imageFile.path).copy('${addDirection.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Container(
            height: 125,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
            ),
            alignment: Alignment.center,
            child: _storedImage != null ? Image.file(
              _storedImage! ,
              fit: BoxFit.cover,
              width: double.infinity,
            ): Image.asset('assets/product-placeholder.png') ,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            onPressed: _takeAPicture,
            icon: Icon(Icons.camera),
            label: Text('Take A Picture'),
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        )
      ],
    );
  }
}
