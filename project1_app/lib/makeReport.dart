import 'package:flutter/material.dart';
import 'report.dart';

// lab
class MakeReport extends StatefulWidget {
  const MakeReport({Key? key}) : super(key: key);

  @override
  _MakeReportState createState() => _MakeReportState();
}

class _MakeReportState extends State<MakeReport> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController matrikNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool isFormComplete() {
    return titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        matrikNoController.text.isNotEmpty &&
        nameController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Make a Report'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: matrikNoController,
              decoration: InputDecoration(labelText: 'Matrik No'),
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            ElevatedButton(
              onPressed: () {
                if (isFormComplete()) {
                  final newReport = Report(
                    title: titleController.text,
                    description: descriptionController.text,
                    matrikNo: matrikNoController.text,
                    name: nameController.text,
                  );

                  // Snackbar
                  //https://docs.flutter.dev/cookbook/design/snackbars
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Your report has been sent.'),
                    ),
                  );

                  Navigator.pop(context, newReport); // Return the new report
                } else {
                  // Show Dialog indicating incomplete form
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Form Incomplete'),
                        content: Text('Please fill all the fields.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              //https://www.flutterbeads.com/change-icon-color-in-flutter/
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
