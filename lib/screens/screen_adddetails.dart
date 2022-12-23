import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjobproject/globalerror/errormessage.dart';
import 'package:enjobproject/jobcategory/jobcatlist.dart';
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
  DateTime? picked;

  Timestamp? deadLinedateTimestamp;
  String? jobtitle;
  String? jobdescription;

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
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kThemecolor),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: Container(
            decoration: const BoxDecoration(
                color: kThemecolor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
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
                        onChanged: (value) {
                          jobtitle = value;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        maxLines: 10,
                        validator: (value) => validatefields(value),
                        decoration: style('Job Description:'),
                        onChanged: (value) {
                          jobdescription = value;
                        },
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
                      button(formKey: _formKey, dateController: _dateController, jobCatController: _jobCatController, jobtitle: jobtitle, jobdescription: jobdescription, deadLinedateTimestamp: deadLinedateTimestamp),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                      )
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
        borderSide: BorderSide(color: kThemecolor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
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

class button extends StatelessWidget {
  const button({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController dateController,
    required TextEditingController jobCatController,
    required this.jobtitle,
    required this.jobdescription,
    required this.deadLinedateTimestamp,
  }) : _formKey = formKey, _dateController = dateController, _jobCatController = jobCatController, super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _dateController;
  final TextEditingController _jobCatController;
  final String? jobtitle;
  final String? jobdescription;
  final Timestamp? deadLinedateTimestamp;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlueAccent,
      borderRadius:
          const BorderRadius.all(Radius.circular(30.0)),
      elevation: 5.0,
      child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () async {
          final jobId = const Uuid().v4();
          User? user = FirebaseAuth.instance.currentUser;
          final uid = user!.uid;



            if (_formKey.currentState!.validate()) {
              if (_dateController.text == 'Select Deadline Date'||
                  _jobCatController.text ==
                     'Select Category' ) {
                        errormessage(context, 'Please Select all details');
                     
                      }
                       else{
              try{
                await FirebaseFirestore.instance.collection('jobs').doc(jobId).set({
                 'jobId':jobId,
                 'uploadedby':uid,
                 'email' :user.email,
                 'jobtitle':jobtitle,
                 'jobdescription':jobdescription,
                 'deadlinedate':_dateController.text,
                 'deadlinedatetimestamp':deadLinedateTimestamp,
                 'jobcategory': _jobCatController.text,
                 'jobcomments': [],
                 'requirement': true,
                 'createdat': Timestamp.now(),
                 'applicants':0,
                 'name': user.displayName!,
                 'userimage': user.photoURL,
                 'location': locations


                });
                await Fluttertoast.showToast(msg: 'Uploaded SuceesFuly',
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.green,
                fontSize:18.0 );
          
            //  _jobCatController.clear();
            //   _dateController.clear();
            //   jobtitle = null;
            //   jobdescription = null;
         
             
              }
              catch (e){
print(e);
              }
            }
            }
        
           
          },
          child: const Text(
            'Post Now',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}

validatefields(value) {
  if (value!.isEmpty) {
    return 'Please Fill these Fields';
  } else {
    return null;
  }
}
