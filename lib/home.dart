import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'kelas_inggris.dart';
import 'tambah_materi.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? kode, nama, deskripsi, url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TambahMateri(),
              ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
          title: Text("My-INA"),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                    (route) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Tugas'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => kelasInggris()),
                  (route) => false,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Kalender'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('materi').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                child: Card(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      return Column(
                        children: [
                          ClassCard(
                            title: documentSnapshot['nama'],
                            description:documentSnapshot['descripsi'],
                            backgroundImage: 'assets/Logo.png',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => kelasInggris()),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              );
            }
          }),
    );
  }
}

class ClassCard extends StatelessWidget {
  final String title;
  final String description;
  final String backgroundImage;
  final VoidCallback onTap;

  ClassCard({
    required this.title,
    required this.description,
    required this.backgroundImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                image: DecorationImage(
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  SizedBox(height: 10.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
