import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:godrive/ui/user/user_account_page.dart';
import 'package:godrive/ui/user/user_register_page.dart';
import '../../reusable_widgets/constant_fonts.dart';
import 'demo_page.dart';



class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('GoDrive',style: TextStyle(fontFamily: Bold),),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
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
                ), accountEmail: null,
              ),
              buildDrawerItem(Icons.home, 'Home', () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UserHomePage())),
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Menu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 18),
              buildHomeButton(
                UserRegisterPage(userData: {},),
                Icons.person_add,
                'Register',
              ),
              SizedBox(height: 18),
              buildHomeButton(
                Demo(),
                Icons.directions_bike,
                'View Vehicles',
              ),
              SizedBox(height: 18),
              buildHomeButton(
                Demo(),
                Icons.star,
                'Rating',
              ),
              SizedBox(height: 18),
              buildHomeButton(
                Demo(),
                Icons.history,
                'Booking History',
              ),
              SizedBox(height: 18),
              buildHomeButton(
                UserMyAccountPage(),
                Icons.account_circle,
                'User Account',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerItem(IconData icon, String text, Function onPressed) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: (){},
    );
  }

  Widget buildHomeButton(Widget navigationInButton, IconData iconInButton, String textInButton) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => navigationInButton));
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
