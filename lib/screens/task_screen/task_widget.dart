import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../dialog.dart';
import '../../firebase/my_database.dart';
import '../../firebase/tasks_data.dart';
import '../../providers/theme_provider.dart';
import '../../themes/my_themes.dart';
import '../edit_task_screen/edit_task_screen.dart';



class TaskWidget extends StatefulWidget {
  Tasks task;
  GlobalKey scaffoldKey;
  TaskWidget(this.task,this.scaffoldKey);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    AppConfigTheme provider = Provider.of(context);
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Slidable(
          closeOnScroll: true,
          startActionPane: ActionPane(
            extentRatio: 0.35,
            motion: StretchMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
                onPressed: (context) {
          deleteTask(widget.task,widget.scaffoldKey.currentContext!);
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: InkWell(
            onTap: (){
                Navigator.pushNamed(context, EditTaskScreen.routeName,
                arguments: TaskDetails(widget.task)
                );
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              height: 155,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: provider.themeMode == ThemeMode.light
                      ? Colors.white
                      : MyTheme.bottomColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
              BoxShadow(
              color: provider.themeMode == ThemeMode.light? Colors.grey:Colors.black,
                  spreadRadius: 1,
                  offset: Offset(1,1)
              )
                ]
              ),
              child: Row(
                children: [
                  Container(
                    height: double.infinity,
                    width: 4,
                    decoration: BoxDecoration(
                        color:widget.task.isDone!?Color(0xFF61E757) :Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.task.title}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:widget.task.isDone!?Color(0xFF61E757) :Theme.of(context).primaryColor
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('${widget.task.content}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          DateFormat.yMMMd(provider.locale).format(widget.task.dateTime!),
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                  //61E757
                  ElevatedButton(
                      onPressed: () {
                       MyDataBase.editTask(widget.task);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(
                          0
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            widget.task.isDone!? Colors.transparent:Theme.of(context).primaryColor
                        ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      child: widget.task.isDone! ? Text('Done..!',
                      style: Theme.of(context).textTheme.titleSmall,
                      )
                          :Image.asset('assets/images/icon_check.png'))
                ],
              ),
            ),
          ),
        ),
    );
  }

  deleteTask(Tasks tasks, BuildContext context,){
    MyDataBase.deleteTask(tasks).then((value) {
      showMessage(context, dialogType: DialogType.SUCCES, desc: 'Task deleted successfully',onPressed: (){
      });
    }).catchError((error){
      showMessage(context, dialogType: DialogType.ERROR, desc: 'Error: $error',onPressed: (){
      });
    }).timeout(Duration(seconds: 5),onTimeout: (){
      showMessage(context, dialogType: DialogType.WARNING, desc: 'Data Saved Local',onPressed: (){

      });
    });

  }
}
