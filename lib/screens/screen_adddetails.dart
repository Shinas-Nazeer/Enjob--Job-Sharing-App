import 'package:flutter/material.dart';


import '../constants/constants.dart';


class ScreenAddDetails extends StatelessWidget {
  const ScreenAddDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kThemecolor),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    decoration: style('Select Job Category'),
                  ),
                  TextFormField(
                    decoration: style('Job Title'),
                  ),
                  SizedBox(
               
                    child: TextFormField(
                      decoration: style2('Job Description:'),
                    ),
                  ),
                  TextField(
                   decoration: style('Dead line date'), 
                  ),
                  Material(
                      color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                       minWidth: 200.0,
                        height: 42.0,
                        onPressed: ()  {
                        
                            
                       
                
                        },
                        child: const Text('Post Now', style: TextStyle(color: Colors.white),)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  )
                ],
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
        borderRadius: BorderRadius.all(Radius.circular(35.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: kThemecolor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );
  }

  InputDecoration style2(
    label,
  ) {
    return InputDecoration(
      hintText: label,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(35.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: kThemecolor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );
  }
}
