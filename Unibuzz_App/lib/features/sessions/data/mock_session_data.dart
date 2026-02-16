class SessionModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category; // Workshop, Webinar, Guest Lecture, Panel Discussion, Bootcamp
  final String speaker;
  final String speakerTitle;
  final String speakerImageUrl;
  final String date;
  final String time;
  final String duration;
  final String venue;
  final String mode; // Online, Offline, Hybrid
  final double fee;
  final int seatsLeft;
  final int totalSeats;
  final List<String> tags;
  final bool isFeatured;

  const SessionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.speaker,
    required this.speakerTitle,
    this.speakerImageUrl = '',
    required this.date,
    required this.time,
    this.duration = '2 hours',
    required this.venue,
    this.mode = 'Offline',
    this.fee = 0,
    this.seatsLeft = 0,
    this.totalSeats = 100,
    this.tags = const [],
    this.isFeatured = false,
  });
}

class MockSessionData {
  static const List<SessionModel> sessions = [
    SessionModel(
      id: '1',
      title: 'Flutter & AI — Building Smart Apps',
      description: 'Hands-on workshop on integrating Google ML Kit and TensorFlow Lite into Flutter apps.',
      imageUrl: 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=600&q=80',
      category: 'Workshop',
      speaker: 'Rajan Verma',
      speakerTitle: 'Senior Dev @ Google',
      date: 'Mar 7, 2026',
      time: '10:00 AM',
      duration: '3 hours',
      venue: 'CS Lab 1',
      mode: 'Offline',
      fee: 0,
      seatsLeft: 12,
      totalSeats: 60,
      tags: ['Flutter', 'AI/ML', 'Mobile Dev'],
      isFeatured: true,
    ),
    SessionModel(
      id: '2',
      title: 'Career in Product Management',
      description: 'Learn what it takes to break into PM. A candid fireside chat with industry leaders.',
      imageUrl: 'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?w=600&q=80',
      category: 'Guest Lecture',
      speaker: 'Sneha Kapoor',
      speakerTitle: 'PM @ Microsoft',
      date: 'Mar 9, 2026',
      time: '2:00 PM',
      duration: '1.5 hours',
      venue: 'Seminar Hall A',
      mode: 'Hybrid',
      fee: 0,
      seatsLeft: 35,
      totalSeats: 120,
      tags: ['Product', 'Career', 'Tech'],
      isFeatured: true,
    ),
    SessionModel(
      id: '3',
      title: 'UI/UX Design Bootcamp',
      description: '2-day intensive bootcamp covering Figma, design systems, user research and prototyping.',
      imageUrl: 'https://images.unsplash.com/photo-1559028012-481c04fa702d?w=600&q=80',
      category: 'Bootcamp',
      speaker: 'Aditya Sharma',
      speakerTitle: 'Design Lead @ Swiggy',
      date: 'Mar 12–13, 2026',
      time: '9:00 AM',
      duration: '2 days',
      venue: 'Innovation Lab',
      mode: 'Offline',
      fee: 200,
      seatsLeft: 5,
      totalSeats: 40,
      tags: ['Design', 'Figma', 'UX Research'],
      isFeatured: false,
    ),
    SessionModel(
      id: '4',
      title: 'Web3 & Blockchain 101',
      description: 'Understand smart contracts, DeFi, and build your first dApp on Ethereum testnet.',
      imageUrl: 'https://images.unsplash.com/photo-1639762681485-074b7f938ba0?w=600&q=80',
      category: 'Webinar',
      speaker: 'Priya Nair',
      speakerTitle: 'Blockchain Dev @ Polygon',
      date: 'Mar 15, 2026',
      time: '6:00 PM',
      duration: '2 hours',
      venue: 'Online — Zoom',
      mode: 'Online',
      fee: 0,
      seatsLeft: 80,
      totalSeats: 200,
      tags: ['Web3', 'Blockchain', 'Ethereum'],
      isFeatured: false,
    ),
    SessionModel(
      id: '5',
      title: 'Women in Tech — Panel Discussion',
      description: 'Inspiring women leaders share their journey in the tech industry. Q&A with the audience.',
      imageUrl: 'https://images.unsplash.com/photo-1573164713988-8665fc963095?w=600&q=80',
      category: 'Panel Discussion',
      speaker: 'Multiple Speakers',
      speakerTitle: 'Industry Leaders',
      date: 'Mar 18, 2026',
      time: '4:00 PM',
      duration: '2 hours',
      venue: 'Main Auditorium',
      mode: 'Offline',
      fee: 0,
      seatsLeft: 60,
      totalSeats: 200,
      tags: ['Women in Tech', 'Diversity', 'Leadership'],
      isFeatured: true,
    ),
  ];
}
