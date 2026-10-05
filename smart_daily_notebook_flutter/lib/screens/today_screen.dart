import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/entry.dart';
import '../services/database.dart';
import '../services/notification_service.dart';
import '../services/parser.dart';
import '../theme.dart';
import '../widgets/entry_tile.dart';

class TodayScreen extends StatefulWidget{const TodayScreen({super.key});@override State<TodayScreen>createState()=>_TodayScreenState();}
class _TodayScreenState extends State<TodayScreen>{
  final db=DatabaseService.instance; final input=TextEditingController(); List<Entry> entries=[];
  @override void initState(){super.initState();load();}
  Future<void>load()async{final e=await db.forDate(DateTime.now());if(mounted)setState(()=>entries=e);}
  Future<void>addNatural()async{
    final text=input.text.trim();if(text.isEmpty)return;
    final p=NaturalLanguageParser.parse(text,DateTime.now());final now=DateTime.now();
    final e=Entry(type:EntryType.task,title:p.title,date:p.date,time:p.time,createdAt:now,updatedAt:now);
    final id=await db.insert(e);
    if(p.time!=null)await NotificationService.schedule(id:id,title:e.title,body:'Notebook reminder',when:p.time!);
    input.clear();await load();
  }
  Future<void>addNote()async{
    final c=TextEditingController();
    final ok=await showDialog<bool>(context:context,builder:(_)=>AlertDialog(title:const Text('New Note'),content:TextField(controller:c,maxLines:7,autofocus:true,decoration:const InputDecoration(hintText:'Write anything...')),actions:[
      TextButton(onPressed:()=>Navigator.pop(context,false),child:const Text('Cancel')),
      FilledButton(onPressed:()=>Navigator.pop(context,true),child:const Text('Save')),
    ]));
    if(ok==true&&c.text.trim().isNotEmpty){final n=DateTime.now();await db.insert(Entry(type:EntryType.note,title:'Note',content:c.text.trim(),date:DateTime(n.year,n.month,n.day),createdAt:n,updatedAt:n));await load();}
  }
  Future<void>toggle(Entry e)async{await db.update(e.copyWith(completed:!e.completed,updatedAt:DateTime.now()));await load();}
  Future<void>delete(Entry e)async{if(e.id!=null){await NotificationService.cancel(e.id!);await db.delete(e.id!);await load();}}
  @override Widget build(BuildContext context){
    final tasks=entries.where((e)=>e.type!=EntryType.note).toList();
    final notes=entries.where((e)=>e.type==EntryType.note).toList();
    final pending=tasks.where((e)=>!e.completed&&e.priority>0).toList();
    return SafeArea(child:RefreshIndicator(onRefresh:load,child:ListView(padding:const EdgeInsets.fromLTRB(20,18,20,28),children:[
      const Text('Today',style:TextStyle(fontSize:16,color:AppTheme.secondary)),
      Text(DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),style:const TextStyle(fontSize:25,fontWeight:FontWeight.w700,color:AppTheme.green)),
      const SizedBox(height:18),
      Row(children:[Expanded(child:TextField(controller:input,textInputAction:TextInputAction.done,onSubmitted:(_)=>addNatural(),decoration:const InputDecoration(prefixIcon:Icon(Icons.add),hintText:'उदा. उद्या दुपारी 3 वाजता फोन करायचा'))),const SizedBox(width:8),IconButton.filled(onPressed:addNatural,icon:const Icon(Icons.arrow_upward))]),
      const SizedBox(height:18),
      if(pending.isNotEmpty)...[_heading('Pending / Priority'),...pending.map((e)=>EntryTile(entry:e,onDone:()=>toggle(e),onDelete:()=>delete(e),onEdit:(){})),const SizedBox(height:16)],
      _heading("Today's Tasks"),
      if(tasks.isEmpty)_empty('आजची कामं इथे दिसतील.') else ...tasks.map((e)=>EntryTile(entry:e,onDone:()=>toggle(e),onDelete:()=>delete(e),onEdit:(){})),
      const SizedBox(height:18),
      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[_heading("Today's Notes"),TextButton.icon(onPressed:addNote,icon:const Icon(Icons.add),label:const Text('Note'))]),
      if(notes.isEmpty)_empty('आजची नोंद लिहा.'),
      ...notes.map((e)=>Card(child:Padding(padding:const EdgeInsets.all(16),child:Text(e.content,maxLines:6,overflow:TextOverflow.ellipsis)))),
    ])));
  }
  Widget _heading(String s)=>Padding(padding:const EdgeInsets.only(bottom:8),child:Text(s,style:const TextStyle(fontSize:17,fontWeight:FontWeight.w700,color:AppTheme.green)));
  Widget _empty(String s)=>Padding(padding:const EdgeInsets.symmetric(vertical:12),child:Text(s,style:const TextStyle(color:AppTheme.muted)));
}
