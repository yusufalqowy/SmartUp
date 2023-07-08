// ignore_for_file: constant_identifier_names

enum Gender{
  none,
  man,
  woman;
  bool get isMan => this == man;
  bool get isWoman => this == woman;
  String get value{
    switch(this){
      case Gender.woman: return "Perempuan";
      case Gender.man: return "Laki-laki";
      default: return "None";
    }
  }

}

enum Degree{
  NONE,
  SD,
  SMP,
  SMA,
  SMK;
}