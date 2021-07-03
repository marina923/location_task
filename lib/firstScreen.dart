import 'location.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController _cityName = TextEditingController();
    TextEditingController _distance = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(
          'Calculate Distance',
          style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width * 0.8,
                  child: TextField(
                    maxLines: 2,
                    controller: _cityName,
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Your Location will appear here',
                      //labelText: "Your Distance will appear here ",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: CircleAvatar(
                    child: IconButton(
                      icon: Icon(
                        Icons.location_on,
                        size: width * 0.06,
                      ),
                      onPressed: () async {
                        LocationK loc = LocationK();
                        String cityN = await loc.determineLocationName(
                            await loc.determinePosition());
                        _cityName.text = cityN;
                        _distance.text = await loc
                            .determineDistanceBetweenTwoLocations(
                                await loc.determinePosition())
                            .toString();
                        print(_distance);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.03, horizontal: width * 0.04),
              child: Text(
                'The Distance between the two locations is:',
                style: TextStyle(
                    fontSize: width * 0.06, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.03, horizontal: width * 0.04),
              child: TextField(
                controller: _distance,
                enabled: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  //labelText: "Your Distance will appear here ",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
