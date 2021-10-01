import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:share/share.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  bool _allTimeStatus = true;
  int _intialStateIndex = 0;
  int _userIndex = 0;

  final leaderboardToday = [
    {
      'name': 'John Doe',
      'score': '1354',
      'rank': '1',
    },
    {
      'name': 'Lacey Meyer',
      'score': '1234',
      'rank': '2',
    },
    {
      'name': 'Desmond Green',
      'score': '1120',
      'rank': '3',
    },
    {
      'name': 'Mathew Stuart',
      'score': '1020',
      'rank': '4',
    },
    {
      'name': 'Liliana Harrell',
      'score': '934',
      'rank': '5',
    },
    {
      'name': 'Jewell Williamson',
      'score': '854',
      'rank': '6',
    },
    {
      'name': 'Margarita Hendricks',
      'score': '854',
      'rank': '6',
    },
    {
      'name': 'Kristine Wheeler',
      'score': '731',
      'rank': '8',
    },
    {
      'name': 'Andreas Turner',
      'score': '690',
      'rank': '9',
    },
    {
      'name': 'Kathleen Tapia',
      'score': '524',
      'rank': '10',
    }
  ];

  final allTime = [
    {
      'name': 'John Doe',
      'score': '10254',
      'rank': '1',
    },
    {
      'name': 'John Toe',
      'score': '10254',
      'rank': '1',
    },
    {
      'name': 'Lacey Meyer',
      'score': '9834',
      'rank': '2',
    },
    {
      'name': 'Desmond Green',
      'score': '9439',
      'rank': '3',
    },
    {
      'name': 'Mathew Stuart',
      'score': '8561',
      'rank': '4',
    },
    {
      'name': 'Liliana Harrell',
      'score': '8234',
      'rank': '5',
    },
    {
      'name': 'Jewell Williamson',
      'score': '8154',
      'rank': '6',
    },
    {
      'name': 'Margarita Hendricks',
      'score': '7238',
      'rank': '7',
    },
    {
      'name': 'Kristine Wheeler',
      'score': '7131',
      'rank': '8',
    },
    {
      'name': 'Andreas Turner',
      'score': '6900',
      'rank': '9',
    },
    {
      'name': 'Kathleen Tapia',
      'score': '5234',
      'rank': '10',
    },
  ];

  var userData = {
    'name': 'Jewell Williamson',
    'score': '854',
    'rank': '6',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* backgroundColor: Colors.lightBlueAccent, */
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(children: <Widget>[
            ClipPath(
              clipper: ClipPathClass(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "lib/assets/spotlight.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //Vertically center user avatar
            Center(
                child: Column(
              children: [
                //Enclose text with padding
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    "Leaderboard",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ToggleSwitch(
                  minWidth: 90.0,
                  initialLabelIndex: _intialStateIndex,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  labels: ['Today', 'All time'],
                  activeBgColors: [
                    [Colors.blue],
                    [Colors.lightBlueAccent.shade200]
                  ],
                  onToggle: (index) {
                    setState(() {
                      _allTimeStatus = (index == 1);
                      _intialStateIndex = index;
                      if(index == 0){
                        _userIndex = leaderboardToday.indexWhere((element) => element['name'] == userData['name']);
                        if(_userIndex != -1){
                          userData = leaderboardToday[_userIndex];
                        }else{
                          _userIndex = allTime.indexWhere((element) => element['name'] == userData['name']);
                          userData = allTime[_userIndex];
                        }
                      } else {
                        _userIndex = allTime.indexWhere((element) => element['name'] == userData['name']);
                        userData = allTime[_userIndex];
                      }
                    });
                  },
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.amber,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("lib/assets/avatar.jpg"),
                    ),
                  ),
                ),
                Text(
                  _allTimeStatus
                      ? allTime[0]['name'].toString()
                      : leaderboardToday[0]['name'].toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ))
          ]),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount:
                    _allTimeStatus ? allTime.length : leaderboardToday.length,
                itemBuilder: (context, index) {
                  var colour = Colors.grey.shade200;
                  var shadowColour = Colors.white;
                  var fontColour = Colors.grey.withOpacity(1.0);
                  if(index == 0) {
                    colour = Colors.amber;
                    shadowColour = Colors.amber.withOpacity(0.5);
                    fontColour = Colors.white;
                  }else if(index == 1){
                    colour = Colors.grey;
                    shadowColour = Colors.grey.withOpacity(0.5);
                    fontColour = Colors.white;
                  }else if(index == 2){
                    colour = Color.fromRGBO(205, 127, 50, 1.0);
                    shadowColour = Color.fromRGBO(205, 127, 50, 0.5);
                    fontColour = Colors.white;
                  }else if(index == _userIndex){
                    colour = Colors.blue;
                    shadowColour = Colors.blue.withOpacity(0.5);
                    fontColour = Colors.white;
                  }
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 3.0, 8.0, 3.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colour,
                          boxShadow: [
                            BoxShadow(
                              color: shadowColour,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              //Show rank
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 4.0, right: 4.0),
                                  child: Text(
                                    _allTimeStatus
                                        ? allTime[index]['rank'].toString()
                                        : leaderboardToday[index]['rank']
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: fontColour,
                                    ),
                                  )),
                              //Show avatar
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage("lib/assets/avatar.jpg"),
                                    ),
                                  ),
                                ),
                              ),
                              //Show name
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
                                child: Text(
                                  _allTimeStatus
                                      ? allTime[index]['name'].toString()
                                      : leaderboardToday[index]['name']
                                          .toString(),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]),
                            //Show score
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4.0),
                              child: Text(
                                _allTimeStatus
                                    ? allTime[index]['score'].toString()
                                    : leaderboardToday[index]['score']
                                        .toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                            ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //Show the user's rank
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      userData['rank'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //Show the user's avatar
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("lib/assets/avatar.jpg"),
                        ),
                      ),
                    ),
                  ),
                  //Show the user's name
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      userData['name'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //Show the user's score
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      userData['score'].toString(), 
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.share), color: Colors.white, onPressed: (){
                    Share.share("I'm on the Leaderboard! Check out my score on the Sporty Sam app!");
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
