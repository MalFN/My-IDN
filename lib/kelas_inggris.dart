import 'package:flutter/material.dart';
import 'tambah_materi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'beranda.dart';

class kelasInggris extends StatefulWidget {
  const kelasInggris({super.key});

  @override
  State<kelasInggris> createState() => _kelasInggrisState();
}

class _kelasInggrisState extends State<kelasInggris> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelas'),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.green,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.book),
            icon: Icon(Icons.book_outlined),
            label: 'Tugas',
          ),
        ],
      ),
      body: [
        Beranda(),
        Tugas(),
      ][currentPageIndex],
    );
  }
}


class Tugas extends StatefulWidget {
  const Tugas({super.key});

  @override
  State<Tugas> createState() => _TugasState();
}

class _TugasState extends State<Tugas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.assignment),
              title: Text('Tugas ${index + 1}'),
              subtitle: Text('Batas waktu: 2023-04-01'),
              trailing: const Icon(Icons.more_vert),
            ),
          );
        },
      ),
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
    );
  }
}
