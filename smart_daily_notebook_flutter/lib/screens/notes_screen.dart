import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/entry.dart';
import '../services/database.dart';
import '../theme.dart';

class NotesScreen extends StatefulWidget{const NotesScreen({super.key});@override State<NotesScreen>createState()=>_NotesScreenState();}
class _NotesScreenState extends State<NotesScreen>{
  List<Entry> notes=[];final search=TextEditingController();
  @override void initState(){super.initState();load();}
  Future<void>load()async{final x=await DatabaseService.instance.all();if(mounted)setState(()=>notes=x.where((e)=>e.type==EntryType.note).toList());}
  @override Widget build(BuildContext context){
    final q=search.text.toLowerCase();
    final x=q.isEmpty?notes:notes.where((e)=>e.title.toLowerCase().contains(q)||e.content.toLowerCase().contains(q)).toList();
    return SafeArea(child:ListView(padding:const EdgeInsets.all(20),children:[
      const Text('Notes',style:TextStyle(fontSize:26,fontWeight:FontWeight.w700,color:AppTheme.green)),
      const SizedBox(height:12),
      TextField(controller:search,onChanged:(_)=>setState((){}),decoration:const InputDecoration(prefixIcon:Icon(Icons.search),hintText:'Search notes')),
      const SizedBox(height:18),
      ...x.map((e)=>Card(margin:const EdgeInsets.only(bottom:10),child:ListTile(
        title:Text(e.title,style:const TextStyle(fontWeight:FontWeight.w700)),
        subtitle:Text('${DateFormat('d MMM yyyy').format(e.date)}\n${e.content}',maxLines:3,overflow:TextOverflow.ellipsis),
        isThreeLine:true,
        trailing:IconButton(icon:const Icon(Icons.delete_outline),onPressed:()async{if(e.id!=null)await DatabaseService.instance.delete(e.id!);load();}),
      ))),
    ]));
  }
}
