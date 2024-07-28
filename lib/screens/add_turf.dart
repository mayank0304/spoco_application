import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/model/turf.dart';
import 'package:spoco_app/services/turf-service.dart';
import 'package:spoco_app/widgets/text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class AddTurf extends StatefulWidget {
  const AddTurf({super.key});

  @override
  _AddTurfState createState() => _AddTurfState();
}

class _AddTurfState extends State<AddTurf> {
  Turf turf = Turf.getEmptyObject();
  final formKey = GlobalKey<FormState>();
  TurfService service = TurfService();
  // bool ShowProgres = false;
  bool saveChange = false;
  bool uploadChange = false;

  List<File> imageFiles = [];
  List<String> imageURLs = [];

  pickupMultipleImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        imageFiles = result.paths.map((path) => File(path!)).toList();
      });
    } else {
      print("User canceled the picker");
    }
  }

  uploadMultiImages() async {
    setState(() {
      uploadChange = true;
    });
    print("uploadMultipleImages Started...");
    final storageRef = FirebaseStorage.instance.ref();
    for (File file in imageFiles) {
      try {
        final turfsPic =
            storageRef.child("turf-pics/${file.path.split("/").last}");
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
    turf.photos = imageURLs;
    print("uploadMultipleImages Finished...");
    setState(() {
      uploadChange = false;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: "Images uploaded".text.make()));
  }

  addTurfToDB() async {
    setState(() {
      uploadChange = true;
    });
    formKey.currentState!.save();
    final result = await service.addTurf(turf);
    print(result);
    print("Upload turf success");
    setState(() {
      uploadChange = false;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: "Data Saved".text.make()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A3636),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        title: "Add Turf".text.make(),
      ),
      // color: Colors.black,
      body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Add Turf Images"
                                  .text
                                  .xl3
                                  .bold
                                  .color(const Color(0xFF1A3636))
                                  .makeCentered(),
                              10.heightBox,
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Color(0xFF1A3636)),
                                      foregroundColor:
                                          WidgetStatePropertyAll(Colors.white)),
                                  onPressed: pickupMultipleImage,
                                  child: const Text(
                                    "Selct Multiple images",
                                  )),
                              10.heightBox,
                              imageFiles.isNotEmpty
                                  ? Wrap(
                                      children: imageFiles
                                          .map((file) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Image.file(
                                                  file,
                                                  height: 100,
                                                  width: 100,
                                                ),
                                              ))
                                          .toList(),
                                    )
                                  : const Text("No files",
                                      style:
                                          TextStyle(color: Color(0xFF1A3636))),
                              10.heightBox,
                              InkWell(
                                  onTap: uploadMultiImages,
                                  child: AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      height: 40,
                                      width: uploadChange ? 50 : 150,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF1A3636),
                                          borderRadius: BorderRadius.circular(
                                              uploadChange ? 50 : 16)),
                                      child: uploadChange
                                          ? const CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          )
                                          : const Text(
                                              "Upload Images",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                              // ElevatedButton(
                              //     style: const ButtonStyle(
                              //         backgroundColor: WidgetStatePropertyAll(
                              //             Color(0xFF1A3636)),
                              //         foregroundColor:
                              //             WidgetStatePropertyAll(Colors.white)),
                              //     onPressed: uploadMultiImages,
                              //     child: const Text("Upload Images",
                              //         style: TextStyle(color: Colors.white)))
                            ],
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              20.heightBox,
                              "Add Turf Data"
                                  .text
                                  .xl3
                                  .bold
                                  .color(const Color(0xFF1A3636))
                                  .makeCentered(),
                              15.heightBox,
                              MyTextFormField(
                                  onSav: (value) {
                                    turf.name = value!;
                                  },
                                  hint: "name",
                                  icon: const Icon(Icons.person)),
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextFormField(
                                onSav: (value) {
                                  turf.description = value!;
                                },
                                hint: "description",
                                icon: const Icon(Icons.description_outlined),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextFormField(
                                  onSav: (value) {
                                    turf.addressLine = value!;
                                  },
                                  hint: "address",
                                  icon: const Icon(Icons.location_on)),
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextFormField(
                                  onSav: (value) {
                                    turf.city = value!;
                                  },
                                  hint: "city",
                                  icon: const Icon(Icons.location_city)),
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextFormField(
                                  onSav: (value) {
                                    turf.state = value!;
                                  },
                                  hint: "state",
                                  icon: const Icon(Icons.location_city)),
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextFormField(
                                  onSav: (value) {
                                    turf.country = value!;
                                  },
                                  hint: "country",
                                  icon: const Icon(Icons.location_city)),
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextFormField(
                                  onSav: (value) {
                                    turf.rent = int.parse(value!);
                                  },
                                  hint: "rent",
                                  icon: const Icon(Icons.attach_money_rounded)),
                              const SizedBox(
                                height: 20,
                              ),
                              DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF1A3636),
                                              width: 2.0))),
                                  value: turf.condition,
                                  items: ["Select Condition", "new", "old"]
                                      .map((e) {
                                    return DropdownMenuItem(
                                        value: e, child: Text(e));
                                  }).toList(),
                                  onChanged: (value) {
                                    turf.condition = value!;
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextFormField(
                                onSav: (value) {
                                  turf.capacity = int.parse(value!);
                                },
                                hint: "capacity",
                                icon: const Icon(Icons.people),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF1A3636),
                                              width: 2.0))),
                                  value: "Select Visibility",
                                  items: [
                                    "Select Visibility",
                                    "Day",
                                    "Night",
                                    "Both"
                                  ].map((e) {
                                    return DropdownMenuItem(
                                        value: e, child: Text(e));
                                  }).toList(),
                                  onChanged: (value) {
                                    turf.visibility = value!;
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: addTurfToDB,
                                  style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Color(0xFF1A3636))),
                                  child: saveChange? const CircularProgressIndicator(
                                    strokeWidth: 1,color: Colors.white,
                                  ) : "Save".text.white.xl.make(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
