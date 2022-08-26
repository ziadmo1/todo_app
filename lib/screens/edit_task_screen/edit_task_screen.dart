import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../dialog.dart';
import '../../firebase/my_database.dart';
import '../../firebase/tasks_data.dart';
import '../../providers/theme_provider.dart';


class EditTaskScreen extends StatefulWidget {
    static const String routeName = 'editTask';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

var formKey = GlobalKey<FormState>();
class _EditTaskScreenState extends State<EditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    TaskDetails taskDetails = ModalRoute.of(context)?.settings.arguments as TaskDetails;
    AppConfigTheme provider = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
        title: Container(
        margin: EdgeInsets.only(left: 10),
    child: Text(AppLocalizations.of(context)!.app_title,)),
    ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 30),
        child: Container(
          decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: provider.themeMode == ThemeMode.light? Colors.grey:Colors.black,
                spreadRadius: 1,
                offset: Offset(1,1)
              )
            ]
        ),
        child:SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                          'Edit Task',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall?.copyWith(
                            fontSize: 22
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      onChanged: (text){
                        taskDetails.tasks.title = text;
                      },
                      initialValue: taskDetails.tasks.title,
                      style: Theme.of(context).textTheme.displaySmall,
                      validator: (text){
                        if(text!.isEmpty){
                          return 'Task Title must not be empty';
                        }
                        if(text.startsWith(' ')){
                          return 'Task Title must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Task Title',
                        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 22
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      onChanged: (text){
                        taskDetails.tasks.content = text;
                      },
                      initialValue: taskDetails.tasks.content,
                      validator: (text){
                        if(text!.isEmpty){
                          return 'Description must not be empty';
                        }
                        if(text.startsWith(' ')){
                          return 'Description must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 22
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      style: Theme.of(context).textTheme.displaySmall,
                      minLines: 2,
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 15,),
                    Text(
                        'Select Date',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontSize: 15,
                        )
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: InkWell(
                        onTap: (){
                         showDateTimePick(taskDetails.tasks);
                         setState(() {

                         });
                        },
                        child: Text(DateFormat.yMMMd(provider.locale).format(taskDetails.tasks.dateTime??DateTime.now()),
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontSize: 12
                            )),
                      ),
                    ),
                    SizedBox(height: 70,),
                    Center(child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          )
                        )
                      ),
                        onPressed: (){
                        setState(() {

                        });
                        updateTask(taskDetails.tasks);
                    },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                          child: Text('Save Changes',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: 18
                          ),
                          ),
                        )
                    )
                    )
                  ],
                ),
            ),
          ),
        )
        ),
      ),
    );
  }
    updateTask(Tasks tasks){
    if(formKey.currentState!.validate()){
      showLoading(context, 'Loading....',isCancelable: false);
      MyDataBase.updateTask(tasks).then((value){
        hideLoading(context);
        showMessage(context, dialogType: DialogType.SUCCES, desc: 'Task updated successfully',onPressed: (){
          Navigator.pop(context);
        });
      }).catchError((error){
        hideLoading(context);
        showMessage(context, dialogType: DialogType.ERROR, desc: 'Error: $error',onPressed: (){
        });
      }).timeout(Duration(seconds: 5),onTimeout: (){
        hideLoading(context);
        showMessage(context, dialogType: DialogType.WARNING, desc: 'Data Saved Local',onPressed: (){
          Navigator.pop(context);
        });
      });
    }
    }

    showDateTimePick(Tasks tasks)async{
      DateTime? dateTime = await showDatePicker(
          context: context,
          initialDate: tasks.dateTime!,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365))
      );
      if(dateTime != null){
        tasks.dateTime = dateTime;
      }
      setState(() {

      });
    }
}

class TaskDetails{
  Tasks tasks;
  TaskDetails(this.tasks);
}
