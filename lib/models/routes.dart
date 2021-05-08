import 'package:ungcamp_signup/screens/events_screen.dart';
import 'package:ungcamp_signup/screens/my-tickets.dart';
import 'package:ungcamp_signup/screens/organizer-login-screen.dart';

var routes = {
  kHomeRoute: (context) => Events(),
  kEventsRoute: (context) => Events(),
  kMyTicketsRoute: (context) => MyTickets(),
  kOrganizerLoginRoute: (context) => OrganizerLogin(),
};

const kHomeRoute = '/';
const kEventsRoute = '/events';
const kMyTicketsRoute = '/myTickets';
const kOrganizerLoginRoute = '/organizer/login';