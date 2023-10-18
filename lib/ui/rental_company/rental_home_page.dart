import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:godrive/ui/rental_company/rental_account_page.dart';
import 'package:godrive/ui/rental_company/rental_add_vehicle_page.dart';
import 'package:godrive/ui/rental_company/rental_profile_page.dart';
import 'package:godrive/ui/user/user_account_page.dart';
import 'package:godrive/ui/user/user_register_page.dart';
import '../../reusable_widgets/color_utils.dart';
import '../../reusable_widgets/constant_fonts.dart';
import '../user/demo_page.dart';

class RentalHomePage extends StatefulWidget {
  const RentalHomePage({Key? key}) : super(key: key);

  @override
  State<RentalHomePage> createState() => _RentalHomePageState();
}

class _RentalHomePageState extends State<RentalHomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                )),
          ),
          title: Text(
            'GoDrive',
            style: TextStyle(fontFamily: Bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: hexStringToColor("0000FF"),
          actions: <Widget>[
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Demo()));
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('GoDrive'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/adminLogo.png"),
                ),
                accountEmail: null,
              ),
              buildDrawerItem(
                Icons.home,
                'Home',
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RentalHomePage())),
              ),
              buildDrawerItem(
                Icons.account_circle,
                'My Account',
                () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Demo())),
              ),
              buildDrawerItem(
                Icons.help,
                'Help',
                () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Demo())),
              ),
              buildDrawerItem(
                Icons.history,
                'History',
                () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Demo())),
              ),
              buildDrawerItem(
                Icons.logout,
                'Log out',
                () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Demo())),
              ),
            ],
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                hexStringToColor("0000CC"),
                hexStringToColor("0000CC"),
                hexStringToColor("0000CC"),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                SizedBox(height: 18),
                buildHomeButton(
                  RentalProfilePage(
                    userData: {},
                  ),
                  Icons.person_add,
                  'Profile',
                ),
                SizedBox(height: 18),
                buildHomeButton(
                  RentalAddVehiclePage(),
                  Icons.motorcycle_rounded,
                  'Add Vehicle',
                ),
                SizedBox(height: 18),
                buildHomeButton(
                  Demo(),
                  Icons.remove_red_eye,
                  'View Bookings',
                ),
                SizedBox(height: 18),
                buildHomeButton(
                  Demo(),
                  Icons.star_border,
                  'Reviews',
                ),
                SizedBox(height: 18),
                buildHomeButton(
                  Demo(),
                  Icons.history,
                  'History',
                ),
                SizedBox(height: 18),
                buildHomeButton(
                  RentalMyAccountPage(),
                  Icons.account_circle,
                  'Your Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDrawerItem(IconData icon, String text, Function onPressed) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {},
    );
  }

  Widget buildHomeButton(
      Widget navigationInButton, IconData iconInButton, String textInButton) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => navigationInButton));
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blue[50],
        onPrimary: Colors.blue[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(
              iconInButton,
              size: 55,
            ),
            SizedBox(width: 20),
            Text(
              textInButton,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
