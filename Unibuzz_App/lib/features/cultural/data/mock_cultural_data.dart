class CulturalEventModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category; // Dance, Music, Drama, Art, Literature, Fashion, Photography
  final String date;
  final String time;
  final String venue;
  final String participantType; // Solo, Duo, Group
  final double fee;
  final bool isTrending;
  final int interestedCount;
  final String organizer;
  final List<String> rules;
  final List<String> rounds;
  final List<String> judges;

  const CulturalEventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.date,
    required this.time,
    required this.venue,
    this.participantType = 'Solo',
    this.fee = 0,
    this.isTrending = false,
    this.interestedCount = 0,
    this.organizer = 'Arts Club',
    this.rules = const [],
    this.rounds = const [],
    this.judges = const [],
  });
}

class MockCulturalData {
  static const List<CulturalEventModel> events = [
    CulturalEventModel(
      id: '1',
      title: 'Nrityam — The Dance Battle',
      description: 'Bring the fire! Solo and group dance competition with Bollywood, Western, Classical and freestyle categories.',
      imageUrl: 'https://images.unsplash.com/photo-1508700929628-666bc8bd84ea?w=600&q=80',
      category: 'Dance',
      date: 'Mar 10, 2026',
      time: '5:00 PM',
      venue: 'Open Air Theatre',
      participantType: 'Group',
      fee: 100,
      isTrending: true,
      interestedCount: 342,
      organizer: 'Dance Club',
      rules: ['3-8 members per group', 'Time limit: 6 minutes', 'Props allowed', 'No vulgarity'],
      rounds: ['Prelims', 'Semifinals', 'Grand Finale'],
      judges: ['Choreographer Salman Yusuff Khan', 'Prof. Meera Shah'],
    ),
    CulturalEventModel(
      id: '2',
      title: 'Unplugged Night',
      description: 'Acoustic performances under the stars. Sing, strum, and vibe with the campus community.',
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=600&q=80',
      category: 'Music',
      date: 'Mar 12, 2026',
      time: '7:00 PM',
      venue: 'Amphitheatre',
      participantType: 'Solo',
      fee: 0,
      isTrending: true,
      interestedCount: 518,
      organizer: 'Music Society',
      rules: ['Acoustic instruments only', '5-minute performance', 'Own instrument required'],
      rounds: ['Open Mic', 'Final Showdown'],
    ),
    CulturalEventModel(
      id: '3',
      title: 'Rang Manch — Drama Fest',
      description: 'One-act play competition. Express, emote, and take the audience on a journey.',
      imageUrl: 'https://images.unsplash.com/photo-1503095396549-807759245b35?w=600&q=80',
      category: 'Drama',
      date: 'Mar 14, 2026',
      time: '3:00 PM',
      venue: 'Main Auditorium',
      participantType: 'Group',
      fee: 150,
      isTrending: false,
      interestedCount: 189,
      organizer: 'Theatre Guild',
      rules: ['5-10 members', '20-minute act', 'No pre-recorded audio', 'Original scripts preferred'],
      rounds: ['Prelims', 'Finals'],
    ),
    CulturalEventModel(
      id: '4',
      title: 'Canvas Wars',
      description: 'Speed painting showdown — create a masterpiece in 90 minutes. Theme revealed on spot.',
      imageUrl: 'https://images.unsplash.com/photo-1460661419201-fd4cecdf8a8b?w=600&q=80',
      category: 'Art',
      date: 'Mar 8, 2026',
      time: '10:00 AM',
      venue: 'Art Studio, Block C',
      participantType: 'Solo',
      fee: 50,
      isTrending: false,
      interestedCount: 97,
      organizer: 'Fine Arts Club',
      rules: ['Materials provided', '90-minute time limit', 'Theme-based', 'No digital tools'],
    ),
    CulturalEventModel(
      id: '5',
      title: 'Slam Poetry Night',
      description: 'Words have power. Take the stage and perform original poetry that moves the crowd.',
      imageUrl: 'https://images.unsplash.com/photo-1457369804613-52c61a468e7d?w=600&q=80',
      category: 'Literature',
      date: 'Mar 16, 2026',
      time: '6:30 PM',
      venue: 'Seminar Hall A',
      participantType: 'Solo',
      fee: 0,
      isTrending: true,
      interestedCount: 264,
      organizer: 'Literary Society',
      rules: ['Original work only', '3-minute limit', 'No props', 'English, Hindi, or Marathi'],
    ),
    CulturalEventModel(
      id: '6',
      title: 'Couture Walk',
      description: 'Design, style, and walk the ramp. Campus fashion show with themes from retro to futuristic.',
      imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85f82e?w=600&q=80',
      category: 'Fashion',
      date: 'Mar 18, 2026',
      time: '7:00 PM',
      venue: 'Convention Hall',
      participantType: 'Group',
      fee: 200,
      isTrending: true,
      interestedCount: 430,
      organizer: 'Fashion Club',
      rules: ['Teams of 6-12', 'Theme-based rounds', 'Costumes must be self-designed', 'Background music allowed'],
      rounds: ['Theme Round', 'Freestyle', 'Showstopper'],
    ),
  ];
}
