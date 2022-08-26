import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todos_app/screens/setting_screen/setting_tab.dart';
import 'package:todos_app/screens/task_screen/task_tab.dart';



import '../providers/theme_provider.dart';
import 'bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
static const String routeName = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int currentIndex = 0;
List<Widget> screens = [TaskTab(),SettingTab()];
  @override
  Widget build(BuildContext context) {
    AppConfigTheme provider = Provider.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showTaskBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
        onTap: (index){
            currentIndex = index;
            setState(() {

            });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: ''),
        ],
      ),
      ),
        body: screens[currentIndex],
    );
  }
  showTaskBottomSheet()=>showModalBottomSheet(
      context: context, builder: (context)=> TaskBottomSheet()

  );
}

