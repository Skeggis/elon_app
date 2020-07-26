String secondsToMinutes(int seconds){
  if(seconds <= 60){
    return '${seconds}s';
  } else {
    int min = (seconds / 60).floor();
    return '${min}m';
  }
}