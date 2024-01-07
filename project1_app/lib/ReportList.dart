import 'package:flutter/material.dart';
import 'makeReport.dart'; // Import the MakeReport screen
import 'report.dart'; // Import the Report model
import 'viewReport.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  List<Report> reports = [];
//https://www.youtube.com/watch?v=jyEoMHcjdD4&pp=ygUTZmx1dHRlciBzaG93ZGlhbG9nIA%3D%3D
  Future<void> _deleteReport(int index) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this report?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );

    if (confirmDelete) {
      setState(() {
        reports.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Report deleted successfully.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Report to umt'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: reports.isEmpty
          ? const Center(
              child: Card(
                margin: EdgeInsets.all(16.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'No reports available.',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'You can make a report by clicking the plus button below.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      //https://docs.flutter.dev/cookbook/images/network-image
                      'https://e-penyata2.umt.edu.my/static/images/CUSTOM/KUST/login-screen.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: InkWell(
                      //https://www.youtube.com/watch?v=YbrrnSDCbC4&pp=ygUPaW5rd2VsbCBmbHV0dGVy
                      onDoubleTap: () {
                        //https://www.youtube.com/watch?v=8jUDsimEod8&pp=ygUTZG91YmxlIGNsaWsgZmx1dHRlcg%3D%3D
                        _deleteReport(index);
                      },
                      onHover: (isHovering) {
                        // Handle hover if needed
                      },
                      splashColor: const Color.fromARGB(255, 121, 33, 243)
                          .withOpacity(0.5),
                      child: ListTile(
                        tileColor: MaterialStateColor.resolveWith(
                          (states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.blue;
                            } else {
                              return Colors.blue.withOpacity(0.5);
                            }
                          },
                        ),
                        title: Text(reports[index].title),
                        subtitle: Text(reports[index].description),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ViewReport(report: reports[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MakeReport()),
          );

          if (result != null && result is Report) {
            setState(() {
              reports.add(result);
            });
          }
        },
        //https://www.flutterbeads.com/change-icon-color-in-flutter/
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
