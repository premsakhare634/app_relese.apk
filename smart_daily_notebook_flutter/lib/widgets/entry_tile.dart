import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/entry.dart';
import '../theme.dart';

class EntryTile extends StatelessWidget {
  final Entry entry; final VoidCallback onDone,onDelete,onEdit;
  const EntryTile({super.key,required this.entry,required this.onDone,required this.onDelete,required this.onEdit});

  @override
  Widget build(BuildContext context){
    final time=entry.time==null?'':DateFormat('h:mm a').format(entry.time!);
    return Card(child:ListTile(
      contentPadding:const EdgeInsets.symmetric(horizontal:14,vertical:4),
      leading:entry.type==EntryType.note?const Icon(Icons.notes_outlined,color:AppTheme.green2):Checkbox(value:entry.completed,onChanged:(_)=>onDone()),
      title:Text(entry.title,style:TextStyle(fontWeight:FontWeight.w600,decoration:entry.completed?TextDecoration.lineThrough:null)),
      subtitle:Text([if(time.isNotEmpty)time,if(entry.priority>0)['Normal','Important','High'][entry.priority.clamp(0,2)],if(entry.reminderEnabled)'Reminder'].join('  •  ')),
      trailing:PopupMenuButton<String>(onSelected:(v){if(v=='edit')onEdit();if(v=='delete')onDelete();if(v=='done')onDone();},itemBuilder:(_)=>const[
        PopupMenuItem(value:'done',child:Text('Done / Undo')),
        PopupMenuItem(value:'edit',child:Text('Edit')),
        PopupMenuItem(value:'delete',child:Text('Delete')),
      ]),
    ));
  }
}
