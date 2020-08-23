import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:myapp/components/screens/ProgramScreen/components/RoutinesList.dart';
import 'package:myapp/services/models/Program.dart';
import 'package:myapp/services/models/scopedModels/DeviceModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ProgramModel extends Model {
  final String url = 'https://elon-server.herokuapp.com/programs';

  Program program;
  List<ItemScrollController> scrollControllers =
      new List<ItemScrollController>();

  Future fetchProgram(id) async {
    try {
      print(id);
      var response = await http.get('$url/$id');
      if (response.statusCode == 200) {
        var jsonProgram = jsonDecode(response.body)['result'];
        program = Program.fromJson(jsonProgram);
        for (int i = 0; i < program.routines.length; i++) {
          scrollControllers.add(new ItemScrollController());
        }
        notifyListeners();
      }
    } catch (e) {
      print('error fetching program');
      print(e);
    }
  }

  Timer timer;
  void clearTimer() {
    if (timer != null) {
      print('clearing timer');
      timer.cancel();
    }
  }

  BuildContext currentContext;
  bool playing = false;
  bool paused = false;
  bool countdown = false; //countdown when play is pressed
  static int initialCountDown = 3;
  int countDownTime = initialCountDown;
  int currentSet = 0;
  int currentRoutine = 0;
  int currentRoutineRound = 0;
  int currentShot = -1;
  bool shooting = true; // shooting or resting
  bool routineResting = false;
  bool setResting = false;
  void play(BuildContext context) {
    currentContext = context;
    countdown = true;
    notifyListeners();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!paused) {
        countDownTime -= 1;
        notifyListeners();

        if (countDownTime == 0) {
          countdown = false;
          playing = true;
          countDownTime = initialCountDown;
          currentShot = 0;
          notifyListeners();
          step();
          timer.cancel();
        }
      }
    });
  }

  void pause() {
    //hmm
    paused = true;
    notifyListeners();
  }

  void continuePlaying() {
    paused = false;
    notifyListeners();
  }

  void step() {
    if (currentShot + 1 > program.routines[currentRoutine].routineDesc.length &&
        shooting) {
      if (currentRoutineRound + 1 == program.routines[currentRoutine].rounds) {
        if (currentRoutine + 1 == program.routines.length) {
          if (currentSet + 1 == program.sets) {
            //done
            print('done');
          } else {
            routineResting = true;
            notifyListeners();
            timer = Timer.periodic(Duration(seconds: 1), (timer) {
              if (!paused) {
                program.routines[currentRoutine].displayTimeout -= 1;
                notifyListeners();
                if (program.routines[currentRoutine].displayTimeout == 0) {
                  nextSet();
                  timer.cancel();
                }
              }
            });
          }
        } else {
          print('heer');
          routineResting = true;
          notifyListeners();
          timer = Timer.periodic(Duration(seconds: 1), (timer) {
            if (!paused) {
              program.routines[currentRoutine].displayTimeout -= 1;
              notifyListeners();
              if (program.routines[currentRoutine].displayTimeout == 0) {
                nextRoutine();
                step();
                timer.cancel();
              }
            }
          });
        }
      } else {
        currentShot = 0;
        currentRoutineRound += 1;

        resetShotTimeouts();

        step();
      }
    } else {
      basicStep();
    }
    notifyListeners();
  }

  void basicStep() async {
    if (routineResting) {
      routineResting = false;
    }

    if (shooting) {
      scrollControllers[currentRoutine].scrollTo(
          index: currentShot,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut);
      await DeviceModel.of(currentContext).sendCommand(
          program.routines[currentRoutine].routineDesc[currentShot].toString());
      await DeviceModel.of(currentContext).shotFinished(step);
      print('her');
      shooting = false;
    } else {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (!paused) {
          program.routines[currentRoutine].routineDesc[currentShot]
              .displayTimeout -= 1;
          print('countdown');
          notifyListeners();
          if (program.routines[currentRoutine].routineDesc[currentShot]
                  .displayTimeout ==
              0) {
            currentShot += 1;
            shooting = true;
            step();
            timer.cancel();
          }
        }
      });
    }
  }

  void nextRoutine() {
    resetShotTimeouts();
    resetRoutineTimeout();
    currentRoutine += 1;
    currentShot = 0;
    currentRoutineRound = 0;
    shooting = true;
  }

  void nextSet() {
    resetShotTimeouts();
    resetRoutineTimeout();
    routineResting = false;
    setResting = true;
    notifyListeners();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!paused) {
        program.displayTimeout -= 1;
        notifyListeners();
        if (program.displayTimeout == 0) {
          currentSet += 1;
          currentRoutine = 0;
          currentShot = 0;
          currentRoutineRound = 0;
          shooting = true;
          setResting = false;
          program.resetDisplay();
          step();
          timer.cancel();
        }
      }
    });
  }

  void resetShotTimeouts() {
    for (int i = 0;
        i < program.routines[currentRoutine].routineDesc.length;
        i++) {
      program.routines[currentRoutine].routineDesc[i].resetDisplay();
    }
    notifyListeners();
  }

  bool isRoutineResting(int index) {
    return routineResting && currentRoutine == index;
  }

  resetRoutineTimeout() {
    program.routines[currentRoutine].resetDisplay();
  }

  static ProgramModel of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<ProgramModel>(context,
          rebuildOnChange: rebuildOnChange == null ? false : rebuildOnChange);
}
