class FestModel {
  final String id;
  final String name;
  final String tagline;
  final String description;
  final String imageUrl;
  final String startDate;
  final String endDate;
  final String venue;
  final String organizer;
  final int expectedFootfall;
  final List<String> highlights;
  final List<FestDaySchedule> schedule;
  final String registrationUrl;
  final bool isLive;
  final List<String> sponsors;  

  const FestModel({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
    required this.venue,
    this.organizer = 'Student Council',
    this.expectedFootfall = 0,
    this.highlights = const [],
    this.schedule = const [],
    this.registrationUrl = '',
    this.isLive = false,
    this.sponsors = const [],
  });
}

class FestDaySchedule {
  final String day;
  final List<String> events;
  const FestDaySchedule({required this.day, required this.events});
}

class MockFestData {
  static const List<FestModel> fests = [
    FestModel(
      id: '1',
      name: 'Technotsav 2026',
      tagline: 'Where Innovation Meets Celebration',
      description: 'The flagship annual tech-cultural fest featuring hackathons, robotics, coding contests, band nights and more!',
      imageUrl: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=600&q=80',
      startDate: 'Mar 20, 2026',
      endDate: 'Mar 22, 2026',
      venue: 'Entire Campus',
      expectedFootfall: 5000,
      isLive: true,
      highlights: ['24hr Hackathon', 'Robo Wars', 'Band Night', 'Pro-Show DJ Night'],
      schedule: [
        FestDaySchedule(day: 'Day 1 — Mar 20', events: ['Inauguration', 'Hackathon Kickoff', 'Coding Contest', 'Gaming Arena Opens']),
        FestDaySchedule(day: 'Day 2 — Mar 21', events: ['Robo Wars', 'Dance Competition', 'Startup Pitch', 'Band Night']),
        FestDaySchedule(day: 'Day 3 — Mar 22', events: ['Hackathon Finale', 'Fashion Show', 'DJ Night', 'Prize Distribution']),
      ],
      sponsors: ['Google', 'Microsoft', 'GitHub', 'Unstop'],
    ),
    FestModel(
      id: '2',
      name: 'Rang Utsav',
      tagline: 'Celebrate Culture. Celebrate Color.',
      description: 'The annual cultural extravaganza — three days of dance, drama, music, art, and fashion under one roof.',
      imageUrl: 'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=600&q=80',
      startDate: 'Apr 5, 2026',
      endDate: 'Apr 7, 2026',
      venue: 'Amphitheatre & Auditorium',
      expectedFootfall: 3000,
      isLive: false,
      highlights: ['Star Night', 'Nukkad Natak', 'Fashion Show', 'Slam Poetry'],
      schedule: [
        FestDaySchedule(day: 'Day 1 — Apr 5', events: ['Opening Ceremony', 'Dance Battles', 'Art Exhibition', 'Open Mic']),
        FestDaySchedule(day: 'Day 2 — Apr 6', events: ['Drama Finals', 'Fashion Walk', 'Music Concert', 'Slam Poetry']),
        FestDaySchedule(day: 'Day 3 — Apr 7', events: ['Star Night', 'Awards Ceremony', 'Closing DJ Set']),
      ],
      sponsors: ['Red Bull', 'Spotify', 'Boat'],
    ),
    FestModel(
      id: '3',
      name: 'Sportopia',
      tagline: 'Unleash the Athlete Within',
      description: 'Inter-college sports fest with cricket, football, basketball, athletics, and esports arenas.',
      imageUrl: 'https://images.unsplash.com/photo-1461896836934-bd45ba8fcf9b?w=600&q=80',
      startDate: 'Feb 15, 2026',
      endDate: 'Feb 17, 2026',
      venue: 'Sports Complex',
      expectedFootfall: 2500,
      isLive: false,
      highlights: ['Cricket T20', 'Futsal', 'E-Sports LAN', 'Marathon'],
      schedule: [
        FestDaySchedule(day: 'Day 1 — Feb 15', events: ['Opening March', 'Cricket Semis', 'Futsal', 'Badminton']),
        FestDaySchedule(day: 'Day 2 — Feb 16', events: ['Basketball', 'Athletics', 'E-Sports Finals', 'Chess']),
        FestDaySchedule(day: 'Day 3 — Feb 17', events: ['Cricket Finals', 'Marathon', 'Closing Ceremony']),
      ],
      sponsors: ['Nike', 'Puma', 'Decathlon'],
    ),
  ];
}
