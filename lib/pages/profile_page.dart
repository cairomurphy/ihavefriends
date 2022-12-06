import 'package:flutter/material.dart';
import 'package:ihavefriends/auth.dart';
import 'package:ihavefriends/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ihavefriends/pages/feed%20page/feed_page.dart';
import 'package:ihavefriends/widgets/input_widgets.dart';

final _firestore = FirebaseFirestore.instance;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() {
    return ProfilePageState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ProfilePageState extends State<ProfilePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerGender = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerBiography = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();

  Future<AppUser?> getAppUser() async {
    String? userID = Auth().currentUser?.uid;
    String appUserID = userID ?? "";

    try {
      var doc = await _firestore.collection('appusers').doc(appUserID).get();
      if (doc.exists) {
        return AppUser.fromJson(doc.data()!);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return null;
  }

  Future<void> updateAppUser() async {
    String? userID = Auth().currentUser?.uid;
    String appUserID = userID ?? "";

    try {
      AppUser appUser = AppUser(
        userID: appUserID,
        firstName: _controllerFirstName.text,
        lastName: _controllerLastName.text,
        gender: _controllerGender.text,
        age: int.parse(_controllerAge.text),
        biography: _controllerBiography.text,
        phoneNumber: _controllerPhoneNumber.text,
      );
      var ref = _firestore.collection('appusers').doc(appUserID);
      await ref.set(appUser.toJson());
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var futureAppUser = getAppUser();
    final appUser = futureAppUser as AppUser;

    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActionChip(
                    label: Text("Feed Page"),
                    onPressed: () {
                      feedPage(context);
                    }),
                textEntryField("First Name", _controllerFirstName, appUser.firstName),
                textEntryField("Last Name", _controllerLastName, appUser.lastName),
                textEntryField("Gender", _controllerGender, appUser.gender),
                numericEntryField("Age", _controllerAge, appUser.age.toString()),
                textEntryField("Bio", _controllerBiography, appUser.biography),
                numericEntryField("Phone Number", _controllerPhoneNumber, appUser.phoneNumber),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      updateAppUser();
                    },
                    child: const Text('Submit'),
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

  Future<void> feedPage(BuildContext context) async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => FeedPage()));
  }
}