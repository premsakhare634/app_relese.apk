import 'package:flutter/material.dart';
import 'today_screen.dart';
import 'calendar_screen.dart';
import 'tasks_screen.dart';
import 'notes_screen.dart';
import 'more_screen.dart';

class HomeShell extends StatefulWidget{const HomeShell({super.key});@override State<HomeShell>createState()=>_HomeShellState();}
class _HomeShellState extends State<HomeShell>{
  int index=0;
  final pages=const[TodayScreen(),CalendarScreen(),TasksScreen(),NotesScreen(),MoreScreen()];
  @override Widget build(BuildContext context)=>Scaffold(
    body:IndexedStack(index:index,children:pages),
    bottomNavigationBar:NavigationBar(selectedIndex:index,onDestinationSelected:(i)=>setState(()=>index=i),destinations:const[
      NavigationDestination(icon:Icon(Icons.today_outlined),selectedIcon:Icon(Icons.today),label:'Today'),
      NavigationDestination(icon:Icon(Icons.calendar_month_outlined),selectedIcon:Icon(Icons.calendar_month),label:'Calendar'),
      NavigationDestination(icon:Icon(Icons.check_circle_outline),selectedIcon:Icon(Icons.check_circle),label:'Tasks'),
      NavigationDestination(icon:Icon(Icons.menu_book_outlined),selectedIcon:Icon(Icons.menu_book),label:'Notes'),
      NavigationDestination(icon:Icon(Icons.more_horiz),label:'More'),
    ]),
  );
}
