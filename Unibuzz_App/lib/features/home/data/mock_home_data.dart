
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
  // New fields for event details flow
  final String venue;
  final String time;
  final String organizer;
  final String about;
  final List<String> rules;
  final List<PrizeModel> prizes;
  final bool isTeamEvent;
  final int minTeamSize;
  final int maxTeamSize;
  final double fee;

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
    this.venue = 'Main Auditorium',
    this.time = '10:00 AM',
    this.organizer = 'Student Council',
    this.about = '',
    this.rules = const [],
    this.prizes = const [],
    this.isTeamEvent = false,
    this.minTeamSize = 2,
    this.maxTeamSize = 4,
    this.fee = 0,
  });
}

class PrizeModel {
  final String position;
  final String reward;
  final String icon;

  const PrizeModel({
    required this.position,
    required this.reward,
    this.icon = '🏆',
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
      venue: 'Open Air Theatre',
      time: '8:00 PM',
      organizer: 'Student Council',
      about: 'Get ready for the ultimate DJ night! Featuring top DJs, neon lights, and electrifying beats. Dance the night away under the stars at the biggest party of the semester.',
      rules: [
        'Valid college ID is mandatory for entry.',
        'No outside food or beverages allowed.',
        'Follow all safety guidelines provided by organizers.',
        'Event is non-refundable once registered.',
      ],
      prizes: [],
      isTeamEvent: false,
      fee: 149,
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
      venue: 'CS Block Lab 301',
      time: '9:00 AM',
      organizer: 'CS Department & Tech Club',
      about: 'A 24-hour hackathon where teams compete to build innovative solutions. Choose from tracks like AI/ML, Web3, HealthTech, and FinTech. Mentors from top companies will guide you throughout.',
      rules: [
        'Teams of 2-4 members are allowed.',
        'All team members must be from the same college.',
        'Pre-built projects are not allowed — code from scratch.',
        'Use of open-source libraries and APIs is permitted.',
        'Final submission must include a working demo and GitHub repo.',
        'Judges\' decision is final and binding.',
      ],
      prizes: [
        PrizeModel(position: '1st Place', reward: '₹50,000', icon: '🥇'),
        PrizeModel(position: '2nd Place', reward: '₹30,000', icon: '🥈'),
        PrizeModel(position: '3rd Place', reward: '₹15,000', icon: '🥉'),
        PrizeModel(position: 'Best UI/UX', reward: '₹5,000', icon: '🎨'),
      ],
      isTeamEvent: true,
      minTeamSize: 2,
      maxTeamSize: 4,
      fee: 200,
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
      venue: 'Main Arena',
      time: '10:00 AM',
      organizer: 'Robotics Club',
      about: 'Bring your bots to the arena and fight for glory! RoboWars is the ultimate robotics competition where teams pit their custom-built robots against each other in an elimination-style tournament.',
      rules: [
        'Teams of 2-5 members are allowed.',
        'Robot weight must not exceed 8 kg.',
        'No flammable or explosive materials.',
        'Wireless control is mandatory.',
        'Robots must be inspected before the match.',
      ],
      prizes: [
        PrizeModel(position: '1st Place', reward: '₹40,000', icon: '🥇'),
        PrizeModel(position: '2nd Place', reward: '₹20,000', icon: '🥈'),
        PrizeModel(position: '3rd Place', reward: '₹10,000', icon: '🥉'),
      ],
      isTeamEvent: true,
      minTeamSize: 2,
      maxTeamSize: 5,
      fee: 300,
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
      venue: 'Open Air Theatre',
      time: '6:00 PM',
      organizer: 'Arts Club & Cultural Committee',
      about: 'The grand opening of the annual Cultural Fest! Enjoy mesmerizing performances, celebrity guest appearances, and a spectacular fireworks show. Free entry for all registered students.',
      rules: [
        'Valid college ID required for entry.',
        'Seats are on a first-come, first-served basis.',
        'Photography is allowed; no flash photography during performances.',
        'Follow the seating arrangement provided by volunteers.',
      ],
      prizes: [],
      isTeamEvent: false,
      fee: 0,
    ),
    EventModel(
      id: '5',
      title: 'AI Workshop',
      description: 'Learn uses of GenAI in this hands-on workshop by industry experts.',
      date: 'Feb 12, 2 PM',
      timeLeft: '3d left',
      imageUrl: 'https://images.unsplash.com/photo-1555949963-ff9fe0c870eb?w=800&q=80',
      category: 'Workshop',
      isInterested: true,
      department: 'AI Society',
      venue: 'Seminar Hall B',
      time: '2:00 PM',
      organizer: 'AI Society',
      about: 'A hands-on workshop on Generative AI covering prompt engineering, LLM fine-tuning, and building AI-powered applications. Bring your laptop and get ready to code along with industry experts from Google and Microsoft.',
      rules: [
        'Bring your own laptop with Python 3.10+ installed.',
        'Basic knowledge of Python is required.',
        'Limited to 60 seats — register early.',
        'Certificate of participation will be provided.',
      ],
      prizes: [],
      isTeamEvent: false,
      fee: 99,
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
      venue: 'Main Auditorium',
      time: '7:00 PM',
      organizer: 'Drama Club',
      about: 'An evening of non-stop laughter! The best college comedians deliver their hottest sets. Special surprise guest from the stand-up comedy scene. Get your tickets before they sell out!',
      rules: [
        'No recording of performances allowed.',
        'Maintain decorum during the show.',
        'Tickets are non-transferable.',
        'Doors close 10 minutes after start time.',
      ],
      prizes: [],
      isTeamEvent: false,
      fee: 199,
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
      venue: 'Indoor Stadium',
      time: '4:00 PM',
      organizer: 'Sports Department',
      about: 'The inter-college basketball championship final! Cheer for your college team as they compete for the trophy. Free entry for spectators with valid college ID.',
      rules: [
        'Team registration must be done through Sports Dept.',
        'Players must carry valid ID and medical fitness certificate.',
        'Standard FIBA rules apply.',
        'Spectators must remain in designated areas.',
      ],
      prizes: [
        PrizeModel(position: '1st Place', reward: 'Trophy + ₹25,000', icon: '🥇'),
        PrizeModel(position: '2nd Place', reward: 'Trophy + ₹15,000', icon: '🥈'),
      ],
      isTeamEvent: true,
      minTeamSize: 5,
      maxTeamSize: 12,
      fee: 0,
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
      venue: 'Recreation Room',
      time: '10:00 AM',
      organizer: 'Chess Club',
      about: 'An open chess tournament for all skill levels. Swiss-system format with 7 rounds. Prizes for top 3 players and best newcomer. FIDE-rated if enough titled players participate.',
      rules: [
        'Solo participation only.',
        'Bring your own chess clock (optional — provided if needed).',
        'Standard FIDE time control: 15 min + 10 sec increment.',
        'Touch-move rule applies strictly.',
        'No electronic devices at the board.',
      ],
      prizes: [
        PrizeModel(position: '1st Place', reward: '₹10,000', icon: '🥇'),
        PrizeModel(position: '2nd Place', reward: '₹5,000', icon: '🥈'),
        PrizeModel(position: '3rd Place', reward: '₹3,000', icon: '🥉'),
      ],
      isTeamEvent: false,
      fee: 50,
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
      venue: 'Lecture Hall 1',
      time: '11:00 AM',
      organizer: 'Science Dept & Physics Society',
      about: 'A deep-dive into Quantum Mechanics by Prof. Robert Wilson from MIT. Topics include quantum entanglement, superposition, and real-world applications in quantum computing.',
      rules: [
        'Open to all students and faculty.',
        'Carry a notebook — no recordings allowed.',
        'Q&A session at the end — prepare your questions!',
        'Certificate of attendance for registered participants.',
      ],
      prizes: [],
      isTeamEvent: false,
      fee: 0,
    ),
  ];
}
