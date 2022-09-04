import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:restart_app/restart_app.dart';
import 'package:todos_app/dialog.dart';

import '../../firebase/my_database.dart';
import '../../firebase/tasks_data.dart';
import '../../providers/theme_provider.dart';
import 'task_widget.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({Key? key}) : super(key: key);

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  DateTime selectedDate = DateTime.now();
  bool isDone = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AppConfigTheme provider = Provider.of(context);
    return Scaffold(
      key:scaffoldKey,
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              AppLocalizations.of(context)!.app_title,
            )),
      ),
      body: Column(
        children: [
          CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365 * 4)),
            onDateSelected: (date) {
              selectedDate = date;
              setState(() {});
            },
            leftMargin: 20,
            monthColor: provider.themeMode == ThemeMode.light
                ? Colors.black
                : Colors.white,
            dayColor: provider.themeMode == ThemeMode.light
                ? Colors.black
                : Colors.white,
            dayNameColor: Theme.of(context).primaryColor,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: Theme.of(context).bottomAppBarColor,
            dotsColor: Theme.of(context).primaryColor,
            locale: 'en',
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot<Tasks>>(
                  stream: MyDataBase.getTaskStream(selectedDate),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return showMessage(context,
                          dialogType: DialogType.ERROR,
                          desc: 'Error: ${snapshot.error.toString()}',
                          onPressed: () {
                        Restart.restartApp();
                      }, btnOkText: 'Try Again');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    var data = snapshot.data?.docs
                        .map((snapshot) => snapshot.data())
                        .toList();
                    return ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TaskWidget(data![index],scaffoldKey);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: data?.length ?? 0);
                  }))
        ],
      ),
    );
  }
}
