int getAge(DateTime birthDay) {
  final now = DateTime.now();
  var age = now.year - birthDay.year;
  if (now.month < birthDay.month ||
      (now.month == birthDay.month && now.day < birthDay.day)) {
    age--;
  }
  return age;
}
