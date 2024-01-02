import 'package:belajar_sqflite/create_page.dart';
import 'package:belajar_sqflite/database_instance.dart';
import 'package:belajar_sqflite/produk_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

//HOME PAGE
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseInstance? databaseInstance;

  Future initDatabase() async {
    await databaseInstance!.cekDatabase();
    setState(() {});
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return const CreatePage();
                  }))
                      //menentukan tindakan yang akan diambil ketika nilai dari Future tersebut sudah tersedia.
                      .then((value) {
                    setState(() {});
                  });
                },
                icon: const Icon(Icons.add))
          ],
          title: const Text('belajar sqflite'),
        ),
        body: databaseInstance != null
            ? FutureBuilder<List<ProdukModel>>(
                future: databaseInstance!.allData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            subtitle:
                                Text(snapshot.data![index].category ?? ''),
                            leading: Text(snapshot.data![index].createAt ??
                                'data kosong'),
                            title: Text(snapshot.data![index].name ?? ''),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
