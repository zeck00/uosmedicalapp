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
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.green,
      body: SingleChildScrollView(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
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
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      color: MyColors.yellow.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(35),
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "Your Email",
                                  style: FontStyles.settings,
                                ),
                                SizedBox(width: 5),
                                Text("|", style: FontStyles.bigtitle),
                                SizedBox(width: 5),
                                Text(
                                  "U22106802@sharjah.ac.ae",
                                  style: FontStyles.details,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    BlurryContainer(
                      blur: 100,
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      color: MyColors.yellow.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(35),
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "2nd Email",
                                  style: FontStyles.settings,
                                ),
                                SizedBox(width: 8),
                                Text("|", style: FontStyles.bigtitle),
                                SizedBox(width: 5),
                                Text(
                                  "ZZZZZZZZZ@sharjah.ac.ae",
                                  style: FontStyles.details,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    BlurryContainer(
                      blur: 100,
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      color: MyColors.yellow.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(35),
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  "2FA Method",
                                  style: FontStyles.settings,
                                ),
                                SizedBox(width: 5),
                                Text("|", style: FontStyles.bigtitle),
                                SizedBox(width: 5),
                                Text(
                                  "Enabled",
                                  style: FontStyles.details,
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
