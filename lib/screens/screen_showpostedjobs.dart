
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjobproject/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/jobwidget.dart';




class ScreenPostedJObs extends StatelessWidget {
ScreenPostedJObs({
    Key? key,
  }) : super(key: key);
 final user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
    //  backgroundColor: kThemecolor,
     appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: kThemecolor),
     ),
      body: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
        stream: FirebaseFirestore.instance.collection('jobs')
        .where('uploadedby', isEqualTo: user.uid)
       
        .orderBy('createdat',descending: false).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) { 

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
         else if (snapshot.connectionState == ConnectionState.active){
          if (snapshot.data?.docs.isEmpty != true){
         return SafeArea(
           child: Column(
            
            children: [
            
                 const SizedBox(height: 4,),
              Expanded(
                child: ListView.builder(
                
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: ((context, index) {
                        final jobdetails =  snapshot.data?.docs[index];
                      return  Jobwidget(jobtitle: jobdetails['jobtitle'], 
                      jobdescriptions:jobdetails['jobdescription'], uploadedby: jobdetails['name'], lastdate: jobdetails['deadlinedate'], image:jobdetails ['userimage'], trailing:
                      
                       InkWell(
                        onTap: () async {
                   
                          await FirebaseFirestore.instance.collection('jobs').doc(jobdetails['jobId']).delete();
                          await Fluttertoast.showToast(msg: 'Job has been Deleted ', 
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.green, fontSize: 18);
                        },
                        child: const Icon(Icons.delete_forever, size: 40,)), userUID: jobdetails['uploadedby'], jobId: jobdetails['jobId'], applicants: jobdetails['applicants'],);
                    })),
              ),
            ],
                 ),
         );
          }
          else{
            return SafeArea(
              child: Column(
                children: const[
                
                   Center(
                    child: Text('No pst')
                    
                  ),
                ],
              ),
            );
          }
          
         }
        return const Center(
          child: Text('Somethinf Went Wrong'),
        );
         
         },
    
      ),
    );
  }
}
String? jobcategoryfilter;



