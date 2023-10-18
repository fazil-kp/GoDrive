import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class RentalMyAccountPage extends StatefulWidget {
  @override
  State<RentalMyAccountPage> createState() => _RentalMyAccountPageState();
}

class _RentalMyAccountPageState extends State<RentalMyAccountPage> {
  Future<DocumentSnapshot<Map<String, dynamic>>> _getUserData() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('rentalProfile')
        .orderBy('lastUpdatedTime', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first;
    } else {
      throw Exception('No user data available.');
    }
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
          'My Account',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFfafafa),
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: _getUserData(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No user data available.'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final dateOfBirthTimestamp = userData['dateOfBirth'] as Timestamp?;
          String formattedDateOfBirth = 'N/A';

          if (dateOfBirthTimestamp != null) {
            final dateOfBirth = dateOfBirthTimestamp.toDate();
            formattedDateOfBirth = DateFormat('dd/MM/yyyy').format(dateOfBirth);
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      buildUserDetailTile(
                        title: 'Name',
                        subtitle: userData['name'] ?? 'N/A',
                      ),
                      buildUserDetailTile(
                        title: 'Phone Number',
                        subtitle: userData['phoneNumber'] ?? 'N/A',
                      ),
                      buildUserDetailTile(
                        title: 'Date of Birth',
                        subtitle: formattedDateOfBirth,
                      ),
                      buildUserDetailTile(
                        title: 'Address',
                        subtitle: userData['address'] ?? 'N/A',
                      ),
                      buildUserDetailTile(
                        title: 'Gender',
                        subtitle: userData['gender'] ?? 'N/A',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ListTile buildUserDetailTile({
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Colors.indigo, // Customize the title text color
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
