class SportsEventModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String sport; // Cricket, Football, Basketball, Badminton, Athletics, Chess, Volleyball
  final String date;
  final String time;
  final String venue;
  final String teamSize; // Solo, Duo, 5v5, 11v11 etc.
  final double fee;
  final String prizePool;
  final bool isLive;
  final int registeredTeams;
  final int maxTeams;
  final String organizer;

  const SportsEventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.sport,
    required this.date,
    required this.time,
    required this.venue,
    this.teamSize = 'Solo',
    this.fee = 0,
    this.prizePool = '',
    this.isLive = false,
    this.registeredTeams = 0,
    this.maxTeams = 32,
    this.organizer = 'Sports Council',
  });
}

class MockSportsData {
  static const List<SportsEventModel> events = [
    SportsEventModel(
      id: '1',
      title: 'Premier League — Cricket',
      description: 'Inter-department T20 cricket tournament. 12 overs, knockout format. Best campus teams clash!',
      imageUrl: 'https://images.unsplash.com/photo-1531415074968-036ba1b575da?w=600&q=80',
      sport: 'Cricket',
      date: 'Mar 5, 2026',
      time: '9:00 AM',
      venue: 'University Cricket Ground',
      teamSize: '11v11',
      fee: 500,
      prizePool: '₹25,000',
      isLive: true,
      registeredTeams: 14,
      maxTeams: 16,
      organizer: 'Cricket Club',
    ),
    SportsEventModel(
      id: '2',
      title: 'Futsal Frenzy',
      description: '5-a-side indoor football tournament. High intensity, fast-paced matches on the indoor court.',
      imageUrl: 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=600&q=80',
      sport: 'Football',
      date: 'Mar 8, 2026',
      time: '4:00 PM',
      venue: 'Indoor Sports Complex',
      teamSize: '5v5',
      fee: 300,
      prizePool: '₹15,000',
      isLive: false,
      registeredTeams: 10,
      maxTeams: 16,
      organizer: 'Football Club',
    ),
    SportsEventModel(
      id: '3',
      title: 'Slam Dunk Showdown',
      description: '3v3 streetball basketball tournament. Show your handles, crossovers and dunks!',
      imageUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=600&q=80',
      sport: 'Basketball',
      date: 'Mar 10, 2026',
      time: '5:00 PM',
      venue: 'Basketball Court A',
      teamSize: '3v3',
      fee: 200,
      prizePool: '₹10,000',
      isLive: false,
      registeredTeams: 8,
      maxTeams: 12,
      organizer: 'Basketball Club',
    ),
    SportsEventModel(
      id: '4',
      title: 'Shuttle Masters',
      description: 'Singles and doubles badminton championship. Smash your way to the top.',
      imageUrl: 'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?w=600&q=80',
      sport: 'Badminton',
      date: 'Mar 12, 2026',
      time: '10:00 AM',
      venue: 'Indoor Badminton Hall',
      teamSize: 'Solo',
      fee: 100,
      prizePool: '₹5,000',
      isLive: false,
      registeredTeams: 22,
      maxTeams: 32,
      organizer: 'Badminton Club',
    ),
    SportsEventModel(
      id: '5',
      title: 'Track & Field Meet',
      description: 'Annual athletics meet — 100m, 200m, relay, long jump, shot put and more.',
      imageUrl: 'https://images.unsplash.com/photo-1461896836934-bd45ba8fcf9b?w=600&q=80',
      sport: 'Athletics',
      date: 'Mar 15, 2026',
      time: '7:00 AM',
      venue: 'University Stadium',
      teamSize: 'Solo',
      fee: 0,
      prizePool: 'Medals + Certificates',
      isLive: false,
      registeredTeams: 48,
      maxTeams: 100,
      organizer: 'Athletics Department',
    ),
    SportsEventModel(
      id: '6',
      title: 'Checkmate Open',
      description: 'Rapid chess tournament — 10+5 time control. Strategic minds battle it out.',
      imageUrl: 'https://images.unsplash.com/photo-1529699211952-734e80c4d42b?w=600&q=80',
      sport: 'Chess',
      date: 'Mar 18, 2026',
      time: '2:00 PM',
      venue: 'Seminar Hall B',
      teamSize: 'Solo',
      fee: 50,
      prizePool: '₹3,000',
      isLive: false,
      registeredTeams: 30,
      maxTeams: 64,
      organizer: 'Chess Club',
    ),
  ];
}
