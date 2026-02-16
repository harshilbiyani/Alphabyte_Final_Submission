import '../../home/data/mock_home_data.dart';

class MockProfileData {
  static const String userName = "Ansh D";
  static const String prn = "12015842";
  static const String email = "ansh.d@college.edu";
  static const String department = "Computer Engineering";
  static const String division = "A";

  static const Map<String, int> stats = {
    'Registered': 12,
    'Attended': 8,
    'Upcoming': 4,
  };

  static final List<String> interests = [
    'Technical', 'Gaming', 'Music', 'Coding'
  ];

  static final List<EventModel> registeredEvents = [
    MockHomeData.urgentEvents[0],
    MockHomeData.feedEvents[1], 
  ];

  static final List<EventModel> attendedEvents = [
    MockHomeData.feedEvents[0], 
    MockHomeData.feedEvents[2], 
  ];
  
  static final List<EventModel> pastEvents = [
    MockHomeData.feedEvents[3], 
  ];
}
