class MentorModel {
  final String id;
  final String name;
  final String designation;
  final String profession;
  final String department;
  final String imageUrl;
  final String about;
  final List<String> expertise;
  final List<String> specializations;
  final List<String> achievements;
  final String experience;
  final double rating;
  final int menteeCount;

  const MentorModel({
    required this.id,
    required this.name,
    required this.designation,
    required this.profession,
    required this.department,
    required this.imageUrl,
    required this.about,
    this.expertise = const [],
    this.specializations = const [],
    this.achievements = const [],
    this.experience = '',
    this.rating = 0.0,
    this.menteeCount = 0,
  });
}

class MockMentorData {
  static const List<MentorModel> mentors = [
    MentorModel(
      id: '1',
      name: 'Dr. Ananya Sharma',
      designation: 'Professor & HOD',
      profession: 'AI/ML Researcher',
      department: 'Computer Science',
      imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400&q=80',
      about:
          'Dr. Ananya Sharma is a pioneering AI researcher with 15+ years of experience in machine learning and deep learning. She has published over 40 research papers in top-tier journals and has mentored 200+ students in their tech careers. Her work on neural network optimization has been cited over 3,000 times globally.',
      expertise: ['Artificial Intelligence', 'Deep Learning', 'NLP', 'Computer Vision'],
      specializations: ['Transformer Models', 'Reinforcement Learning', 'Edge AI'],
      achievements: [
        'Best Paper Award — NeurIPS 2024',
        'Google Research Scholar 2023',
        'Patent holder — Adaptive Learning Systems',
        'TEDx Speaker — Future of AI in Education',
      ],
      experience: '15+ years in AI/ML Research & Academia',
      rating: 4.9,
      menteeCount: 214,
    ),
    MentorModel(
      id: '2',
      name: 'Prof. Rohan Mehta',
      designation: 'Associate Professor',
      profession: 'Full-Stack Architect',
      department: 'Information Technology',
      imageUrl: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=400&q=80',
      about:
          'Prof. Rohan Mehta is a full-stack wizard who transitioned from building scalable systems at Amazon to shaping the next generation of developers. He specializes in cloud-native architectures and has helped 50+ student teams ship production-grade products during hackathons.',
      expertise: ['System Design', 'Cloud Architecture', 'React/Next.js', 'Node.js'],
      specializations: ['Microservices', 'Serverless', 'DevOps & CI/CD'],
      achievements: [
        'Ex-Amazon SDE III',
        'AWS Certified Solutions Architect — Professional',
        'Built systems serving 10M+ users',
        'HackMIT Grand Judge 2024',
      ],
      experience: '12+ years in Software Engineering',
      rating: 4.8,
      menteeCount: 178,
    ),
    MentorModel(
      id: '3',
      name: 'Dr. Priya Deshmukh',
      designation: 'Research Scientist',
      profession: 'Cybersecurity Expert',
      department: 'Computer Engineering',
      imageUrl: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=400&q=80',
      about:
          'Dr. Priya Deshmukh is a cybersecurity researcher and ethical hacking evangelist. She has worked with CERT-In and consulted for Fortune 500 companies on vulnerability assessments. Her workshops on penetration testing are legendary among students.',
      expertise: ['Cybersecurity', 'Ethical Hacking', 'Network Security', 'Cryptography'],
      specializations: ['Penetration Testing', 'Zero Trust Architecture', 'Blockchain Security'],
      achievements: [
        'CERT-In Advisory Board Member',
        'Discovered 12 CVEs in major systems',
        'DEF CON Speaker 2023',
        'Cyberguardian Award 2024',
      ],
      experience: '10+ years in Cybersecurity',
      rating: 4.9,
      menteeCount: 156,
    ),
    MentorModel(
      id: '4',
      name: 'Mr. Vikram Joshi',
      designation: 'Industry Expert',
      profession: 'Product Manager',
      department: 'MBA & Tech',
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80',
      about:
          'Vikram Joshi brings real-world product thinking to academia. As an ex-Google PM, he has shipped features used by billions. He now mentors students on building products people love — from ideation to launch. His "Zero to One" workshop series is a campus favorite.',
      expertise: ['Product Management', 'UX Strategy', 'Growth Hacking', 'Startup Ops'],
      specializations: ['0→1 Product Development', 'Data-Driven Decisions', 'Agile & Scrum'],
      achievements: [
        'Ex-Google Product Manager',
        'Launched 3 products with 100M+ users',
        'Y Combinator Visiting Mentor',
        'Forbes 30 Under 30 — 2021',
      ],
      experience: '9+ years in Product & Strategy',
      rating: 4.7,
      menteeCount: 132,
    ),
    MentorModel(
      id: '5',
      name: 'Dr. Sneha Kulkarni',
      designation: 'Professor',
      profession: 'Data Scientist',
      department: 'Data Science',
      imageUrl: 'https://images.unsplash.com/photo-1594744803329-e58b31de8bf5?w=400&q=80',
      about:
          'Dr. Sneha Kulkarni is a data science powerhouse who has built predictive models for healthcare, finance, and e-commerce. She is passionate about making data science accessible and has created open-source curriculum used by 50+ universities.',
      expertise: ['Data Science', 'Statistical Modeling', 'Python/R', 'Big Data'],
      specializations: ['Predictive Analytics', 'Time Series Forecasting', 'MLOps'],
      achievements: [
        'Kaggle Grandmaster',
        'Open-source contributor — 10K+ GitHub stars',
        'Published 25+ research papers',
        'Best Educator Award — University 2024',
      ],
      experience: '11+ years in Data Science',
      rating: 4.8,
      menteeCount: 195,
    ),
    MentorModel(
      id: '6',
      name: 'Prof. Arjun Nair',
      designation: 'Assistant Professor',
      profession: 'Robotics Engineer',
      department: 'Mechanical & Robotics',
      imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&q=80',
      about:
          'Prof. Arjun Nair blends mechanical engineering with cutting-edge robotics. He led the university RoboWars team to 3 national championships and now mentors students building autonomous systems. His lab has produced 5 patents in the last 2 years.',
      expertise: ['Robotics', 'IoT', 'Embedded Systems', 'Control Theory'],
      specializations: ['Autonomous Navigation', 'ROS2', 'Computer-Aided Design'],
      achievements: [
        '3× National RoboWars Champion',
        '5 patents in autonomous systems',
        'DRDO Research Collaboration',
        'Best Innovation Award — TechFest 2024',
      ],
      experience: '8+ years in Robotics & Mechatronics',
      rating: 4.7,
      menteeCount: 98,
    ),
  ];
}
