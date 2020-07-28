import 'package:myapp/components/screens/ConnectElonScreen/ConnectElonScreen.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';
import 'package:myapp/components/screens/HomeScreen/HomeScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreen.dart';
import 'package:myapp/components/screens/ProgramsScreen/ProgramsScreen.dart';
import 'package:myapp/components/screens/CompeteScreen/CompeteScreen.dart';

class Routes {
  static const String controller = ControllerScreen.routeName;
  static const String home = HomeScreen.routeName;
  static const String bluetoothConnect = ConnectElonScreen.routeName;
  static const String programs = ProgramsScreen.routeName;
  static const String program = ProgramScreen.routeName;
  static const String compete = CompeteScreen.routeName;
}
