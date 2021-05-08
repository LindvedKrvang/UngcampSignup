import 'package:flutter/material.dart';
import 'package:ungcamp_signup/screens/events_screen.dart';
import 'package:ungcamp_signup/screens/my-tickets.dart';

var routes = {
  kHomeRoute: (context) => Events(),
  kEventsRoute: (context) => Events(),
  kMyTicketsRoute: (context) => MyTickets(),
};

const kHomeRoute = '/';
const kEventsRoute = '/events';
const kMyTicketsRoute = '/myTickets';