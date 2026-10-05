import 'package:flutter/material.dart';
import '../theme.dart';

class MoreScreen extends StatelessWidget{const MoreScreen({super.key});
  @override Widget build(BuildContext context)=>SafeArea(child:ListView(padding:const EdgeInsets.all(20),children:[
    const Text('More',style:TextStyle(fontSize:26,fontWeight:FontWeight.w700,color:AppTheme.green)),
    const SizedBox(height:14),
    Card(child:Column(children:const[
      ListTile(leading:Icon(Icons.settings_outlined),title:Text('Settings')),
      Divider(height:1),ListTile(leading:Icon(Icons.notifications_outlined),title:Text('Notification settings')),
      Divider(height:1),ListTile(leading:Icon(Icons.palette_outlined),title:Text('Appearance')),
      Divider(height:1),ListTile(leading:Icon(Icons.history),title:Text('Completed history')),
      Divider(height:1),ListTile(leading:Icon(Icons.info_outline),title:Text('About')),
    ])),
    const SizedBox(height:24),
    const Text('Smart Daily Notebook\nOffline personal notebook',textAlign:TextAlign.center,style:TextStyle(color:AppTheme.muted)),
  ]));
}
