enum EntryType { task, note, reminder }

class Entry {
  final int? id;
  final EntryType type;
  final String title;
  final String content;
  final DateTime date;
  final DateTime? time;
  final int priority;
  final bool reminderEnabled;
  final bool completed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String recurrence;

  const Entry({
    this.id, required this.type, required this.title, this.content = '',
    required this.date, this.time, this.priority = 0,
    this.reminderEnabled = false, this.completed = false,
    required this.createdAt, required this.updatedAt, this.recurrence = '',
  });

  Entry copyWith({
    int? id, EntryType? type, String? title, String? content, DateTime? date,
    DateTime? time, int? priority, bool? reminderEnabled, bool? completed,
    DateTime? createdAt, DateTime? updatedAt, String? recurrence,
  }) => Entry(
    id: id ?? this.id, type: type ?? this.type, title: title ?? this.title,
    content: content ?? this.content, date: date ?? this.date, time: time ?? this.time,
    priority: priority ?? this.priority, reminderEnabled: reminderEnabled ?? this.reminderEnabled,
    completed: completed ?? this.completed, createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt, recurrence: recurrence ?? this.recurrence,
  );

  Map<String,Object?> toMap() => {
    'id': id, 'type': type.name, 'title': title, 'content': content,
    'date': date.toIso8601String(), 'time': time?.toIso8601String(),
    'priority': priority, 'reminder_enabled': reminderEnabled ? 1 : 0,
    'completed': completed ? 1 : 0, 'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(), 'recurrence': recurrence,
  };

  factory Entry.fromMap(Map<String,Object?> m) => Entry(
    id: m['id'] as int?, type: EntryType.values.firstWhere((e)=>e.name==m['type'], orElse:()=>EntryType.task),
    title: m['title'] as String, content: m['content'] as String,
    date: DateTime.parse(m['date'] as String),
    time: m['time']==null ? null : DateTime.parse(m['time'] as String),
    priority: (m['priority'] as int?) ?? 0,
    reminderEnabled: m['reminder_enabled']==1, completed: m['completed']==1,
    createdAt: DateTime.parse(m['created_at'] as String),
    updatedAt: DateTime.parse(m['updated_at'] as String),
    recurrence: (m['recurrence'] as String?) ?? '',
  );
}
