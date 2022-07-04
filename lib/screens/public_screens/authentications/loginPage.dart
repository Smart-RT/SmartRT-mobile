import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
      ),
      backgroundColor: Colors.brown,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(25),
            child: const Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(25),
            width: double.infinity,
            height: (MediaQuery.of(context).size.height) -
                (MediaQuery.of(context).size.height) / 5,
            // color: Colors.brown[100],
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selamat Datang Kembali',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.brown,
                  ),
                ),
                Text(
                  'Hai Pengguna, Silahkan login terlebih dahulu',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.brown[400],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Text(
                  'No Telp',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.brown[400],
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan nomor telepon anda...',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
