import 'package:flutter/material.dart';
import 'package:talk_to_me/services/shared_pref.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? myUsername, myName, myEmail, myPicture;

  getSharedPref() async {
    myUsername = await SharedpreferenceHelper().getUserName();
    myName = await SharedpreferenceHelper().getUserDisplayName();
    myEmail = await SharedpreferenceHelper().getUserEmail();
    myPicture = await SharedpreferenceHelper().getUserImage();

    setState(() {});
  }

  @override
  void initState() {
    getSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff703eff),
      body: myName == null
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.blue.shade900,
            ))
          : Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Material(
                              elevation: 4.0,
                              borderRadius: BorderRadius.circular(60),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Color(0xff406fd9),
                                  size: 30.0,
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28.0,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20, top: 30),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              myPicture!,
                              height: 70.0,
                              width: 70.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              child: Row(children: [
                                Icon(
                                  Icons.person_outline,
                                  color: Color(0xff406fd9),
                                  size: 36,
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      myName!,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              child: Row(children: [
                                Icon(
                                  Icons.mail_outline,
                                  color: Color(0xff406fd9),
                                  size: 36,
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      myEmail!,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 36,
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  "Logout",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text("Delete Account"),
                                      content: Text(
                                          "Are you sure you want to delete your account? This action cannot be undone."),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: (){},
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ));
                          },
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(children: [
                                Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                  size: 36,
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  "Delete Account",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              ),
            ),
    );
  }
}
