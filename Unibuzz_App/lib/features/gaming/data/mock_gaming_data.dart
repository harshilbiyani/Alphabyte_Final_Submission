class GamingEventModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String game; // Valorant, BGMI, FIFA, COD, CSGO, FreeFire, Tekken
  final String platform; // PC, Mobile, Console
  final String date;
  final String time;
  final String mode; // Solo, Duo, Squad
  final double fee;
  final String prizePool;
  final bool isLive;
  final int registeredTeams;
  final int maxTeams;
  final String format; // Single Elimination, Double Elimination, Round Robin
  final String organizer;

  const GamingEventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.game,
    required this.platform,
    required this.date,
    required this.time,
    this.mode = 'Squad',
    this.fee = 0,
    this.prizePool = '',
    this.isLive = false,
    this.registeredTeams = 0,
    this.maxTeams = 32,
    this.format = 'Single Elimination',
    this.organizer = 'E-Sports Club',
  });
}

class MockGamingData {
  static const List<GamingEventModel> events = [
    GamingEventModel(
      id: '1',
      title: 'Valorant Campus Championship',
      description: 'Compete against the best campus teams in tactical 5v5 FPS action. Ascendant+ only bracket available.',
      imageUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=600&q=80',
      game: 'Valorant',
      platform: 'PC',
      date: 'Mar 6, 2026',
      time: '6:00 PM',
      mode: 'Squad',
      fee: 200,
      prizePool: '₹20,000',
      isLive: true,
      registeredTeams: 28,
      maxTeams: 32,
      format: 'Single Elimination',
    ),
    GamingEventModel(
      id: '2',
      title: 'BGMI Battle Royale',
      description: 'Drop in, loot up, and be the last squad standing. Classic Erangel map with custom rooms.',
      imageUrl: 'https://images.unsplash.com/photo-1612287230202-1ff1d85d1bdf?w=600&q=80',
      game: 'BGMI',
      platform: 'Mobile',
      date: 'Mar 9, 2026',
      time: '8:00 PM',
      mode: 'Squad',
      fee: 100,
      prizePool: '₹15,000',
      isLive: false,
      registeredTeams: 20,
      maxTeams: 25,
      format: 'Round Robin',
    ),
    GamingEventModel(
      id: '3',
      title: 'FIFA Pro League',
      description: '1v1 FIFA tournament. Show your dribbling skills and tactical formations.',
      imageUrl: 'https://images.unsplash.com/photo-1493711662062-fa541adb3fc8?w=600&q=80',
      game: 'FIFA',
      platform: 'Console',
      date: 'Mar 11, 2026',
      time: '4:00 PM',
      mode: 'Solo',
      fee: 50,
      prizePool: '₹5,000',
      isLive: false,
      registeredTeams: 14,
      maxTeams: 16,
      format: 'Double Elimination',
    ),
    GamingEventModel(
      id: '4',
      title: 'CS2 Showmatch',
      description: 'Counter-Strike 2 showdown — tactical shooter at its finest. Bo3 format from quarters.',
      imageUrl: 'https://images.unsplash.com/photo-1552820728-8b83bb6b2b28?w=600&q=80',
      game: 'CS2',
      platform: 'PC',
      date: 'Mar 14, 2026',
      time: '5:00 PM',
      mode: 'Squad',
      fee: 200,
      prizePool: '₹18,000',
      isLive: false,
      registeredTeams: 10,
      maxTeams: 16,
      format: 'Single Elimination',
    ),
    GamingEventModel(
      id: '5',
      title: 'Tekken Tag Wars',
      description: 'Tag team Tekken tournament! Pick your duo and fight for campus glory.',
      imageUrl: 'https://images.unsplash.com/photo-1511512578047-dfb367046420?w=600&q=80',
      game: 'Tekken',
      platform: 'Console',
      date: 'Mar 17, 2026',
      time: '3:00 PM',
      mode: 'Duo',
      fee: 100,
      prizePool: '₹8,000',
      isLive: false,
      registeredTeams: 12,
      maxTeams: 16,
      format: 'Double Elimination',
    ),
  ];
}
