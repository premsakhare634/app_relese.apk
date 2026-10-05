class ParsedInput {
  final String title; final DateTime date; final DateTime? time;
  ParsedInput(this.title,this.date,this.time);
}

class NaturalLanguageParser {
  static ParsedInput parse(String input, DateTime now) {
    final s=input.toLowerCase();
    var date=DateTime(now.year,now.month,now.day);
    DateTime? time;

    if(s.contains('उद्या')||s.contains('tomorrow')) date=date.add(const Duration(days:1));
    if(s.contains('परवा')||s.contains('day after tomorrow')) date=date.add(const Duration(days:2));

    final dm=RegExp(r'\b(\d{1,2})[\/\-](\d{1,2})(?:[\/\-](\d{4}))?\b').firstMatch(s);
    if(dm!=null){
      final d=int.parse(dm.group(1)!); final m=int.parse(dm.group(2)!);
      final y=int.tryParse(dm.group(3)??'')??now.year;
      if(m>=1&&m<=12) date=DateTime(y,m,d);
    }

    final tm=RegExp(r'\b(\d{1,2})(?::(\d{2}))?\s*(am|pm)\b',caseSensitive:false).firstMatch(s);
    if(tm!=null){
      var h=int.parse(tm.group(1)!); final min=int.tryParse(tm.group(2)??'0')??0;
      if(tm.group(3)!.toLowerCase()=='pm'&&h<12) h+=12;
      if(tm.group(3)!.toLowerCase()=='am'&&h==12) h=0;
      time=DateTime(date.year,date.month,date.day,h,min);
    }

    final mt=RegExp(r'(सकाळी|दुपारी|संध्याकाळी|रात्री)\s*(\d{1,2})(?::(\d{2}))?').firstMatch(s);
    if(mt!=null){
      var h=int.parse(mt.group(2)!); final min=int.tryParse(mt.group(3)??'0')??0;
      final p=mt.group(1)!;
      if((p=='दुपारी'||p=='संध्याकाळी'||p=='रात्री')&&h<12) h+=12;
      if(p=='सकाळी'&&h==12) h=0;
      time=DateTime(date.year,date.month,date.day,h,min);
    }
    return ParsedInput(input.trim(),date,time);
  }
}
