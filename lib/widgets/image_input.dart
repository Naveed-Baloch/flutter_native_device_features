import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart'
    as syspath; // for accessing the internal storage
import 'package:path/path.dart'
    as path; // for manipulating the path and also for getting the file name from the path of any file

class ImageInput extends StatefulWidget {
  final Function saveImage;

  ImageInput(this.saveImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _takePicture() async {
    final pickedFile = await _picker.getImage(
        source: ImageSource.camera, maxHeight: 500, maxWidth: 350);
    if (pickedFile == null) return;
    setState(() {
      _imageFile = File(pickedFile.path);
    });
    final fileDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(_imageFile!.path);
    final savedImage = await _imageFile!.copy('${fileDir.path}/$fileName');
    widget.saveImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _imageFile != null
              ? Image.file(File(_imageFile!.path))
              : Text(
                  'No Image Token',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePicture,
            textColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
          ),
        ),
      ],
    );
  }
}
