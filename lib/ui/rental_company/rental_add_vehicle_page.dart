import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RentalAddVehiclePage extends StatefulWidget {
  @override
  _RentalAddVehiclePageState createState() => _RentalAddVehiclePageState();
}

class _RentalAddVehiclePageState extends State<RentalAddVehiclePage> {
  final _formKey = GlobalKey<FormState>();
  final vehiclesRef = FirebaseFirestore.instance.collection('addVehicle'); // Updated collection reference
  final storageRef = FirebaseStorage.instance.ref();

  String documentId = '';
  String vehicleName = '';
  String phoneNumber = '';
  DateTime date = DateTime.now();
  String confirmationMessage = '';
  File? imageFile;

  // Function to format date as "DD/MM/YYYY"
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Register',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    'Fill out the form to add a vehicle:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Image Picker Button
                ElevatedButton(
                  onPressed: () async {
                    final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        imageFile = File(pickedFile.path);
                      });
                    }
                  },
                  child: Text('Upload Photo'),
                ),
                // Display Selected Image
                if (imageFile != null)
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(imageFile!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                SizedBox(height: 14),
                // Vehicle Name Input
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.directions_car),
                    labelText: 'Vehicle Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      vehicleName = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the vehicle name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14),
                // Phone Number Input
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{0,10}$')),
                  ],
                  onChanged: (value) {
                    if (value.length <= 10) {
                      setState(() {
                        phoneNumber = value;
                      });
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty || value.length != 10) {
                      return 'Please enter a 10-digit phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14),
                // Date Picker
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: Icon(Icons.calendar_today),
                      ),
                      Text(
                        formatDate(date),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && imageFile != null) {
                        if (documentId.isEmpty) {
                          addVehicle();
                        } else {
                          updateVehicle(documentId);
                        }
                      }
                    },
                    child: Text(documentId.isEmpty ? 'Add Vehicle' : 'Edit Vehicle'),
                  ),
                ),
                Text(
                  confirmationMessage,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addVehicle() async {
    // Upload image to Firebase Storage
    final imageFileName = 'vehicle_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final imageRef = storageRef.child(imageFileName);
    await imageRef.putFile(imageFile!);
    final imageUrl = await imageRef.getDownloadURL();

    final vehicleData = {
      'vehicleName': vehicleName,
      'phoneNumber': phoneNumber,
      'date': date,
      'imageUrl': imageUrl, // Add the image URL to Firestore
    };

    vehiclesRef.add(vehicleData).then((DocumentReference document) {
      setState(() {
        documentId = document.id;
        vehicleName = '';
        phoneNumber = '';
        date = DateTime.now();
        confirmationMessage = 'Vehicle added successfully';
      });
    });
  }

  void updateVehicle(String documentId) {
    // Updating vehicle data can be done similarly to adding data
    // Just make sure to use the existing document reference in Firestore.
    // You can add this code here if needed.
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != date) {
      setState(() {
        date = pickedDate;
      });
    }
  }
}
