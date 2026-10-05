import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/entry.dart';
import '../services/database.dart';
import '../widgets/entry_tile.dart';
import '../theme.dart';

class CalendarScreen extends StatefulWidget{const CalendarScreen({super.key});@override State<CalendarScreen>createState()=>_CalendarScreenState();}
class _CalendarScreenState extends State<CalendarScreen>{
  DateTime selected=DateTime.now();List<Entry> entries=[];
  @override void initState(){super.initState();load();}
  Future<void>load()async{final e=await DatabaseService.instance.forDate(selected);if(mounted)setState(()=>entries=e);}
  @override Widget build(BuildContext context)=>SafeArea(child:ListView(padding:const EdgeInsets.all(20),children:[
    const Text('Calendar',style:TextStyle(fontSize:26,fontWeight:FontWeight.w700,color:AppTheme.green)),
    const SizedBox(height:12),
    Card(child:CalendarDatePicker(initialDate:selected,firstDate:DateTime(2020),lastDate:DateTime(2100),onDateChanged:(d){setState(()=>selected=d);load();})),
    const SizedBox(height:18),
    Text(DateFormat('d MMMM yyyy').format(selected),style:const TextStyle(fontSize:19,fontWeight:FontWeight.w700)),
    const SizedBox(height:10),
    if(entries.isEmpty)const Text('या दिवशी अजून काही नोंद नाही.',style:TextStyle(color:AppTheme.muted))
    else ...entries.map((e)=>EntryTile(entry:e,onDone:()async{await DatabaseService.instance.update(e.copyWith(completed:!e.completed,updatedAt:DateTime.now()));load();},onDelete:()async{if(e.id!=null)await DatabaseService.instance.delete(e.id!);load();},onEdit:(){})),
  ]));
}
