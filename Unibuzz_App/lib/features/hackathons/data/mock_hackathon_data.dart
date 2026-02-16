class HackathonModel {
  final String id;
  final String title;
  final String organizer;
  final String description;
  final String imageUrl;
  final String mode; // Online, Offline, Hybrid
  final String difficulty; // Beginner, Intermediate, Advanced
  final DateTime startDate;
  final DateTime endDate;
  final DateTime registrationDeadline;
  final String prizePool;
  final int minTeamSize;
  final int maxTeamSize;
  final int registeredTeams;
  final int maxTeams;
  final double fee;
  final bool isLive;
  final List<String> tracks;
  final List<String> rules;
  final List<String> sponsors;
  final String venue;

  const HackathonModel({
    required this.id,
    required this.title,
    required this.organizer,
    required this.description,
    required this.imageUrl,
    required this.mode,
    required this.difficulty,
    required this.startDate,
    required this.endDate,
    required this.registrationDeadline,
    required this.prizePool,
    this.minTeamSize = 2,
    this.maxTeamSize = 4,
    this.registeredTeams = 0,
    this.maxTeams = 100,
    this.fee = 0,
    this.isLive = false,
    this.tracks = const [],
    this.rules = const [],
    this.sponsors = const [],
    this.venue = 'Online',
  });
}

class MockHackathonData {
  static final List<HackathonModel> hackathons = [
    HackathonModel(
      id: '1',
      title: 'Smart India Hackathon 2026',
      organizer: 'Government of India',
      description: 'India\'s biggest hackathon — solve real-world government challenges across 50+ problem statements.',
      imageUrl: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=600&q=80',
      mode: 'Hybrid',
      difficulty: 'Advanced',
      startDate: DateTime(2026, 3, 15),
      endDate: DateTime(2026, 3, 17),
      registrationDeadline: DateTime(2026, 3, 1),
      prizePool: '₹5,00,000',
      minTeamSize: 6,
      maxTeamSize: 6,
      registeredTeams: 187,
      maxTeams: 250,
      fee: 0,
      isLive: false,
      tracks: ['Healthcare', 'Agriculture', 'Smart Cities', 'FinTech', 'Education', 'Cybersecurity'],
      rules: ['Teams of exactly 6 members', 'All members from same college', 'No pre-built projects', '36-hour coding window'],
      sponsors: ['MeitY', 'AICTE', 'Persistent Systems'],
      venue: 'Nodal Centers across India',
    ),
    HackathonModel(
      id: '2',
      title: 'HackOverflow 3.0',
      organizer: 'CS Department',
      description: '24-hour inter-college hackathon with tracks in AI, Web3, and HealthTech.',
      imageUrl: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=600&q=80',
      mode: 'Offline',
      difficulty: 'Intermediate',
      startDate: DateTime(2026, 2, 28),
      endDate: DateTime(2026, 3, 1),
      registrationDeadline: DateTime(2026, 2, 25),
      prizePool: '₹1,50,000',
      minTeamSize: 2,
      maxTeamSize: 4,
      registeredTeams: 78,
      maxTeams: 100,
      fee: 200,
      isLive: true,
      tracks: ['AI/ML', 'Web3', 'HealthTech', 'FinTech'],
      rules: ['Teams of 2-4', 'Code from scratch', 'Working demo required', 'GitHub repo mandatory'],
      sponsors: ['Google', 'GitHub', 'Devfolio'],
      venue: 'CS Block Lab 301',
    ),
    HackathonModel(
      id: '3',
      title: 'CodeStorm Online',
      organizer: 'Tech Club',
      description: 'Virtual hackathon open to all. Build, ship, and win from anywhere.',
      imageUrl: 'https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?w=600&q=80',
      mode: 'Online',
      difficulty: 'Beginner',
      startDate: DateTime(2026, 3, 8),
      endDate: DateTime(2026, 3, 9),
      registrationDeadline: DateTime(2026, 3, 5),
      prizePool: '₹50,000',
      minTeamSize: 1,
      maxTeamSize: 3,
      registeredTeams: 210,
      maxTeams: 500,
      fee: 0,
      isLive: false,
      tracks: ['Open Innovation', 'Social Impact', 'EdTech'],
      rules: ['Solo or team', 'Any tech stack', 'Submit via Devfolio', '48-hour window'],
      sponsors: ['MLH', 'Polygon'],
      venue: 'Online (Discord)',
    ),
    HackathonModel(
      id: '4',
      title: 'BuildForIndia',
      organizer: 'Startup Cell',
      description: 'Hack for India\'s next startup idea. Top teams get incubation support.',
      imageUrl: 'https://images.unsplash.com/photo-1531482615713-2afd69097998?w=600&q=80',
      mode: 'Offline',
      difficulty: 'Advanced',
      startDate: DateTime(2026, 4, 5),
      endDate: DateTime(2026, 4, 7),
      registrationDeadline: DateTime(2026, 3, 25),
      prizePool: '₹3,00,000',
      minTeamSize: 3,
      maxTeamSize: 5,
      registeredTeams: 42,
      maxTeams: 80,
      fee: 500,
      isLive: false,
      tracks: ['AgriTech', 'CleanTech', 'EduTech', 'Logistics'],
      rules: ['Business plan + prototype required', 'Presentation to jury panel', 'IP remains with team'],
      sponsors: ['NASSCOM', 'T-Hub', 'Razorpay'],
      venue: 'Innovation Center, Block A',
    ),
    HackathonModel(
      id: '5',
      title: 'CyberSprint',
      organizer: 'InfoSec Club',
      description: 'CTF-style hackathon — crack challenges in crypto, forensics, web exploitation.',
      imageUrl: 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=600&q=80',
      mode: 'Hybrid',
      difficulty: 'Intermediate',
      startDate: DateTime(2026, 3, 20),
      endDate: DateTime(2026, 3, 21),
      registrationDeadline: DateTime(2026, 3, 15),
      prizePool: '₹75,000',
      minTeamSize: 2,
      maxTeamSize: 3,
      registeredTeams: 55,
      maxTeams: 120,
      fee: 100,
      isLive: false,
      tracks: ['Cryptography', 'Forensics', 'Web Exploitation', 'Reverse Engineering'],
      rules: ['Jeopardy-style CTF', 'No flag sharing', 'Standard CTF rules apply'],
      sponsors: ['HackerRank', 'CrowdStrike'],
      venue: 'Cyber Lab + Online Portal',
    ),
  ];
}
