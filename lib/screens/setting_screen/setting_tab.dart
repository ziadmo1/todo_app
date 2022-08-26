import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../providers/theme_provider.dart';
import 'lang_bottom_sheet.dart';


class SettingTab extends StatefulWidget {

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
   bool isDark=false;

  @override
  Widget build(BuildContext context) {
    getSwitchValue();
    AppConfigTheme provider = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
        title: Container(
        margin: EdgeInsets.only(left: 10),
    child: Text( AppLocalizations.of(context)!.setting)),
    ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Lottie.asset('assets/lottieLogo.json',width: 200,height: 200)),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Divider(thickness: 2,color: Theme.of(context).primaryColor,)),
            SizedBox(height: 40,),
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 28
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showLangBottomSheet();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height:70,
                decoration: BoxDecoration(
                    color:  Theme.of(context).bottomAppBarColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: provider.themeMode == ThemeMode.light? Colors.grey:Colors.black,
                          spreadRadius: 1,
                          offset: Offset(1,1)
                      )
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.locale == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: Theme.of(context).textTheme.bodyLarge
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 25,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height:70,
              decoration: BoxDecoration(
                color:  Theme.of(context).bottomAppBarColor,
                borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: provider.themeMode == ThemeMode.light? Colors.grey:Colors.black,
                        spreadRadius: 1,
                        offset: Offset(1,1)
                    )
                  ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( AppLocalizations.of(context)!.dark,
                    style: Theme.of(context).textTheme.bodyLarge,),
                  Switch(
                      value: isDark,
                      onChanged: (dark){
                        if(dark == true){
                          provider.changeTheme(ThemeMode.dark);
                        }
                        else if(dark == false){
                          provider.changeTheme(ThemeMode.light);
                        }
                        isDark =dark;
                        setSwitchPref(dark);
                        setState(() {
                        });
                      },
                    activeColor: Theme.of(context).primaryColor,
                    activeTrackColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
   Future<bool> setSwitchPref(bool dark)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', dark);
    return prefs.setBool('isDark', dark);
  }

 Future<bool> getSwitchPref()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   isDark =  prefs.getBool('isDark')??false;
    return isDark;
  }
  getSwitchValue()async{
  isDark =await getSwitchPref();
  setState(() {

  });
  }
   void showLangBottomSheet() {
     showModalBottomSheet(
         context: context, builder: (buildContext) => LangBottomSheet());
   }

}