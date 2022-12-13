

import 'package:flutter/material.dart';

import '../constants/constants.dart';


class ScreenForgetPassword extends StatefulWidget {
  const ScreenForgetPassword({super.key});

  @override
  State<ScreenForgetPassword> createState() => _ScreenForgetPasswordState();
}

class _ScreenForgetPasswordState extends State<ScreenForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: kThemecolor, elevation: 0 ,),
      backgroundColor: kThemecolor,
      body: Column(
       
      
        children: [
    SizedBox(height: 150,),       
          Text('Enter Your Email we Will Send \n You a Password Reset Link', style: TextStyle(color: Colors.white),),
          SizedBox(height: 5,),
            Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
              //  validator: (value){
              //   if(value!.isEmpty || !value.contains('@')){
              //      return 'Please Enter a Valid Email address';
              //   }
              //   else {
              //     return null;
              //   }
              //  },
                      textAlign: TextAlign.center,
                      // onChanged: (value1) {
                      //   name = value1;
                      // },
                      decoration: style('Enter Username'),
                    ),
                  ),
                  SizedBox(height: 15,), 
   Material(
                      color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                       minWidth: 200.0,
                        height: 42.0,
                        onPressed: ()  {
                      
                
                        },
                        child: const Text('Reset Password', style: TextStyle(color: Colors.white),)),
                  ),
              
        ],

      ),
    );
  }
    InputDecoration style(label, {Widget1 = const Icon(Icons.person)}) {
    return InputDecoration(
   
     
       suffix: Widget1,
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
    );}
}