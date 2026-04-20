enum EventType { stadium, workshop }

class EventModel {
  final String id;
  final EventType type;
  final String title;
  final DateTime startTime;
  final String location;
  final String section;
  final String row;
  final String seat;
  final double? latitude;
  final double? longitude;
  final String? userId;
  
  // AI Analyzed Fields
  final String? description;
  final List<SpeakerInfo>? speakers;
  final List<SessionInfo>? sessions;
  final BudgetEstimate? budget;
  final List<String>? checklist;
  final LiveScoreInfo? liveScore;
  final bool isFree;
  final double? entryFee;

  const EventModel({
    required this.id,
    required this.type,
    required this.title,
    required this.startTime,
    required this.location,
    required this.section,
    required this.row,
    required this.seat,
    this.latitude,
    this.longitude,
    this.userId,
    this.description,
    this.speakers,
    this.sessions,
    this.budget,
    this.checklist,
    this.liveScore,
    this.isFree = true,
    this.entryFee,
  });

  bool get isLive {
    final now = DateTime.now();
    final difference = startTime.difference(now);
    return difference.inMinutes <= 30 && now.isBefore(startTime.add(const Duration(hours: 3)));
  }

  bool get isCompleted {
    final now = DateTime.now();
    final eventDay = DateTime(startTime.year, startTime.month, startTime.day);
    final today = DateTime(now.year, now.month, now.day);
    
    // If the event was on a previous day, it's definitely completed
    if (eventDay.isBefore(today)) return true;
    
    // If it's today, consider it completed after 4 hours from start
    return now.isAfter(startTime.add(const Duration(hours: 4)));
  }

  String get timeStatus {
    final now = DateTime.now();
    final difference = startTime.difference(now);

    if (now.isAfter(startTime)) {
      return 'Ongoing';
    } else if (difference.inHours > 0) {
      return 'Starts in ${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'}';
    } else {
      final mins = difference.inMinutes;
      return 'Starts in $mins ${mins == 1 ? 'min' : 'mins'}';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'location': location,
      'section': section,
      'row': row,
      'seat': seat,
      'latitude': latitude,
      'longitude': longitude,
      'userId': userId,
      'description': description,
      'speakers': speakers?.map((x) => x.toJson()).toList(),
      'sessions': sessions?.map((x) => x.toJson()).toList(),
      'budget': budget?.toJson(),
      'checklist': checklist,
      'liveScore': liveScore?.toJson(),
      'isFree': isFree,
      'entryFee': entryFee,
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      type: EventType.values.byName(json['type']),
      title: json['title'],
      startTime: DateTime.parse(json['startTime']),
      location: json['location'],
      section: json['section'],
      row: json['row'],
      seat: json['seat'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      userId: json['userId'],
      description: json['description'],
      speakers: (json['speakers'] as List?)?.map((x) => SpeakerInfo.fromJson(x)).toList(),
      sessions: (json['sessions'] as List?)?.map((x) => SessionInfo.fromJson(x)).toList(),
      budget: json['budget'] != null ? BudgetEstimate.fromJson(json['budget']) : null,
      checklist: (json['checklist'] as List?)?.cast<String>(),
      liveScore: json['liveScore'] != null ? LiveScoreInfo.fromJson(json['liveScore']) : null,
      isFree: json['isFree'] ?? true,
      entryFee: json['entryFee']?.toDouble(),
    );
  }

  factory EventModel.mock({
    required String id,
    required EventType type,
    required String title,
    required DateTime startTime,
    required String location,
    String? section,
    String? row,
    String? seat,
    double? latitude,
    double? longitude,
  }) {
    return EventModel(
      id: id,
      type: type,
      title: title,
      startTime: startTime,
      location: location,
      section: section ?? (type == EventType.stadium ? '112' : '4B'),
      row: row ?? (type == EventType.stadium ? 'AA' : '3'),
      seat: seat ?? (type == EventType.stadium ? '14' : '12'),
      latitude: latitude,
      longitude: longitude,
      isFree: true,
      entryFee: null,
    );
  }

  EventModel copyWith({
    String? id,
    EventType? type,
    String? title,
    DateTime? startTime,
    String? location,
    String? section,
    String? row,
    String? seat,
    double? latitude,
    double? longitude,
    String? userId,
    String? description,
    List<SpeakerInfo>? speakers,
    List<SessionInfo>? sessions,
    BudgetEstimate? budget,
    List<String>? checklist,
    LiveScoreInfo? liveScore,
    bool? isFree,
    double? entryFee,
  }) {
    return EventModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      location: location ?? this.location,
      section: section ?? this.section,
      row: row ?? this.row,
      seat: seat ?? this.seat,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      speakers: speakers ?? this.speakers,
      sessions: sessions ?? this.sessions,
      budget: budget ?? this.budget,
      checklist: checklist ?? this.checklist,
      liveScore: liveScore ?? this.liveScore,
      isFree: isFree ?? this.isFree,
      entryFee: entryFee ?? this.entryFee,
    );
  }
}

class SpeakerInfo {
  final String name;
  final String topic;
  final String bio;
  final String imageUrl;

  SpeakerInfo({
    required this.name,
    required this.topic,
    required this.bio,
    this.imageUrl = 'https://robohash.org/placeholder?set=set4',
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'topic': topic,
    'bio': bio,
    'imageUrl': imageUrl,
  };
  
  factory SpeakerInfo.fromJson(Map<String, dynamic> json) => SpeakerInfo(
    name: json['name'],
    topic: json['topic'],
    bio: json['bio'],
    imageUrl: json['imageUrl'] ?? 'https://robohash.org/${json['name'] ?? 'default'}?set=set4',
  );
}

class SessionInfo {
  final String title;
  final String time;
  final String speaker;

  SessionInfo({required this.title, required this.time, required this.speaker});

  Map<String, dynamic> toJson() => {'title': title, 'time': time, 'speaker': speaker};
  factory SessionInfo.fromJson(Map<String, dynamic> json) => SessionInfo(
    title: json['title'],
    time: json['time'],
    speaker: json['speaker'],
  );
}

class BudgetEstimate {
  final String tickets;
  final String travel;
  final String total;

  BudgetEstimate({required this.tickets, required this.travel, required this.total});

  Map<String, dynamic> toJson() => {'tickets': tickets, 'travel': travel, 'total': total};
  factory BudgetEstimate.fromJson(Map<String, dynamic> json) => BudgetEstimate(
    tickets: json['tickets'],
    travel: json['travel'],
    total: json['total'],
  );
}

class LiveScoreInfo {
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;
  final String? matchClock;
  final String? sportDescriptor; // e.g., "1st Inning", "Q4", "HT"

  LiveScoreInfo({
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    this.matchClock,
    this.sportDescriptor,
  });

  Map<String, dynamic> toJson() => {
    'homeTeam': homeTeam,
    'awayTeam': awayTeam,
    'homeScore': homeScore,
    'awayScore': awayScore,
    'matchClock': matchClock,
    'sportDescriptor': sportDescriptor,
  };

  factory LiveScoreInfo.fromJson(Map<String, dynamic> json) => LiveScoreInfo(
    homeTeam: json['homeTeam'],
    awayTeam: json['awayTeam'],
    homeScore: json['homeScore'] ?? 0,
    awayScore: json['awayScore'] ?? 0,
    matchClock: json['matchClock'],
    sportDescriptor: json['sportDescriptor'],
  );
}

