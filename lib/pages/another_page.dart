import 'package:flutter/material.dart';
import 'package:labshared_pref/pages/first_page.dart';
import 'package:labshared_pref/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnotherPage extends StatefulWidget {
  const AnotherPage({super.key});

  @override
  State<AnotherPage> createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {
  String? myName;
  // Declare your variable for data
  final TextEditingController _nameController = TextEditingController();

  // Load data from SharedPreferences
  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myName = prefs.getString("myname");
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  // Save data to SharedPreferences
  void saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('myname', _nameController.text);
  }

  // Function to delete data from SharedPreferences
  void deleteData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('myname');
    setState(() {
      myName = null; // Clear the variable
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: const Text(
          "Another Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent[700],
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
              color: Colors.deepPurpleAccent[100],
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 1), // Spacer to push content down from the top
              Text(myName ?? "ลบชื่อเสร็จสิ้น",
                  style: TextStyle(fontSize: 24, color: Colors.white)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.blueGrey[700]; // สีเมื่อเอาเมาส์ไปชี้
                      }
                      return Colors.transparent; // สีพื้นหลังปกติ (โปร่งใส)
                    },
                  ),
                  overlayColor: MaterialStateProperty.all(Colors
                      .deepOrangeAccent
                      .withOpacity(0.8)), // สีเมื่อกดปุ่ม
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  shadowColor: MaterialStateProperty.all(
                      Colors.grey[700]), // สีของเงาปุ่ม
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 52, vertical: 15),
                  child: Text(
                    'กลับ',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FirstPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors
                            .deepPurpleAccent[400]; // สีเมื่อเอาเมาส์ไปชี้
                      }
                      return Colors.transparent; // สีพื้นหลังปกติ (โปร่งใส)
                    },
                  ),
                  overlayColor: MaterialStateProperty.all(
                      Colors.blueAccent.withOpacity(0.2)), // สีเมื่อกดปุ่ม
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  shadowColor: MaterialStateProperty.all(
                      Colors.grey[700]), // สีของเงาปุ่ม
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    'First Page',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  deleteData();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.redAccent[400]; // สีเมื่อเอาเมาส์ไปชี้
                      }
                      return Colors.transparent; // สีพื้นหลังปกติ (โปร่งใส)
                    },
                  ),
                  overlayColor: MaterialStateProperty.all(
                      Colors.redAccent.withOpacity(0.8)), // สีเมื่อกดปุ่ม
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 49, vertical: 15),
                  child: Text(
                    'ลบชื่อ',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              Spacer(flex: 2),
              // Spacer to push content up from the bottom
            ],
          ),
        ),
      ),
    );
  }
}
