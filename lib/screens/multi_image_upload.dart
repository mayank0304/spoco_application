import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MultiImageUpload extends StatefulWidget {
  const MultiImageUpload({super.key});

  @override
  _MultiImageUploadState createState() => _MultiImageUploadState();
}

class _MultiImageUploadState extends State<MultiImageUpload> {
  // Create an Empty List of files, which will store multiple image paths
  List<File> imageFiles = [];
  List<String> imageURLs = [];

  pickupMultipleImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        setState(() {
          imageFiles = result.paths.map((path) => File(path!)).toList();
        });
      } else {
        print("User canceled the picker");
      }
    } on FirebaseException catch (e) {
      print("FirebaseException: $e");
    } catch (e) {
      print("Exception: $e");
    }
  }

  uploadMultiImages() async {
    final storageRef = FirebaseStorage.instance.ref();
    for (File file in imageFiles) {
      try {
        final turfsPic =
            storageRef.child("turf-pics/${file.path.split("/").last}.png");
        await turfsPic.putFile(file);
        String url = await turfsPic.getDownloadURL();
        imageURLs.add(url);
        print("Image Url is: ${url}");
      } on FirebaseException catch (e) {
        print("FirebaseException: $e");
      } catch (e) {
        print("Exception: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Uplaod Multiple images"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: pickupMultipleImage, child: const Text("Selct Multiple images")),
            imageFiles.isNotEmpty
                ? Wrap(
                    children: imageFiles.map((file) => Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.file(
                            file,
                            height: 100,
                            width: 100,
                          ),
                        )).toList(),
                  )
                : const Text("No files"),
              ElevatedButton(onPressed: uploadMultiImages, child: const Text("Upload Images"))
          ],

        ));
  }
}
