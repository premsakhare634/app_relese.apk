import 'package:flutter/material.dart';
import '../models/entry.dart';
import '../services/database.dart';
import '../widgets/entry_tile.dart';
import '../theme.dart';

class TasksScreen extends StatefulWidget{const TasksScreen({super.key});@override State<TasksScreen>createState()=>_TasksScreenState();}
class _TasksScreenState extends State<TasksScreen>{
  List<Entry> all=[];final search=TextEditingController();
  @override void initState(){super.initState();load();}
  Future<void>load()async{final x=await DatabaseService.instance.all();if(mounted)setState(()=>all=x.where((e)=>e.type!=EntryType.note).toList());}
  @override Widget build(BuildContext context){
    final now=DateTime.now();
    final today=all.where((e)=>e.date.year==now.year&&e.date.month==now.month&&e.date.day==now.day).toList();
    final pending=all.where((e)=>!e.completed).toList();
    final done=all.where((e)=>e.completed).toList();
    return SafeArea(child:ListView(padding:const EdgeInsets.all(20),children:[
      const Text('Tasks',style:TextStyle(fontSize:26,fontWeight:FontWeight.w700,color:AppTheme.green)),
      const SizedBox(height:12),
      TextField(controller:search,onChanged:(_)=>setState((){}),decoration:const InputDecoration(prefixIcon:Icon(Icons.search),hintText:'Search tasks')),
      const SizedBox(height:18),
      _section('Today',today),_section('Pending',pending),_section('Completed',done),
    ]));
  }
  Widget _section(String title,List<Entry> list){
    final q=search.text.toLowerCase();
    final x=q.isEmpty?list:list.where((e)=>e.title.toLowerCase().contains(q)||e.content.toLowerCase().contains(q)).toList();
    return Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
      Padding(padding:const EdgeInsets.only(bottom:8,top:8),child:Text(title,style:const TextStyle(fontSize:17,fontWeight:FontWeight.w700))),
      ...x.map((e)=>EntryTile(entry:e,onDone:()async{await DatabaseService.instance.update(e.copyWith(completed:!e.completed,updatedAt:DateTime.now()));load();},onDelete:()async{if(e.id!=null)await DatabaseService.instance.delete(e.id!);load();},onEdit:(){})),
    ]);
  }
}
