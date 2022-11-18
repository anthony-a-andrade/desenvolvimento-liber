import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as m;
import 'package:liber/config/style_helper.dart';

class ImagePicker extends StatefulWidget {
  static File? selectedFile;
  final String? image;

  const ImagePicker({this.image, super.key});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  String url = "https://ngx-feng.s3-sa-east-1.amazonaws.com/images/loading/img-placeholder.png";

  void getImage(m.ImageSource source) async {
    m.XFile? pickedFile = await m.ImagePicker().pickImage(
      source: source,
      maxHeight: 1800,
      maxWidth: 1800,
    );

    setState(() {
      if (pickedFile != null) {
        ImagePicker.selectedFile = File(pickedFile.path);
        url = pickedFile.path;
      } else {
        url = "https://ngx-feng.s3-sa-east-1.amazonaws.com/images/loading/img-placeholder.png";
      }
    });
  }

  Widget buildImage() {
    if (ImagePicker.selectedFile != null) {
      return Image.file(ImagePicker.selectedFile!, height: 250, fit: BoxFit.fitHeight);
    } else {
      print("${widget.image}");
      return Image.network(widget.image ?? url, height: 250, fit: BoxFit.fitHeight);
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xffC4C2C2),
          width: double.infinity,
          child: buildImage()
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Style.highlightColor,
              borderRadius: BorderRadius.only(topRight: Radius.circular(25))
            ),
            child: IconButton(
              icon: const Icon(Icons.image, color: Colors.white, size: 18), 
              alignment: Alignment.bottomLeft,
              onPressed: () => getImage(m.ImageSource.gallery)
            )
          )
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Style.highlightColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(25))
            ),
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white, size: 18), 
              alignment: Alignment.bottomRight,
              onPressed: () => getImage(m.ImageSource.camera)
            )
          )
        )
      ]
    );
  }
}