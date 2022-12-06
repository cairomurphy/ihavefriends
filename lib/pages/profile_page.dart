import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ihavefriends/auth.dart';
import 'package:ihavefriends/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ihavefriends/pages/edit_schedule.dart';
import 'package:ihavefriends/pages/feed%20page/feed_page.dart';
import 'package:ihavefriends/pages/login_register_page.dart';
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

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<AppUser?>(
                future: getAppUser(),
                builder: (builder, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    if (data != null) {
                      final appUser = data;

                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textEntryField("First Name", _controllerFirstName, appUser.firstName),
                                textEntryField("Last Name", _controllerLastName, appUser.lastName),
                                textEntryField("Gender", _controllerGender, appUser.gender),
                                numericEntryField("Age", _controllerAge, appUser.age.toString()),
                                textEntryField("Bio", _controllerBiography, appUser.biography),
                                numericEntryField("Phone Number", _controllerPhoneNumber, appUser.phoneNumber),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          updateAppUser();
                                        },
                                        child: const Text('Save Profile'),
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => const EditSchedule()));
                                        },
                                        child: const Text('Edit Schedule'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'unknown',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey
                          ),
                        ),
                      );
                    }
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SpinKitFadingCircle(
                        size: 20,
                        color: Colors.blue,
                      ),
                    );
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionChip(
                    label: const Text("Feed Page"),
                    onPressed: () {
                      feedPage(context);
                    }),
                const SizedBox(width: 50,),
                ActionChip(
                    label: const Text("Logout"),
                    backgroundColor: Colors.red,
                    onPressed: () {
                      logout(context);
                    }),
              ],
            ),
            const SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }

  Future<void> feedPage(BuildContext context) async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const FeedPage()));
  }
}