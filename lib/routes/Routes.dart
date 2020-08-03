import 'package:myapp/components/screens/ConnectElonScreen/ConnectElonScreen.dart';
import 'package:myapp/components/screens/ControllerScreen/ControllerScreen.dart';
import 'package:myapp/components/screens/HomeScreen/HomeScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreen.dart';
import 'package:myapp/components/screens/ProgramScreen/ProgramScreenCreate.dart';
import 'package:myapp/components/screens/ProgramsScreen/ProgramsScreen.dart';
import 'package:myapp/components/screens/CompeteScreen/CompeteScreen.dart';
import 'package:myapp/components/screens/LoginSignUpScreen/LoginScreen.dart';
import 'package:myapp/components/screens/LoginSignUpScreen/SignUpScreen.dart';
import 'package:myapp/Root.dart';

class Routes {
  static const String controller = ControllerScreen.routeName;
  static const String home = HomeScreen.routeName;
  static const String bluetoothConnect = ConnectElonScreen.routeName;
  static const String programs = ProgramsScreen.routeName;
  static const String program = ProgramScreen.routeName;
  static const String compete = CompeteScreen.routeName;
  static const String createProgram = ProgramScreenCreate.routeName;
  static const String login = LoginScreen.routeName;
  static const String signUp = SignUpScreen.routeName;
  static const String root = Root.routeName;
}
