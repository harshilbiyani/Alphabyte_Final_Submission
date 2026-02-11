
class EventModel {
  final String id;
  final String title;
  final String description;
  final String date;
  final String timeLeft; // For urgency
  final String imageUrl;
  final String category;
  final bool isEndingSoon;
  final bool isInterested;
  final String department;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.timeLeft,
    required this.imageUrl,
    required this.category,
    this.isEndingSoon = false,
    this.isInterested = false,
    this.department = 'General',
  });
}

class MockHomeData {
  static const List<EventModel> urgentEvents = [
    EventModel(
      id: '1',
      title: 'Neon Night',
      description: 'The biggest DJ night of the semester.',
      date: 'Tonight, 8 PM',
      timeLeft: '4h left',
      imageUrl: 'https://images.unsplash.com/photo-1545128485-c400e7702796?w=600&q=80',
      category: 'Music',
      isEndingSoon: true,
      isInterested: true,
      department: 'Student Council',
    ),
    EventModel(
      id: '2',
      title: 'Hackathon 24',
      description: 'Code all night, win big prizes.',
      date: 'Tomorrow, 9 AM',
      timeLeft: '1d left',
      imageUrl: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=600&q=80',
      category: 'Tech',
      isEndingSoon: true,
      isInterested: true,
      department: 'CS Dept',
    ),
    EventModel(
      id: '3',
      title: 'RoboWars',
      description: 'Battle of the bots in the main arena.',
      date: 'Feb 10, 10 AM',
      timeLeft: '2d left',
      imageUrl: 'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=600&q=80',
      category: 'Tech',
      isEndingSoon: true,
      isInterested: false,
      department: 'Robotics Club',
    ),
  ];

  static const List<EventModel> feedEvents = [
    EventModel(
      id: '4',
      title: 'Cultural Fest Opening',
      description: 'Join us for the grand opening ceremony with special guests and performances.',
      date: 'Feb 15, 6 PM',
      timeLeft: '5d left',
      imageUrl: 'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=800&q=80',
      category: 'Cultural',
      isInterested: true,
      department: 'Arts Club',
    ),
    EventModel(
      id: '5',
      title: 'AI Workshop',
      description: 'Learn users of GenAI in this hands-on workshop by industry experts.',
      date: 'Feb 12, 2 PM',
      timeLeft: '3d left',
      imageUrl: 'https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?w=800&q=80',
      category: 'Workshop',
      isInterested: true,
      department: 'AI Society',
    ),
    EventModel(
      id: '6',
      title: 'Standup Comedy',
      description: 'Laugh your hearts out with the best college comedians.',
      date: 'Feb 14, 7 PM',
      timeLeft: 'Seats filling',
      imageUrl: 'https://images.unsplash.com/photo-1585699324551-f6c309eedeca?w=800&q=80',
      category: 'Entertainment',
      isInterested: false,
      department: 'Drama Club',
    ),
    EventModel(
      id: '7',
      title: 'Basketball Finals',
      description: 'Inter-college championship match.',
      date: 'Feb 16, 4 PM',
      timeLeft: '1w left',
      imageUrl: 'https://images.unsplash.com/photo-1519861531473-920026393112?w=800&q=80',
      category: 'Sports',
      isInterested: false,
      department: 'Sports Dept',
    ),
    EventModel(
      id: '8',
      title: 'Chess Tournament',
      description: 'Checkmate your way to victory.',
      date: 'Feb 18, 10 AM',
      timeLeft: '1w left',
      imageUrl: 'https://images.unsplash.com/photo-1529699211952-734e80c4d42b?w=800&q=80',
      category: 'Gaming',
      isInterested: true,
      department: 'Chess Club',
    ),
    EventModel(
      id: '9',
      title: 'Guest Lecture: Physics',
      description: 'Quantum mechanics deep dive.',
      date: 'Feb 20, 11 AM',
      timeLeft: '2w left',
      imageUrl: 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=800&q=80',
      category: 'Guest Lectures',
      isInterested: false,
      department: 'Science Dept',
    ),
  ];
}
