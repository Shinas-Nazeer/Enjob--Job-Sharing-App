import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjobproject/globalerror/errormessage.dart';
import 'package:enjobproject/jobcategory/jobcatlist.dart';
import 'package:enjobproject/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../constants/constants.dart';
import '../globalerror/globalvariables.dart';

class ScreenAddDetails extends StatefulWidget {
  const ScreenAddDetails({super.key});

  @override
  State<ScreenAddDetails> createState() => _ScreenAddDetailsState();
}

class _ScreenAddDetailsState extends State<ScreenAddDetails> {
  String? category;
  final user = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController =
      TextEditingController(text: 'Select Deadline Date');
  final TextEditingController _jobCatController =
      TextEditingController(text: 'Select Category');
  final TextEditingController _jobtitleController = TextEditingController();
  final TextEditingController _jobdescriptionController =
      TextEditingController( );
       final TextEditingController _joblocationController =
      TextEditingController( );
  DateTime? picked;

  Timestamp? deadLinedateTimestamp;

  void _pickDate() async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 0)),
        lastDate: DateTime(2050));

    if (picked != null) {
      setState(() {
        _dateController.text =
            '${picked!.day} - ${picked!.month}- ${picked!.year}';
        deadLinedateTimestamp = Timestamp.fromMicrosecondsSinceEpoch(
            picked!.microsecondsSinceEpoch);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Post Your Requirement',
            style: TextStyle(color: kBlack),
          ),
          iconTheme: const IconThemeData(color: kBlack  ),
          backgroundColor: kWhite,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: Card(
            color: kWithe70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          showcatDialogtoUser(context, size);
                        },
                        child: TextFormField(
                          controller: _jobCatController,
                          enabled: false,
                          decoration: style('Select Job Category'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) => validatefields(value),
                        decoration: style('Job Title'),
                        controller: _jobtitleController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 7,
                        validator: (value) => validatefields(value),
                        decoration: style('Job Description:'),
                        controller: _jobdescriptionController,
                      ),
                        const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) => validatefields(value),
                        decoration: style('Job Location'),
                        controller: _joblocationController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _pickDate();
                        },
                        child: TextFormField(
                          controller: _dateController,
                          enabled: false,
                          validator: (value) => validatefields(value),
                          decoration: style('Dead line date'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Mybutton(
                          label: 'Post Now',
                          ontap: () async {
                            final jobId = const Uuid().v4();
                            User? user = FirebaseAuth.instance.currentUser;
                            final uid = user!.uid;

                            if (_formKey.currentState!.validate()) {
                              if (_dateController.text ==
                                      'Select Deadline Date' ||
                                  _jobCatController.text == 'Select Category') {
                              globalMessage(color: Colors.red, messgae: 'Please Select all details');
                              } else {
                                try {
                                  await FirebaseFirestore.instance
                                      .collection('jobs')
                                      .doc(jobId)
                                      .set({
                                    'jobId': jobId,
                                    'uploadedby': uid,
                                    'email': user.email,
                                    'joblocation': _joblocationController.text,
                                    'jobtitle': _jobtitleController.text,   
                                    'jobdescription':
                                        _jobdescriptionController.text,
                                    'deadlinedate': _dateController.text,
                                    'deadlinedatetimestamp':
                                        deadLinedateTimestamp,
                                    'jobcategory': _jobCatController.text,
                                    'jobcomments': [],
                                    'requirement': true,
                                    'createdat': Timestamp.now(),
                                    'applicants': 0,
                                    'name': user.displayName!,
                                    'userimage': user.photoURL,
                                    'location': locations,
                                    'listofapplicants':[],
                                    'messages':[],
                                    'applicantslist':[]
                                  });
                                  globalMessage(
                                      color: Colors.green,
                                      messgae: 'Uploaded SuceesFuly');

                                  _jobCatController.clear();
                                  _dateController.clear();
                                  _jobtitleController.clear();     
                                  _jobCatController.clear();
                                  _jobdescriptionController.clear();
                                  _joblocationController.clear();
                                } catch (e) {
                                  print(e);
                                }
                              }
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  InputDecoration style(
    label,
  ) {
    return InputDecoration(
      hintText: label,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: kBlack, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: kBlack, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }

  showcatDialogtoUser(context, Size size) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text('Select Job Category',
                style: TextStyle(fontSize: 18)),
            content: SizedBox(
              width: size.width * 0.9,
              child: ListView.builder(
                  itemCount: Jobcategory.jobcategorylist.length,
                  shrinkWrap: true,
                  itemBuilder: ((ctx, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _jobCatController.text =
                              Jobcategory.jobcategorylist[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.play_arrow_rounded),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Jobcategory.jobcategorylist[index],
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    );
                  })),
            ));
      });
}


validatefields(value) {
  if (value!.isEmpty) {
    return 'Please Fill these Fields';
  } else {
    return null;
  }
}
