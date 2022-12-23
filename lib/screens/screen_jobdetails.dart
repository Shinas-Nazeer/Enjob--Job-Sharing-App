import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjobproject/constants/constants.dart';
import 'package:enjobproject/screens/screen_curvednavigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenJobdetails extends StatefulWidget {
  const ScreenJobdetails({
    super.key,
    required this.uploadedby,
    required this.image,
    required this.jobTitle,
    required this.userUId,
    required this.jobId,
    required this.jobdescription,
    required this.lastdate1,
    required this.applicants,
  });

  final String uploadedby;
  final String image;
  final String jobTitle;
  final String userUId;
  final String jobId;
  final String jobdescription;
  final String lastdate1;
  final int applicants;

  @override
  State<ScreenJobdetails> createState() => _ScreenJobdetailsState();
}

class _ScreenJobdetailsState extends State<ScreenJobdetails> {
  final user = FirebaseAuth.instance.currentUser!;
  bool recuirement1 = true;

  getjobdetail() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('jobs')
        .doc(widget.jobId)
        .get();

    setState(() {
      recuirement1 = userDoc.get('requirement');
    });
  }


  @override
  void initState() {
    getjobdetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        leading: IconButton(
          color: kBlack54,
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => BottomNavBar())));
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              color: kWithe70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          widget.jobTitle,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Colors.grey,
                              ),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage(widget.image),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          //image
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.uploadedby,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  'Kottayam',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      dividerWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.applicants}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text(
                            'Applicants',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.how_to_reg_sharp)
                        ],
                      ),
                      user.uid != widget.userUId
                          ? dividerWidget()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dividerWidget(),
                                const Text('Recuritment'),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Switch(
                                        activeColor: Colors.green,
                                        value: recuirement1,
                                        onChanged: (newValue) {
                                          setState(() {
                                            recuirement1 = newValue;
                                            FirebaseFirestore.instance
                                                .collection('jobs')
                                                .doc(widget.jobId)
                                                .update({
                                              'requirement': recuirement1
                                            });
                                          });
                                        })
                                  ],
                                ),
                              ],
                            ),
                      const Text('Job Description: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.jobdescription,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 14),
                      ),
                      dividerWidget(),
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              color: kWithe70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // addnewApplicant();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          color: Colors.blue.shade300,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                //deadline condition
                                Center(
                                  child: Text(
                                    'Actively Recuriting, send Cv/Resume',
                                    style: TextStyle(
                                        color: kWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    dividerWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Last date: '),
                        Text(widget.lastdate1),
                      ],
                    ),
                    dividerWidget()
                  ],
                ),
              ),
            ),
          ),
      //    Padding(padding: EdgeInsets.all(4.0),
      //   child: Card(
      //      color: Colors.white70,
      // child: Padding(padding: EdgeInsets.all(8.0),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [],
      // ),),
      //   ), )
        ],
      )),
    );
  }
}

Widget dividerWidget() {
  return Column(
    children: const [
      SizedBox(
        height: 10,
      ),
      Divider(
        thickness: 1,
        color: Colors.grey,
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}

