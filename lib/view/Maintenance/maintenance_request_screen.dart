import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Maintenance/severity_type.dart';
import 'package:rentremedy_mobile/Model/Media/bucket_object.dart';
import 'package:rentremedy_mobile/Model/Media/upload_object_response.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/View/Components/image_full_screen_wrapper.dart';
import 'package:rentremedy_mobile/view/Components/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../Model/Media/types.dart';

class MaintenanceRequestScreen extends StatefulWidget {
  MaintenanceRequestScreen({Key? key}) : super(key: key);

  @override
  _MaintenanceRequestScreenState createState() =>
      _MaintenanceRequestScreenState();
}

class _MaintenanceRequestScreenState extends State<MaintenanceRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtItem = TextEditingController();
  final TextEditingController txtLocation = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  SeverityType dropdownValue = SeverityType.None;
  final List<BucketObject> images = [];
  bool isLoading = false;

  late ApiServiceProvider apiService;

  @override
  void initState() {
    super.initState();
    apiService = Provider.of<ApiServiceProvider>(context, listen: false);
  }

  Future<void> onImagePicked(XFile file) async {
    UploadObjectResponse response = await apiService.uploadImage(file.name, ObjectType.imageMaintenance);
  await http.put(Uri.parse(response.putUrl), 
    headers: <String, String>{
      'Content-Type': lookupMimeType(file.path) ?? 'unknown',
      }, 
    body: await File(file.path).readAsBytes());

    setState(() {
      images.add(response.bucketObject);
    });
    
    print("added image to list");
  }

  @override
  Widget build(BuildContext context) {
    ImageFilePicker imageFilePicker = ImageFilePicker(onImagePicked: onImagePicked);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorDark,
            title: const Text("Maintenance Request"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: txtItem,
                        decoration: InputDecoration(
                          labelText: 'Item',
                          labelStyle: const TextStyle(color: Colors.white),
                          hintText: "Ex. Sink",
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.blue)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Item is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: txtLocation,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          labelStyle: const TextStyle(color: Colors.white),
                          hintText: 'Ex. Kitchen',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.blue)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Location is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: txtDescription,
                        keyboardType: TextInputType.multiline,
                        minLines: 2,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: const TextStyle(color: Colors.white),
                          hintText: 'Ex. Sink is leaking',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(color: Colors.blue)),
                          // errorBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(16),
                          //     borderSide: const BorderSide(color: Colors.red)),
                          // focusedErrorBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(16),
                          //     borderSide: const BorderSide(color: Colors.red)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Severity: ",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton<SeverityType>(
                          dropdownColor: Theme.of(context).primaryColor,
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(color: Colors.white),
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          onChanged: (SeverityType? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: SeverityType.values
                              .map<DropdownMenuItem<SeverityType>>(
                                  (SeverityType type) {
                            return DropdownMenuItem<SeverityType>(
                              value: type,
                              child: Text(type.value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    Wrap(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children:
                        images.map((i) =>
                          Container(width: 100, height: 100, padding: const EdgeInsets.all(4), child: ImageFullScreenWrapperWidget(url: i.getUrl, dark: true))
                        ).followedBy(
                          [Container(width: 100, height: 100, padding: const EdgeInsets.all(4), child: IconButton(
                          icon: const Icon(Icons.add_a_photo, color: Colors.white), 
                          iconSize: 80,
                          onPressed: () async {
                            imageFilePicker.showFilePicker(context);
                            }
                          ))]).toList(),
                        ),
                    Visibility(
                        maintainSize: false,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: isLoading,
                        child: const CircularProgressIndicator()),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              await apiService.createMaintenanceRequest(
                                  txtItem.text,
                                  txtLocation.text,
                                  txtDescription.text,
                                  dropdownValue, images);

                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushReplacementNamed(
                                  context, '/maintenanceRequestSuccess');
                            } on Exception catch (e) {
                              print(
                                  "Exception while filing maintenance request.");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
