import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../dialog.dart';
import '../firebase/my_database.dart';
import '../firebase/tasks_data.dart';
import '../providers/theme_provider.dart';



class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({Key? key}) : super(key: key);

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}
var formKey = GlobalKey<FormState>();
var taskController = TextEditingController();
var descController = TextEditingController();
class _TaskBottomSheetState extends State<TaskBottomSheet> {
  @override
  Widget build(BuildContext context) {
    AppConfigTheme provider = Provider.of(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)),
            color: Theme.of(context).bottomAppBarColor
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30,horizontal: 30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Add New Task',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall?.copyWith(
                      fontSize: 22
                    )),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.displaySmall,
                  controller: taskController,
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
                  height: 15,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.displaySmall,
                  controller: descController,
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
                  minLines: 2,
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Select Date',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 15
                  )
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: InkWell(
                    onTap: (){
                      showDateTimePick();
                    },
                   child: Text(DateFormat.yMMMd(provider.locale).format(selectedDate),
                       style: Theme.of(context).textTheme.displaySmall?.copyWith(
                       fontSize: 12
                   )),
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: FloatingActionButton(
                    onPressed: () {
                      addData();
                    },
                    child: Image.asset('assets/images/icon_check.png',color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  addData(){
    if(formKey.currentState!.validate()){
      var newTask = Tasks(
      title: taskController.text,
      dateTime: DateUtils.dateOnly(selectedDate),
      isDone: false,
      content: descController.text
      );
      showLoading(context,'Loading...',isCancelable: false,);
      MyDataBase.addTask(newTask).then((value) {
        hideLoading(context);
        showMessage(context,dialogType: DialogType.SUCCES,desc: 'Task Added Successfully',onPressed: (){
            Navigator.pop(context);
        });
      }
      ).catchError((onError){
        hideLoading(context);
        showMessage(context,dialogType: DialogType.ERROR,desc: 'Error: $onError',onPressed: (){
        });
      }).timeout(Duration(seconds: 5),onTimeout: (){
        hideLoading(context);
        showMessage(context, dialogType: DialogType.WARNING, desc: 'Data Saved Local',onPressed: (){
          Navigator.pop(context);
        });
      });}
  }

  DateTime selectedDate = DateTime.now();
  showDateTimePick()async{
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    if(dateTime != null){
      selectedDate = dateTime;
    }
    setState(() {

    });
  }
}
