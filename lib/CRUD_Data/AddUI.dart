import 'package:flutter/material.dart';

class AddUI extends StatelessWidget {
  const AddUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/home");
                  },
                  icon: Icon(Icons.home)),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/databloc");
                  },
                  icon: Icon(Icons.person)),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600'),
            ),
            ListTile(
              //leading: Icon(Icons.privacy_tip),
              title: Text(
                'Ali',
                style: TextStyle(
                    fontFamily: 'Schyler',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "ali@google.com",
                style: TextStyle(
                  fontFamily: 'Schyler',
                  fontSize: 15,
                ),
              ),
              //trailing: Icon(Icons.arrow_forward_ios),
            ),
            Text("IBA Student, ComputerScience and Flutter App Develpmnt",
                style: TextStyle(
                  fontFamily: 'Schyler',
                  fontSize: 25,
                )),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: ListTile(
                tileColor: Colors.grey,
                leading: Icon(Icons.privacy_tip),
                title: Text('Privacy'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: ListTile(
                tileColor: Colors.grey,
                leading: Icon(Icons.help),
                title: Text('Help & Support'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: ListTile(
                tileColor: Colors.grey,
                leading: Icon(Icons.privacy_tip),
                title: Text('Settings'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: ListTile(
                tileColor: Colors.grey,
                leading: Icon(Icons.privacy_tip),
                title: Text('Invite a Friend'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              child: ListTile(
                tileColor: Colors.grey,
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            )
          ],
        ),
      ),
    );
  }
}
