import 'package:blood_bank/constants/custom_colors.dart';
import 'package:blood_bank/provider/auth_provider.dart';
import 'package:blood_bank/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: CustomColors.firstGradientColor,
            foregroundColor: CustomColors.whiteColor),
        drawer: _buildDrawer(context),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.375,
              child: Stack(
                children: [
                  _getBackgroundContainer(size, ap.userModel.name),
                  _getCards()
                ],
              ),
            ),

            // spacing
            const Spacer(),

            // buttons
            _buildButton(size, "Find Donors", "/find_donors"),
            _buildButton(size, "Donate Blood", "/requests"),
            SizedBox(
              height: size.height * 0.1,
            ),
          ],
        ));
  }

  Widget _getCards() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCard("Your Blood Group", "assets/blood.png"),
          _buildCard("Donor Status", "assets/check.png"),
        ],
      ),
    );
  }

  Widget _getBackgroundContainer(Size size, String name) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      alignment: Alignment.topCenter,
      height: size.height * 0.25,
      decoration: const BoxDecoration(
        color: CustomColors.firstGradientColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Text("Hello $name",
          style: const TextStyle(
              color: CustomColors.whiteColor,
              fontSize: 36,
              fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildButton(Size size, String label, String path) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, path),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        width: size.width * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [
              CustomColors.firstGradientColor,
              CustomColors.secondGradientColor,
            ],
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: CustomColors.whiteColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String label, String imgName) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 1,
              blurStyle: BlurStyle.solid,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      height: 210,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    imgName,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Center(
                    child: Text(
                        label == "Your Blood Group"
                            ? ap.userModel.bloodGroup
                            : "",
                        style: const TextStyle(
                            color: CustomColors.whiteColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w800))),
              )),
          label == "Donor Status"
              ? const Text(
                  "You can Donate",
                  style: TextStyle(color: Colors.grey),
                )
              : Container()
        ],
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              curve: Curves.linear,
              child: Container(
                  decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/splash_screen.png'),
                ),
              )),
            ),
            ListTile(
              title: const Text(
                'Messages',
                style: MyWidget.textXl,
              ),
              onTap: () {
                // go to messages
                MyWidget.navigateTo(context, '/messages');
              },
            ),
            ListTile(
              title: const Text(
                'Requests',
                style: MyWidget.textXl,
              ),
              onTap: () {
                // go to requests
                MyWidget.navigateTo(context, '/requests');
              },
            ),
            ListTile(
              title: const Text(
                'History',
                style: MyWidget.textXl,
              ),
              onTap: () {
                // go to history
                MyWidget.navigateTo(context, "/history");
              },
            ),
            ListTile(
              title: const Text(
                'Settings',
                style: MyWidget.textXl,
              ),
              onTap: () {
                // go to settings
                MyWidget.navigateTo(context, "/settings");
              },
            ),

            // button to sign out
            const Spacer(),
            InkWell(
              onTap: () {
                ap.signOut().then(
                    (value) => Navigator.pushNamed(context, '/onboarding3'));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: CustomColors.firstGradientColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sign Out",
                        style: TextStyle(
                            color: CustomColors.firstGradientColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                    Icon(Icons.logout, color: CustomColors.firstGradientColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ));
  }
}
