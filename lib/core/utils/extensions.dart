extension on String{
  String capitalizeEachWord() {
    var result = this[0].toUpperCase();
    for (int i = 1; i < length; i++) {
      if (this[i - 1] == " ") {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
      }
    }
    return result;
  }

  String capitalizeFirst() {
    var result = this[0].toUpperCase();
    bool cap = true;
    for (int i = 1; i < length; i++) {
      if (this[i - 1] == " " && cap == true) {
        result = result + this[i].toUpperCase();
      } else {
        result = result + this[i];
        cap = false;
      }
    }
    return result;
  }
}