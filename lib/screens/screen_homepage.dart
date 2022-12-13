

import 'package:enjobproject/constants/constants.dart';
import 'package:enjobproject/screens/screen_jobprofile.dart';
import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';


class ScreenHomePage extends StatelessWidget {
  const ScreenHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
      
        child: Column(
          
          children: [
            SearchBarAnimation(
              searchBoxBorderColour: kThemecolor,
              buttonShadowColour: kThemecolor,
             cursorColour: kThemecolor,
              trailingWidget: Icon(Icons.sort_sharp, color: kThemecolor,),
          textEditingController: TextEditingController(),
          isOriginalAnimation: false,
          buttonBorderColour: kThemecolor,
          buttonWidget: Icon(Icons.search, color: kThemecolor,),
          onFieldSubmitted: (String value){
          debugPrint('onFieldSubmitted value $value');
          }, secondaryButtonWidget: Icon(Icons.search, color: kThemecolor,),
      ),
      SizedBox(height: 4,),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: ((context, index) {
                    return Card(
                      child: Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                              color: kThemecolor,
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          child: ListTile(
                            onTap: () {
                               Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScreenJobProfile ()));
                            },
                            // leading: Image.asset(
                            //   'images/png-apple-logo-9707.png',
                            //   width: 48,
                            //   height: 48,
                            // ),
                            title: Text('Sr.developer'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Apple'),
                                Text(
                                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.black, fontSize: 9),
                                )
                              ],
                            ),
                          ),
                          ),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
