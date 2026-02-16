class ClubModel {
  final String id;
  final String name;
  final String description;
  final String logoUrl;
  final String category; // Technical, Cultural, Sports, Social, Media
  final int memberCount;
  final String founded;
  final String presidentName;
  final List<String> tags;
  final bool isRecruiting;
  final String recruitingDeadline;
  final List<String> upcomingEvents;
  final double rating;

  const ClubModel({
    required this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
    required this.category,
    this.memberCount = 0,
    this.founded = '2020',
    this.presidentName = '',
    this.tags = const [],
    this.isRecruiting = false,
    this.recruitingDeadline = '',
    this.upcomingEvents = const [],
    this.rating = 4.0,
  });
}

class MockClubData {
  static const List<ClubModel> clubs = [
    ClubModel(
      id: '1',
      name: 'Google Developer Student Club',
      description: 'Google-backed community for student developers. Workshops, hackathons, and project collabs.',
      logoUrl: 'https://images.unsplash.com/photo-1573804633927-bfcbcd909acd?w=200&q=80',
      category: 'Technical',
      memberCount: 320,
      founded: '2019',
      presidentName: 'Aarav Mehta',
      tags: ['Google', 'Android', 'Web', 'Cloud'],
      isRecruiting: true,
      recruitingDeadline: 'Mar 15, 2026',
      upcomingEvents: ['Flutter Forward', 'Cloud Study Jam'],
      rating: 4.8,
    ),
    ClubModel(
      id: '2',
      name: 'Robotics & IoT Club',
      description: 'Build robots, drones, and IoT projects. Participate in national robotics competitions.',
      logoUrl: 'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=200&q=80',
      category: 'Technical',
      memberCount: 85,
      founded: '2018',
      presidentName: 'Kavya Singh',
      tags: ['Robotics', 'IoT', 'Arduino', 'Raspberry Pi'],
      isRecruiting: false,
      upcomingEvents: ['Robo Wars', 'Drone Racing'],
      rating: 4.5,
    ),
    ClubModel(
      id: '3',
      name: 'Nritya — Dance Club',
      description: 'From Bollywood to hip-hop — express yourself through dance. Weekly practice + campus performances.',
      logoUrl: 'https://images.unsplash.com/photo-1508700929628-666bc8bd84ea?w=200&q=80',
      category: 'Cultural',
      memberCount: 140,
      founded: '2017',
      presidentName: 'Ananya Joshi',
      tags: ['Dance', 'Bollywood', 'Hip-hop', 'Contemporary'],
      isRecruiting: true,
      recruitingDeadline: 'Mar 20, 2026',
      upcomingEvents: ['Nrityam 2026', 'Flash Mob'],
      rating: 4.7,
    ),
    ClubModel(
      id: '4',
      name: 'E-Sports Club',
      description: 'Competitive gaming community. Valorant, BGMI, CS2, FIFA teams representing the campus.',
      logoUrl: 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200&q=80',
      category: 'Sports',
      memberCount: 200,
      founded: '2021',
      presidentName: 'Rohan Gupta',
      tags: ['Gaming', 'Valorant', 'BGMI', 'E-Sports'],
      isRecruiting: true,
      recruitingDeadline: 'Mar 10, 2026',
      upcomingEvents: ['Campus Championship', 'LAN Party'],
      rating: 4.6,
    ),
    ClubModel(
      id: '5',
      name: 'NSS — Social Service',
      description: 'Community service, blood drives, rural outreach, and environmental initiatives.',
      logoUrl: 'https://images.unsplash.com/photo-1559027615-cd4628902d4a?w=200&q=80',
      category: 'Social',
      memberCount: 250,
      founded: '2015',
      presidentName: 'Meera Patil',
      tags: ['Social', 'Community', 'Volunteering', 'NGO'],
      isRecruiting: false,
      upcomingEvents: ['Blood Donation Camp', 'Tree Plantation Drive'],
      rating: 4.4,
    ),
    ClubModel(
      id: '6',
      name: 'Campus Chronicle — Media',
      description: 'The official media body. Photography, videography, journalism, and social media for all campus events.',
      logoUrl: 'https://images.unsplash.com/photo-1504711434969-e33886168d6c?w=200&q=80',
      category: 'Media',
      memberCount: 60,
      founded: '2016',
      presidentName: 'Ishaan Khan',
      tags: ['Media', 'Photography', 'Journalism', 'Video'],
      isRecruiting: true,
      recruitingDeadline: 'Mar 12, 2026',
      upcomingEvents: ['Photo Walk', 'Campus Podcast Launch'],
      rating: 4.3,
    ),
  ];
}
