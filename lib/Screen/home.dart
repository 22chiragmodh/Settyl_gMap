import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settyl_intern/Screen/googlemappage.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton(
              icon: const Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(
                    value: 'Get Location',
                    child: Row(children: const [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text('Get Location'),
                    ])),
              ],
              onChanged: (itemindetifier) {
                if (itemindetifier == 'Get Location') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GoogleMapPage()));
                }
              }),
        ],
      ),
      body: Center(
        child: Text("Dashboard",
            style: GoogleFonts.pacifico(
                fontWeight: FontWeight.bold, fontSize: 50, color: Colors.blue)),
      ),
    );
  }
}
