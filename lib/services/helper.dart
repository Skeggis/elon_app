import 'dart:math' as math;

String secondsToMinutes(int seconds) {
  if (seconds <= 60) {
    return '${seconds}s';
  } else {
    int min = (seconds / 60).floor();
    return '${min}m';
  }
}

String secondsToFormattedTime(int seconds) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  Duration duration = Duration(seconds: seconds);

  if (duration.inHours == 0) {
    if(duration.inMinutes == 0){
      if(duration.inSeconds < 10){
        return '${duration.inSeconds}s';
      }
      return '${twoDigits(duration.inSeconds)}s';
    } else {
      return '${duration.inMinutes}m ${twoDigits(duration.inSeconds.remainder(60))}s';
    }
  } else {
    
    return "${duration.inHours}h ${twoDigits(duration.inMinutes.remainder(60))}m ${twoDigits(duration.inSeconds.remainder(60))}s";
  }
}

double degToRad(double deg){  
  return deg * (math.pi / 180);
}

