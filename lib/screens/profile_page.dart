import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/mycolors.dart';
import 'package:flutter_application_1/screens/myfonts.dart';
import 'package:flutter_application_1/screens/myicons.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_application_1/screens/setttings_page.dart';
import 'search_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Define TextEditingController for the email fields
  final TextEditingController primaryEmailController = TextEditingController();
  final TextEditingController secondaryEmailController =
      TextEditingController();

  // Define a variable to track the 2FA status
  bool is2FAEnabled = true;

  @override
  void dispose() {
    // Dispose of the TextEditingController to free up resources
    primaryEmailController.dispose();
    secondaryEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false, // Add this line
      backgroundColor: MyColors.green,
      body: Container(
        width: screenSize.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Splash.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.all(screenSize.width * 0.05), // Responsive padding
          child: BlurryContainer(
            borderRadius: BorderRadius.circular(35),
            blur: 25,
            color: MyColors.white.withAlpha(100),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal:
                    screenSize.width * 0.05, // Responsive horizontal padding
                vertical:
                    screenSize.height * 0.01, // Responsive vertical padding
              ),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: screenSize.height * 0.03), // Responsive spacing
                    TopBar(),
                    SizedBox(
                        height: screenSize.height * 0.03), // Responsive spacing
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              child: MyIcons.arrowleft(),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettingsPage()),
                                );
                              },
                            ),
                          ],
                        ),
                        Text(
                          "Account Settings",
                          style: FontStyles.pagetitle,
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                    BlurryContainer(
                      blur: 100,
                      width: screenSize.width,
                      height: 65,
                      color: MyColors.yellow.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(35),
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Your Email",
                                  style: FontStyles.settings,
                                ),
                                SizedBox(width: 5),
                                Text("|", style: FontStyles.bigtitle),
                                SizedBox(width: 5),
                                Expanded(
                                  child: TextFormField(
                                    controller: primaryEmailController,
                                    style: FontStyles.details,
                                    decoration: InputDecoration(
                                      hintText: "Enter your email",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    BlurryContainer(
                      blur: 100,
                      width: screenSize.width,
                      height: 65,
                      color: MyColors.yellow.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(35),
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "2nd Email",
                                  style: FontStyles.settings,
                                ),
                                SizedBox(width: 8),
                                Text("|", style: FontStyles.bigtitle),
                                SizedBox(width: 5),
                                Expanded(
                                  child: TextFormField(
                                    controller: secondaryEmailController,
                                    style: FontStyles.details,
                                    decoration: InputDecoration(
                                      hintText: "Enter 2nd email",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    BlurryContainer(
                      blur: 100,
                      width: screenSize.width,
                      height: 65,
                      color: MyColors.yellow.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(35),
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "2FA Method",
                                  style: FontStyles.settings,
                                ),
                                SizedBox(width: 5),
                                Text("|", style: FontStyles.bigtitle),
                                SizedBox(width: 5),
                                Text(
                                  is2FAEnabled ? "Enabled" : "Disabled",
                                  style: FontStyles.details,
                                ),
                                Expanded(child: Container()),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      is2FAEnabled = !is2FAEnabled;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: is2FAEnabled
                                        ? Colors.green
                                        : MyColors
                                            .pink, // Change color based on the is2FAEnabled flag
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  child: Text(
                                    is2FAEnabled ? "Disable" : "Enable",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Divider(
                      color: Colors.black,
                      thickness: 3,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add your onPressed action here
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 15,
                              shadowColor: MyColors.black.withAlpha(255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      35) // Set rounded corner radius
                                  ),
                              backgroundColor: MyColors.darkPurple,
                              minimumSize: Size(120, 45)),
                          child: Text(
                            'Contact Help',
                            style:
                                FontStyles.details, // Set text color to white
                          ),
                        ),
                        SizedBox(width: 14),
                        Text("OR"),
                        SizedBox(width: 14),
                        ElevatedButton(
                          onPressed: () {
                            // Add your onPressed action here
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 15,
                              shadowColor: MyColors.black.withAlpha(255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      35) // Set rounded corner radius
                                  ),
                              backgroundColor: MyColors.darkPurple,
                              minimumSize: Size(120, 45)),
                          child: Text(
                            'Website',
                            style:
                                FontStyles.details, // Set text color to white
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Text(
                      "All Copyrights reserved @ University Of Sharjah - 2023",
                      style: FontStyles.header,
                    ),
                    Expanded(child: Container()),
                    BottomNav(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
