
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:godrive/ui/rental_company/rental_home_page.dart';
import 'package:godrive/ui/rental_company/rental_login_page.dart';
import 'package:godrive/ui/user/user_home_page.dart';
import 'package:godrive/ui/user/user_login_page.dart';


class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        // Exit the app when back button is pressed on the Home screen
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height/8,),
            Center(child: Text("Select your account type.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.height/28),)),
            SizedBox(height: size.height/20,),
            Center(
              child:
              Container(alignment: AlignmentDirectional.center,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                width: size.width/1.3,
                height: size.height/4,
                child:
                Wrap(spacing: size.width/20,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RentalHomePage()));
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        width: size.width/4,
                        height: size.height/7,
                        child: Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.directions_bike_outlined,
                              color: Colors.blue,
                              size: size.height/10,),
                            Text('Rental',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.height/50),),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  UserHomePage()));

                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                        ),
                        width: size.width/4,
                        height: size.height/7,
                        child: Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.person,
                              color: Colors.blue,
                              size: size.height/10,),
                            Text('User',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: size.height/50),)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),

      ),
    );
  }
}
