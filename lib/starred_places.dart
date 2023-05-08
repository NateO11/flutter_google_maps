import 'package:flutter/material.dart';

///i hate this
class CampusTourHome extends StatelessWidget {
  final List<String> campuses = [
    'UVA',
    'Harvard',
    'Stanford'
  ]; // example campuses

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CampusTour'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.0),
            Text(
              'Welcome to CampusTour',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Choose your campus:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: campuses.length,
                itemBuilder: (BuildContext context, int index) {
                  final campus = campuses[index];
                  return CampusCard(campus: campus);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CampusCard extends StatelessWidget {
  final String campus;

  CampusCard({required this.campus});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CampusDetail(campus: campus)),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                campus,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Discover the campus with student recommendations and insider tips.',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CampusDetail extends StatelessWidget {
  final String campus;

  CampusDetail({required this.campus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(campus),
      ),
      body: Column(
        children: [
          Container(
            height: 200.0,
            child: MapView(campus: campus),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (BuildContext context, int index) {
                final location = locations[index];
                return LocationCard(location: location);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final Location location;

  LocationCard({required this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LocationDetail(location: location)),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    location.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (location.isStarred)
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                location.description,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationDetail extends StatelessWidget {
  final Location location;

  LocationDetail({required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  location.name,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (location.isStarred)
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              location.description,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Image.network(
              location.imageUrl,
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Classes held here:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            if (location.classes.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: location.classes.map((classTitle) {
                  return Text(
                    '- $classTitle',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  );
                }).toList(),
              ),
            SizedBox(height: 16.0),
            Text(
              'History:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              location.history,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapView extends StatelessWidget {
  final String campus;

  MapView({required this.campus});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement map view
    return Container();
  }
}

class Location {
  final String name;
  final String description;
  final String history;
  final String imageUrl;
  final bool isStarred;
  final List<String> classes;

  Location({
    required this.name,
    required this.description,
    required this.history,
    required this.imageUrl,
    this.isStarred = false,
    this.classes = const [],
  });
}

List<Location> locations = [
  Location(
    name: 'Alderman Library',
    description:
        'Alderman Library is the main library of the University of Virginia. The library has millions of books, manuscripts, and other materials.',
    history:
        'Alderman Library was opened in 1938 and was named after Edwin Alderman, the first president of the University of Virginia.',
    imageUrl:
        'https://news.virginia.edu/sites/default/files/article_image/alderman_renovation_header_3-2.jpg',
    classes: ['English 101', 'History 202', 'Sociology 101'],
  ),
  Location(
    name: 'Rotunda',
    description:
        'The Rotunda is a building located in the center of the University of Virginia. It was designed by Thomas Jefferson and inspired by the Pantheon in Rome.',
    history:
        'The Rotunda was constructed between 1822 and 1826 and was originally used as the university library. It now serves as a symbol of the university.',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/a/ae/University_of_Virginia_Rotunda_2006.jpg',
    isStarred: true,
    classes: ['Architecture 101', 'History 101', 'Political Science 202'],
  ),
  Location(
    name: 'Newcomb Hall',
    description:
        'Newcomb Hall is a student center on the University of Virginia campus. It contains dining facilities, meeting rooms, and offices for student organizations.',
    history:
        'Newcomb Hall was opened in 1958 and was named after Josephine Louise Newcomb, a philanthropist who donated money for its construction.',
    imageUrl:
        'https://i0.wp.com/www.coleanddenny.com/wp-content/uploads/2020/07/HDPhoto_130723_14_FS2.jpg?fit=1024%2C683&ssl=1',
    classes: ['Business 101', 'Communication Studies 202'],
  ),
  Location(
    name: 'Memorial Gymnasium',
    description:
        'Memorial Gymnasium is a gymnasium located on the University of Virginia campus. It is home to the university\'s basketball and volleyball teams.',
    history:
        'Memorial Gymnasium was constructed in 1924 and was named in honor of the university alumni who died in World War I.',
    imageUrl:
        'https://www.dhr.virginia.gov/wp-content/uploads/2018/04/104-0095_Memorial_Gym_2015_exterior_facade_VLR_Online.jpg',
    isStarred: true,
    classes: ['Kinesiology 101', 'Sports Medicine 202'],
  ),
];

void main() {
  runApp(CampusTourApp());
}

class CampusTourApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusTour',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CampusTour'),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          return LocationCard(location: locations[index]);
        },
      ),
    );
  }
}
