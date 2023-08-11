import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yellow_exchange/classes/category.dart';
import 'package:yellow_exchange/classes/product.dart';

class MyListingsBloc {

  Future<void> pickImageFromGallery() async {

    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // final List<XFile> image = await picker.pickMultiImage();

    print(image);

    // if (image != null) {
    //   // image.saveTo("assets");
    // }

  }

}